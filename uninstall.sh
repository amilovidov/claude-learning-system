#!/bin/bash

# Claude Learning System Uninstaller

echo "🧹 Uninstalling Claude Learning System..."

# Backup learnings before removal
if [ -f ~/.claude/CLAUDE.md ] || [ -f ~/.claude/learnings.json ]; then
    BACKUP_DIR=~/claude-learnings-backup-$(date +%Y%m%d-%H%M%S)
    echo "📦 Backing up your learnings to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    [ -f ~/.claude/CLAUDE.md ] && cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
    [ -f ~/.claude/learnings.json ] && cp ~/.claude/learnings.json "$BACKUP_DIR/"
    echo "✅ Backup complete"
fi

# Remove command files
echo "🗑️  Removing command files..."
rm -f ~/.claude/commands/learn.md
rm -f ~/.claude/commands/learnings.md
rm -f ~/.claude/commands/fix.md
rm -f ~/.claude/commands/mistakes.md
rm -f ~/.claude/commands/learn_handler.py

echo "✅ Claude Learning System uninstalled"
echo "💡 Your learnings are backed up in: $BACKUP_DIR"