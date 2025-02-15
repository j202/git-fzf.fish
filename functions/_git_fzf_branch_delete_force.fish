function _git_fzf_branch_delete_force --description "Search git branches. Return a git delete --force command with the selected branch name."
    set --function cmd "git branch --delete --force"
    set --function branch (_git_fzf_branch_select)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
