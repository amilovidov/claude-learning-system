---
description: Analyze common mistakes and patterns from learnings
---

# Analyze Common Mistakes

Review patterns in what Claude has learned to identify recurring issues.

## Analysis:

```bash
echo "📊 Analyzing Claude's Learning Patterns..."
echo ""

# Count total learnings
total=$(grep -c "^\- \[" ~/.claude/CLAUDE.md 2>/dev/null || echo 0)
echo "Total learnings recorded: $total"
echo ""

# Show category breakdown
echo "📈 Categories:"
for category in "Git/GitHub" "Flutter/Dart" "Bug Fixes" "General"; do
    count=$(grep -c "\*\*$category\*\*:" ~/.claude/CLAUDE.md 2>/dev/null || echo 0)
    if [ $count -gt 0 ]; then
        echo "  - $category: $count"
    fi
done
echo ""

# Most common keywords in learnings
echo "🔍 Common problem areas:"
grep "^\- \[" ~/.claude/CLAUDE.md 2>/dev/null | \
    sed 's/.*]: //' | \
    tr ' ' '\n' | \
    grep -E '^(error|fail|wrong|not|dont|never|always|must|should|fix|bug)' | \
    sort | uniq -c | sort -rn | head -5 | \
    while read count word; do
        echo "  - '$word' appears $count times"
    done
echo ""

# Recent mistakes (last 5)
echo "🕐 Recent learnings:"
grep "^\- \[" ~/.claude/CLAUDE.md 2>/dev/null | tail -5 | \
    while read -r line; do
        echo "  $line"
    done
```

This helps identify:
- What types of mistakes I make most often
- Patterns that need reinforcement
- Areas where I need more training data