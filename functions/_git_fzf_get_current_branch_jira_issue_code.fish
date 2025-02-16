function _git_fzf_get_current_branch_jira_issue_code --description "Extract and return a jira issue code from the current branch name."
    set --function branch (_git_fzf_current_branch)
    string match --quiet --ignore-case --regex -- \
        '^\s*((?<branch_type>\w+)/)?(?<jira_code>\w+-\d+)-(?<issue_title>(\w+-)*\w+)\s*$' \
        "$branch"
    echo "$jira_code"
end
