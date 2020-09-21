#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT="$(realpath "$DIR"/..)"

TUSER='minecraft'
THOST='adalind.mkaito.net'
SSHCMD='ssh'
TPATH='::state/world/opencomputers/'
SPATH="$ROOT/state/"

RSYNCOPTS=(-avzzpL -e "$SSHCMD" --exclude '/state' --delete)

taction="${1:-push}"
if [[ $taction == push ]]; then
  echo '** Pushing opencomputers state to server'
  rsync "${RSYNCOPTS[@]}" "$SPATH" "${TUSER}@${THOST}${TPATH}"
elif [[ $taction == pull ]]; then
  echo '** Pulling opencomputers disks from server'
  rsync "${RSYNCOPTS[@]}" "${TUSER}@${THOST}${TPATH}" "$SPATH"
fi

echo '** Done'
