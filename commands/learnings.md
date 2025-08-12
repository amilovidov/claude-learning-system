---
description: Show recent learnings from CLAUDE.md
argument-hint: [category or number]
---

# Show Recent Learnings

Display what Claude has learned from previous sessions.

## Show learnings:

```bash
if [ -z "$ARGUMENTS" ]; then
    # Show last 10 learnings
    echo "📚 Recent Learnings:"
    grep -A 0 "^\- \[" ~/.claude/CLAUDE.md | tail -10
else
    # Show specific category or number
    if [[ "$ARGUMENTS" =~ ^[0-9]+$ ]]; then
        echo "📚 Last $ARGUMENTS learnings:"
        grep -A 0 "^\- \[" ~/.claude/CLAUDE.md | tail -$ARGUMENTS
    else
        echo "📚 Learnings about '$ARGUMENTS':"
        grep -i "$ARGUMENTS" ~/.claude/CLAUDE.md | grep "^\- \["
    fi
fi
```

## Examples:
- `/learnings` - Show last 10 learnings
- `/learnings 5` - Show last 5 learnings  
- `/learnings git` - Show learnings about git