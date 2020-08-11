#!/usr/bin/env bash

# Helpers
prog_dir=$(realpath $(dirname "$0"))
. "$prog_dir/lib"

# Options
while getopts "h" opt; do
    case "h" in
	   h) cat <<EOF
ls - List workspaces.

USAGE

    ls [-h]

OPTIONS

    -h    Show this help text.

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

table_f=$(mktemp "$prog_dir/.ls-table-XXXXX")
rm_table_f() {
    rm -f "$table_f"
}
trap rm_table_f ERR EXIT

for workspace in $(ls -d void-packages-*); do
    alias="-"
    if [ -f "$ALIASES_DIR/$workspace" ]; then
	   alias=$(cat "$ALIASES_DIR/$workspace")
	   check "Failed to read alias for $workspace workspace"
    fi

    echo "$workspace $alias" >> "$table_f"
done

first_line="true"
while read -r line; do
    if [ -n "$first_line" ]; then
	   echo "$line  Notes"
	   first_line=""
	   continue
    fi

    workspace=$(echo "$line" | awk '{ print $1 }')

    note=""
    if [ -f "$NOTES_DIR/$workspace" ]; then
	   note=$(cat "$NOTES_DIR/$workspace")
	   check "Failed to read note for $workspace workspace"
    fi

    echo "$line  $note"
done <<< $(column -t --table-columns Workspace,Alias --table-right Alias -s' ' "$table_f")
