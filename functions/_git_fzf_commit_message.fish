function _git_fzf_commit_message --description "Return a git commit --message command with an issue number pre-populated if appropriate."
    if string match --quiet (string upper $_git_fzf_commit_message_style) "JIRA"
        set --function jira_issue_code (_git_fzf_get_current_branch_jira_issue_code)
        if test -n "$jira_issue_code"
            echo "git commit --message=\"[$jira_issue_code] %\""
        else
            echo "git commit --message=\"%\""
        end
    else
        echo "git commit --message=\"%\""
    end
    commandline --function repaint
end
