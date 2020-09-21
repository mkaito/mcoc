# OpenComputers scripts

This repo contains workflow scripts and general lua debauchery for use with
OpenComputers, a mod for Minecraft that implements realistic computers and
a Lua-based operating system called OpenOS.

## Usage

You'll need a POSIX environment. Make sure you have an SSH key that can access
the minecraft rsync module on the target server.

Run `scripts/sync.sh pull` to populate the local state folder. This will copy
all defined disks from the server.

Run `scripts/link.sh` to symlink all files defined under `src` to their
corresponding place on all OC disks. You can pass a disk UUID as argument to
operate only on that disk too.

Do your lua hacking thing.

Run `scripts/sync.sh push` to push all disks back to the server. Note that this
will overwrite any changes made on the remote disks since the last pull. If you
are worried about overwriting something, pull and link before pushing.
