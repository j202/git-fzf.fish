function _git_fzf_echo_branch --description "Search git branches. Return the selected branch name."
    set --function branch (_git_fzf_branch_select)
    if test -n "$branch"
        commandline --current-token --replace $branch
    end
    commandline --function repaint
end
