---
description: Teach Claude something new and save it to CLAUDE.md
argument-hint: <what to learn>
allowed-tools: Bash(echo), Bash(python3)
---

# Learn and Remember

Record a learning to CLAUDE.md so it persists across conversations.

## What this does:
1. Takes your learning/correction
2. Adds it to ~/.claude/CLAUDE.md with timestamp
3. Future Claude sessions will see this learning

## Processing the learning:

```bash
python3 ~/.claude/commands/learn_handler.py "$ARGUMENTS"
```

## Examples:
- `/learn gh pr diff doesn't have --stat flag, use --name-only`
- `/learn always run flutter analyze before committing`
- `/learn in this project, iPads are treated as desktop for UI`

The learning: $ARGUMENTS