function _git_fzf_branch_delete --description "Search git branches. Return a git delete command with the selected branch name."
    set --function cmd "git branch --delete"
    set --function branch (_git_fzf_branch_select)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
