function _git_fzf_push_force_with_lease_origin_current_branch --description "Return a git push force-with-lease command specifying the origin remote and the current branch"
    set --function cmd "git push --force-with-lease origin"
    set --function branch (_git_fzf_current_branch)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
