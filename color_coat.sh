#!/bin/bash
# @Function
# cat lines colorfully. coat means *CO*lorful c*AT*.
#
# @Usage
#   $ alias coat="/bin/color.sh"
#   $ coat /path/to/file1



set -e
set -o pipefail

# NOTE: $'foo' is the escape sequence syntax of bash
readonly ec=$'\033' # escape char
readonly eend=$'\033[0m' # escape end

readonly -a ECHO_COLORS=(31 32 37 34 33 35 36)
COUNT=0
colorEcho() {
    local color="${ECHO_COLORS[COUNT++ % ${#ECHO_COLORS[@]}]}"
    # check isatty in bash https://stackoverflow.com/questions/10022323
    # if stdout is console, turn on color output.
    [ -t 1 ] && echo "$ec[1;${color}m$@$eend" || echo "$@"
}

# Bash read line does not read leading spaces https://stackoverflow.com/questions/29689172
cat "$@" | while IFS= read -r line; do
    colorEcho "$line"
done