# OpenComputers scripts

This repo contains workflow scripts and general lua debauchery for use with
OpenComputers, a mod for Minecraft that implements realistic computers and
a Lua-based operating system called OpenOS.

## Dependencies

* `moonscript` 0.5.0
* `lua` 5.3

## Usage

All moonscript files live under `/src`, and the structure mirrors that of the
target drives. For example, `src/bin/lsxnet.moon` will end up on all drives as
`bin/lsxnet.lua`.

## Build process

You'll need a POSIX environment. Make sure you have an SSH key that can access
the minecraft rsync module on the target server.

The main interface is through the `Makefile`.

`make` will compile all moonscript files into the `build` folder.

`make pull` will pull the contents of all defined drives from the server into
the `state` folder.

`make link` will symlink all compiled lua files into all defined drives.

`make push` will push the contents of drives to the server.

For convenience, `make push` will pull, clean, compile, symlink and then push.
This minimizes the risk of accidentally overwriting anything that might have
changed since the last pull.
