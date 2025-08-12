---
description: Backup your learnings
---

# Backup Learnings

Create a backup of all your learnings.

```bash
BACKUP_DIR=~/claude-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"

# Backup files
[ -f ~/.claude/CLAUDE.md ] && cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
[ -f ~/.claude/learnings.json ] && cp ~/.claude/learnings.json "$BACKUP_DIR/"
[ -f ./CLAUDE.md ] && cp ./CLAUDE.md "$BACKUP_DIR/project-CLAUDE.md"

echo "✅ Backup saved to: $BACKUP_DIR"
ls -la "$BACKUP_DIR"
```