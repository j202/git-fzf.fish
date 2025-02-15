function _git_fzf_push_origin_current_branch --description "Return a git push command specifying the origin remote and the current branch"
    set --function cmd "git push origin"
    set --function branch (_git_fzf_current_branch)
    if test -n "$branch"
        echo $cmd $branch
    end
    commandline --function repaint
end
