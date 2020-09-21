#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT="$(realpath "$DIR"/..)"

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd > /dev/null
}

cd "$ROOT"/state

for fspath in *; do
  [[ -n ${1:-} && $1 != "$fspath" ]] && continue

  if [[ ${fspath//-/} =~ ^[[:xdigit:]]{32}$ ]]; then
    pushd "$fspath"
      echo "** Operating on disk $fspath"
      echo '** Deleting old links...'
      find . -type l -delete

      echo '** Linking source files...'
      for p in lib bin; do
        pushd $p
          tpath="$ROOT"/src/"$p"
          for f in "$tpath"/*; do
            ln -sfv "$f" "$(basename "$f")"
          done
        popd
      done

      printf '** Done.\n\n'
    popd
  fi
done
