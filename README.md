# Scripts

Personal BASH scripts for productivity

## Setup
1\. clone the repo
```bash
$ git clone git@git.sr.ht:~ayoayco/scripts
```

2\. Copy config and populate
```bash
$ cp example.config ~/ayo.conf
$ vim ~/ayo.conf
```

3\. update your .bashrc to add an alias for the parent command `scripts/ayo.sh`

## Dependencies
1. Typora - used as default editor for notes

## Scripts

1. ayo - parent command, lists all available scripts or accepts parameters
2. journal - creates a new journal entry if it doesn’t exist yet; opens on editor

## Planned

1. config - create configuration for variables (eg, editor, locations)
2. journal sync - sync journal entries
