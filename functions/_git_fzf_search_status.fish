function _git_fzf_search_status --description "Search the output of git status. Return the selected file paths."
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_git_fzf_search_status: Not in a git repository.' >&2
    else
        set --function preview_cmd '_fzf_preview_changed_file {}'
        if set --query fzf_diff_highlighter
            set --function preview_cmd "$preview_cmd | $fzf_diff_highlighter"
        end

        # See _git_fzf_branch_select for explanation of the while read pattern.
        set --function selected_paths
        git -c color.status=always status --short | \
        _fzf_wrapper --ansi \
            --multi \
            --prompt="Git Status> " \
            --query=(commandline --current-token) \
            --preview=$preview_cmd \
            --nth="2.." \
            $fzf_git_status_opts | \
        while read --local line
            set --function --append selected_paths $line
        end
        set --function _fzf_status $pipestatus[2]

        if test $_fzf_status -eq 0
            # git status --short automatically escapes the paths of most files for us so not going to bother trying to handle
            # the few edges cases of weird file names that should be extremely rare (e.g. "this;needs;escaping")
            set --function cleaned_paths

            for path in $selected_paths
                if test (string sub --length 1 $path) = R
                    # path has been renamed and looks like "R LICENSE -> LICENSE.md"
                    # extract the path to use from after the arrow
                    set --function --append cleaned_paths (string split -- "-> " $path)[-1]
                else
                    set --function --append cleaned_paths (string sub --start=4 $path)
                end
            end

            echo (string join ' ' $cleaned_paths)
        end
    end

end
