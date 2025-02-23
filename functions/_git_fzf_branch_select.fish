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

        set --function git_current_branch (_git_fzf_current_branch)
        set --function git_branches \
            (builtin set_color brred; echo -n $git_current_branch; builtin set_color normal; echo -n "|"; builtin set_color brmagenta; echo -n "Current"; builtin set_color normal) \
            (echo -e "") \
            (awk -v current_branch="$git_current_branch" '{ if (($1 != current_branch) && ($2 == "Local")) { print $1 "|\033[95m" $2 "\033[39m" } }' < (__fish_git_branches | psub)) \
            (echo -e "") \
            (awk '{ if ($2 == "Remote") { print "\033[93m" $1 "\033[39m|\033[95m" $2 "\033[39m" } }' < (__fish_git_branches | psub))

        set --function selected_branch_lines (
            echo $git_branches\n | \
            column --table --keep-empty-lines --separator '|' | \
            _fzf_wrapper --ansi \
                --multi \
                --prompt="Git Branch> " \
                --nth="1"
        )

        if test $status -eq 0
            for line in $selected_branch_lines
                builtin string match --quiet --regex '^\s*(?<branch_name>.*?)\s*(?<local_or_remote>Local|Remote|Current)\s*$' "$line"
                if builtin string match --quiet "Current" $local_or_remote
                    set --function --append selected_branches $branch_name
                else if builtin string match --quiet "Local" $local_or_remote 
                    set --function --append selected_branches $branch_name
                else if builtin string match --quiet "Remote" $local_or_remote
                    set --function --append selected_branches (
                        builtin string replace --regex '^.*?/(.*)' '$1' $branch_name
                    )
                end
            end
            echo (string join ' ' $selected_branches)
        end
    end

end
