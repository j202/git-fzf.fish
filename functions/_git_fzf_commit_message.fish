function  _git_fzf_commit_message --description "Return a git commit -m command with an issue number pre-populated if appropriate."
    set --function cmd "git commit -m"
    if string match --quiet (string upper $_git_fzf_commit_message_style) "JIRA"
        set --function jira_issue_code (_git_fzf_get_current_branch_jira_issue_code)
        if test -n "$jira_issue_code"
            echo $cmd \"[$jira_issue_code] %\"
        else
            echo "$cmd \"%\""
        end 
    else
        echo "$cmd \"%\""
    end 
    commandline --function repaint
end
