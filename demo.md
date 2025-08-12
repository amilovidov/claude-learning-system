# Demo Script

Quick demonstration of the Claude Learning System in action:

## 1. Installation

```bash
# One-line install
curl -sSL https://raw.githubusercontent.com/amilovidov/claude-learning-system/main/install.sh | bash
```

## 2. Teaching Claude

```bash
# Teach about a GitHub CLI mistake
/learn gh pr diff does not have --stat flag, use --name-only instead

# Teach about Flutter best practices
/learn Always dispose timers in dispose() method to prevent memory leaks

# Record a fix
/fix Timer references should be nullified after cancel()
```

## 3. Querying Learnings

```bash
# View recent learnings
/learnings

# Search for specific topics
/learnings github

# Show last 5 learnings
/learnings 5
```

## 4. Analyzing Patterns

```bash
# See learning statistics
/mistakes
```

## Results

After teaching Claude, these learnings persist across all future conversations. When you start a new Claude Code session, it will automatically read your CLAUDE.md file and apply all previous learnings!

## Example Output

```
✅ Learned and saved to global CLAUDE.md:
   Category: Git/GitHub
   Learning: gh pr diff does not have --stat flag, use --name-only instead
📁 File: /Users/username/.claude/CLAUDE.md

📊 Analyzing Claude's Learning Patterns...

📈 Total learnings recorded: 42

📂 Categories:
  Git/GitHub:          15  ███████████████
  Flutter/Dart:        10  ██████████
  Bug Fixes:            8  ████████
  General:              9  █████████

🕐 Recent learnings:
  - [2024-01-15] **Git/GitHub**: gh pr diff does not have --stat flag, use --name-only instead
  - [2024-01-15] **Flutter/Dart**: Always dispose timers in dispose() method
  - [2024-01-15] **Bug Fixes**: FIX: Timer references should be nullified after cancel()
```