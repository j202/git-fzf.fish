# Add
abbr --add ga --position command --function _git_fzf_add_files

# Branch
abbr --add gb --position command git branch
abbr --add gba --position command git branch --all
abbr --add gbd --position command --function _git_fzf_branch_delete
abbr --add gbD --position command --function _git_fzf_branch_delete_force
abbr --add gbnm --position command git branch --no-merged

# Checkout
abbr --add gcb --position command git checkout --branch
abbr --add gco --position command --function _git_fzf_checkout_branch
abbr --add gcoh --position command --function _git_fzf_checkout_hash
abbr --add gcor --position command git checkout --recurse-submodules

# Clean
abbr --add gclean --position command git clean --interactive -d
abbr --add gfclean --position command git clean -dx --force

# Clone
abbr --add gcl --position command git clone --recurse-submodules

# Commit
abbr --add gc --position command git commit
abbr --add gca --position command git commit --amend
abbr --add gcf --position command --function _git_fzf_commit_fixup_hash
abbr --add gcm --position command --set-cursor --function _git_fzf_commit_message

# Diff
abbr --add gd --position command git diff
abbr --add gdd --position command git difftool --dir-diff --gui

# Fetch
abbr --add gf --position command git fetch

# Log
abbr --add glog --position command git log --decorate --oneline --graph
abbr --add gloga --position command git log --decorate --oneline --graph --all
abbr --add gls --position command git log --stat

# Pull
abbr --add gl --position command git pull

# Push
abbr --add gp --position command --function _git_fzf_push_origin_current_branch
abbr --add gpf --position command --function _git_fzf_push_force_with_lease_origin_current_branch
abbr --add gpsup --position command --function _git_fzf_push_set_upstream_origin_current_branch

# Rebase
abbr --add grb --position command git rebase
abbr --add grbb --position command --function _git_fzf_rebase_branch
abbr --add grbi --position command git rebase --interactive
abbr --add grbbi --position command --function _git_fzf_rebase_branch_interactive

# Status
abbr --add gst --position command git status
abbr --add gss --position command git status --short
abbr --add gsb --position command git status --short --branch

# Switch
abbr --add gsw --position command --function _git_fzf_switch_branch
