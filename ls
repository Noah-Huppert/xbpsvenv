#!/usr/bin/env bash

# Helpers
prog_dir=$(dirname $(realpath "$0"))
. "$prog_dir/lib"

# Options
while getopts "h" opt; do
    case "$opt" in
	   h) cat <<EOF
ls - List workspaces.

USAGE

    ls [-h]

OPTIONS

    -h    Show this help text.

BEHAVIOR

    First a table header line is printed. Next a list of workspaces is printed.
    Each line is a workspace. Properties are delimited by spaces. The properties 
    of workspaces which are listed, in order of left to right:

      - If the workspace is the default, "@" indicates it is, "-" not.
      - Name. One token.
      - Alias. If none "-". One token.
      - Note. The remainder of tokens on a line. If none "-".

EOF
		 exit 0
		 ;;
	   '?') die "Unknown option" ;;
    esac
done

shift $((OPTIND-1))

# List
cd "$WORKSPACES_DIR"
check "Failed to change to workspaces directory"

table_f=$(mktemp "$WORKSPACES_DIR/.ls-table-XXXXX")
check "Failed to make temporary file to save workspaces list"

rm_table_f() {
    rm -f "$table_f"
}
trap rm_table_f ERR EXIT
echo "Default Workspace Alias" > "$table_f"

default_workspace=$("$prog_dir/usectx")
check "Failed to retrieve the name of the current default workspace"

if ls -d void-packages-* &> /dev/null; then
    for workspace in $(ls -d void-packages-*); do
	   alias="-"
	   if [ -f "$ALIASES_DIR/$workspace" ]; then
		  raw_alias=$(cat "$ALIASES_DIR/$workspace")
		  check "Failed to read alias for $workspace workspace"

		  if [ -n "$raw_alias" ]; then
			 alias="$raw_alias"
		  fi
	   fi

	   default_mark="-"
	   if [[ "$workspace" == "$default_workspace" ]]; then
		  default_mark="@"
	   fi

	   echo "$default_mark $workspace $alias" >> "$table_f"
    done
fi

first_line="true"
while read -r line; do
    if [ -n "$first_line" ]; then
	   echo "$line  Notes"
	   first_line=""
	   continue
    fi

    workspace=$(echo "$line" | awk '{ print $1 }')

    note="-"
    if [ -f "$NOTES_DIR/$workspace" ]; then
	   raw_note=$(cat "$NOTES_DIR/$workspace")
	   check "Failed to read note for $workspace workspace"

	   if [ -n "$raw_note" ]; then
		  note="$raw_note"
	   fi
    fi

    echo "$line  $note"
done <<< $(column -t --table-columns Default,Workspace,Alias --table-noheadings --table-right Alias -s' ' "$table_f")
