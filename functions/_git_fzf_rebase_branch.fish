function _git_fzf_rebase_branch --description "Search git branches. Return a git rebase command with the selected branch name."
    set --function cmd "git rebase"
    set --function branch (_git_fzf_branch_select)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
