function _git_fzf_hash_select --description "Search the output of git log and preview commits. Return the selected commit hash."
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo '_git_fzf_hash_select: Not in a git repository.' >&2
    else
        if not set --query fzf_git_log_format
            # %h gives you the abbreviated commit hash, which is useful for saving screen space, but we will have to expand it later below
            set --function fzf_git_log_format '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'
        end

        set --function preview_cmd 'git show --color=always --stat --patch {1}'
        if set --query fzf_diff_highlighter
            set --function preview_cmd "$preview_cmd | $fzf_diff_highlighter"
        end

        # See _git_fzf_branch_select for explanation of the while read pattern.
        set --function selected_log_lines
        git log --no-show-signature --color=always --format=format:$fzf_git_log_format --date=short | \
        _fzf_wrapper --ansi \
            --multi \
            --scheme=history \
            --prompt="Git Log> " \
            --preview=$preview_cmd \
            $fzf_git_log_opts | \
        while read --local line
            set --function --append selected_log_lines $line
        end
        set --function _fzf_status $pipestatus[2]

        if test $_fzf_status -eq 0
            for line in $selected_log_lines
                set --function abbreviated_commit_hash (string split --field 1 " " $line)
                set --function full_commit_hash (git rev-parse $abbreviated_commit_hash)
                set --function --append commit_hashes $full_commit_hash
            end
            echo (string join ' ' $commit_hashes)
        end
    end
end
