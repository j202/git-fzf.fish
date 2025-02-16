# git-fzf.fish

Add git abbreviations to your fish shell.

# Pre-requisites

This plugin requires that the [fzf.fish](https://github.com/PatrickF1/fzf.fish) plugin be installed.

# Installation

Install with [fisher](https://github.com/jorgebucaran/fisher).
```fish
fisher install j202/git-fzf
```

# Abbreviations

To see the available abbreviations, see `git_fzf.fish` in the `conf.d` directory of your fish configuration directory (normally `~/.config/fish`).

# Environment variables

`git-fzf.fish` uses the `_git_fzf_commit_message_style` environment variable 
when populating commit messages. It is used to determine if an attempt should be made to parse the current branch name and extract a Jira issue code. To enable this feature, set the variable to `JIRA`.
```fish
set --universal _git_fzf_commit_message_style JIRA
```