# GitHub/Git Example Learnings

Common learnings for GitHub CLI and Git operations:

```bash
# GitHub CLI commands
/learn gh pr diff does not have --stat flag, use --name-only instead
/learn gh api is preferred over web fetching for GitHub data
/learn gh pr create uses --body not --description for PR body
/learn Use gh pr view --json to get structured PR data
/learn gh issue list supports --json for structured output

# Git best practices
/learn Always pull before pushing to avoid conflicts
/learn Use git stash to temporarily save uncommitted changes
/learn git rebase -i requires interactive terminal, avoid in scripts
/learn Create feature branches from main, not from other feature branches
/learn Use conventional commits: feat:, fix:, docs:, chore:

# GitHub Actions
/learn Secrets are accessed via ${{ secrets.NAME }} in workflows
/learn Use actions/checkout@v3 or later for checking out code
/learn Matrix builds help test across multiple versions
```