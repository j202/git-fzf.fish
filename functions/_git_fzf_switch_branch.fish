function _git_fzf_switch_branch --description "Search git branches. Return a git switch command with the selected branch name."
    set --function cmd "git switch"
    set --function branch (_git_fzf_branch_select)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
