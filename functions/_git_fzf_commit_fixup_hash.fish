function _git_fzf_commit_fixup_hash --description "Search the output of git log and preview commits. Return a git commit --fixup command with the selected hash."
    set --function cmd "git commit --fixup"
    set --function hash (_git_fzf_hash_select)
    if test -n "$hash"
        echo $cmd $hash
    end
    commandline --function repaint
end
