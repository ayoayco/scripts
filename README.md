# Ayo's Scripts

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

## Set up

1\. Clone repo
``` bash
# By default this should be inside ~/Projects/ directory
# otherwise, you have to update the config in the next step
$ git clone git@git.sr.ht:~ayoayco/scripts
$ cd scripts
```

2\. Copy config (and update values as needed!)
``` bash
$ cp example.conf ~/ayo.conf
```

3\. Install some dependencies
1. [Typora](https://typora.io) - used as an alternative editor for notes (using flag `-t`)
1. `timeout` - install on mac via coreutils: `brew install coreutils`
1. `ollama` - running a locall LLM via ollama. See [installation on linux](https://ollama.com/download/linux)

## Scripts

1. ayo - parent command, lists all available scripts or accepts parameters
1. journal - creates a new journal entry if it doesn’t exist yet; opens on editor
  1. append - append one thought at the end of the day's entry
1. notes - notes management
1. git (g) - args can be list of files to commit & push
  1. stat (gs) - git status
  1. push (gp) - git push

## Features
1. Autosync for notes & journal via git

## Planned

1. blog - tools for blogging (eg, bn - generate blog from a note)
1. config - create configuration for variables (eg, editor, locations)

---

*Just keep scripting. :)*
*A project by [Ayo](https://ayo.ayco.io)*
