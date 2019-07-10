# duply-status setup

## General setup
```bash
mkdir ~/.config/backup_status
mkdir ~/.cache/backup_status
```

## For each duply backup:
Say your backup name is `my-backup-name`.
Setup pre and post hook files in the config directory for the backup with the following contents:

```bash
# pre
#!/bin/bash
~/.dotfiles/scripts/duply-status/pre-hook my-backup-name

# post
#!/bin/bash
~/.dotfiles/scripts/duply-status/post-hook my-backup-name
```

Add a file `~/.config/backup_status/my-backup-name` with the number of seconds after which the backup is considered old.
For example 423000 for 5 days.
