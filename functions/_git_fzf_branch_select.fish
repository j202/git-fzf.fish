function _git_fzf_branch_select --description "Search git branches. Return the selected branch name(s)."

    argparse R/noremote -- $argv
    or return

    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_git_fzf_branch_select: Not in a git repository.' >&2
        return 1
    end

    set --function git_current_branch (_git_fzf_current_branch)

    set --function local_branches \
        (git for-each-ref --format='%(refname:short)' refs/heads | \
            awk -v current="$git_current_branch" '$0 != current { print $0 "|\033[95mLocal\033[39m" }')

    # Exclude bare remote names (e.g. "origin", which %(refname:short) produces for
    # refs/remotes/origin/HEAD) and explicit /HEAD entries (e.g. "origin/HEAD").
    set --function remote_branches \
        (git for-each-ref --format='%(refname:short)' refs/remotes | \
            string match --regex --invert '^([^/]+|.*/HEAD)$' | \
            awk '{ print "\033[93m" $0 "\033[39m|\033[95mRemote\033[39m" }')

    set --function git_branches

    if test -n "$git_current_branch"
        set --function --append git_branches \
            (builtin set_color brred; echo -n $git_current_branch; builtin set_color normal; echo -n "|"; builtin set_color brmagenta; echo -n "Current"; builtin set_color normal)
        if test (count $local_branches) -gt 0 -o (count $remote_branches) -gt 0
            set --function --append git_branches ""
        end
    end

    if test (count $local_branches) -gt 0
        set --function --append git_branches $local_branches
        if test (count $remote_branches) -gt 0
            set --function --append git_branches ""
        end
    end

    set --function --append git_branches $remote_branches

    # Run fzf outside of command substitution — Fish runs the last stage of a
    # pipeline in the current process, so `while read` can write to function-scoped
    # variables. $pipestatus[3] captures fzf's exit code (printf|awk|fzf|while).
    set --function selected_branch_lines
    printf '%s\n' $git_branches | \
        awk -F'|' '
            { lines[++n] = $0
              vis = $1; gsub(/\033\[[0-9;]*[mK]/, "", vis)
              if (length(vis) > maxw) maxw = length(vis) }
            END {
                for (i = 1; i <= n; i++) {
                    $0 = lines[i]
                    if ($0 !~ /\|/) { print ""; continue }
                    vis = $1; gsub(/\033\[[0-9;]*[mK]/, "", vis)
                    printf "%s%-*s  %s\n", $1, maxw - length(vis), "", $2
                }
            }' | \
        _fzf_wrapper --ansi \
            --multi \
            --prompt="Git Branch> " \
            --nth="1" | \
        while read --local line
            set --function --append selected_branch_lines $line
        end
    set --function _fzf_status $pipestatus[3]

    if test $_fzf_status -eq 0
        for line in $selected_branch_lines
            builtin string match --quiet --regex '^\s*(?<branch_name>.*?)\s*(?<local_or_remote>Local|Remote|Current)\s*$' "$line"
            if builtin string match --quiet Current $local_or_remote
                set --function --append selected_branches $branch_name
            else if builtin string match --quiet Local $local_or_remote
                set --function --append selected_branches $branch_name
            else if builtin string match --quiet Remote $local_or_remote
                if set --local --query _flag_noremote
                    set --function --append selected_branches (
                        builtin string replace --regex '^.*?/(.*)' '$1' $branch_name
                    )
                else
                    set --function --append selected_branches $branch_name
                end
            end
        end
        echo (string join ' ' $selected_branches)
    end

end
