function _git_fzf_add_files --description "Search the output of git log and preview commits. Return a git commit --fixup command with the selected hash."
    set --function cmd "git add"
    set --function files (_git_fzf_search_status)
    if test -n "$files"
        echo "$cmd $files"
    end
    commandline --function repaint
end
