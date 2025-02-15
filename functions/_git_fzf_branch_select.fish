function _git_fzf_branch_select --description "Search git branches. Return the selected branch name(s)."

    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_git_fzf_branch_select: Not in a git repository.' >&2
    else
        # Ensure the __fish_git_branches function is visible by loading git completions.
        for dir in $fish_complete_path
            if test -f $dir/git.fish
                . $dir/git.fish
            end
        end
        set --function selected_branch_lines (
            __fish_git_branches | \
            _fzf_wrapper --ansi \
                --multi \
                --prompt="Git Branch> " \
                --nth="1"
        )

        if test $status -eq 0
            for line in $selected_branch_lines
                set --function --append selected_branches ( \
                    builtin string replace --regex '^\s*(.*)\s*(Local|Remote)\s*Branch\s*$' '$1' "$line" \
                )
            end
            echo (string join ' ' $selected_branches)
        end
    end

end
