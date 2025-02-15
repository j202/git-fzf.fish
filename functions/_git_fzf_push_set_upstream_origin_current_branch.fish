function _git_fzf_push_set_upstream_origin_current_branch --description "Return a git push --set-upstream command specifying the origin remote and the current branch"
    set --function cmd "git push --set-upstream origin"
    set --function branch (_git_fzf_current_branch)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
