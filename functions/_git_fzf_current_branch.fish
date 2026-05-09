function _git_fzf_current_branch --description "Return the name of the current git branch."
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_git_fzf_current_branch: Not in a git repository.' >&2
    else
        git symbolic-ref --quiet --short HEAD 2>/dev/null
    end
end
