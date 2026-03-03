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


## Examples

To ask the AI a question

```
ayo ai "Why is the sky blue?"
```

I also set a shortcut alias to `ayo` with `yo` because I'm lazy

```
yo ai "But why is the sky orange on sunrise / sunset?"
```

If I want to use the `journal` script, I can use the shortcut `j`. The following will create a new file for the current day if it doesn't exist yet, otherwise it open an editor to the existing entry

```
yo j
```

## Features
1. Create journal entry for the day, or edit if it already exists
1. Access `ollama` LLM with ease
1. Operating System stuff like, update packages, adjust display to some preferences, etc.

## Scripts
1. ayo - parent command, lists all available scripts or accepts parameters
1. journal (j) - creates a new journal entry if it doesn’t exist yet; opens on editor
  1. append (ja) - append one thought at the end of the day's entry
1. notes - notes management
1. git (g) - args can be list of files to commit & push
  1. stat (gs) - git status
  1. push (gp) - git push

## Planned
1. blog - tools for blogging (eg, bn - generate blog from a note)
1. config - create configuration for variables (eg, editor, locations)

---

*Just keep scripting. :)*
*A project by [Ayo](https://ayo.ayco.io)*
