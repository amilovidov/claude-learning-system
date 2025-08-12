#!/bin/bash

# Claude Learning System Installer
# https://github.com/amilovidov/claude-learning-system
# Version: 1.0.0

set -euo pipefail
trap 'echo "❌ Installation failed. Please check the error above and try again."' ERR

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧠 Claude Learning System Installer${NC}"
echo "====================================="
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

if [ "$MACHINE" = "UNKNOWN:${OS}" ]; then
    echo -e "${RED}❌ Unsupported OS: ${OS}${NC}"
    echo "This installer supports macOS and Linux only."
    exit 1
fi

echo -e "${GREEN}✓${NC} Detected OS: ${MACHINE}"

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python 3 is required but not installed.${NC}"
    echo "Please install Python 3 and try again."
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo -e "${GREEN}✓${NC} Python ${PYTHON_VERSION} found"

# Detect home directory
USER_HOME=${HOME:-~}
CLAUDE_DIR="$USER_HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"

echo -e "${BLUE}📁 Installation directory: ${CLAUDE_DIR}${NC}"

# Create directories
echo -e "\n${YELLOW}Creating directories...${NC}"
mkdir -p "$COMMANDS_DIR"
mkdir -p "$CLAUDE_DIR/backups"
echo -e "${GREEN}✓${NC} Directories created"

# Backup existing files if they exist
BACKUP_NEEDED=false
if [ -d "$COMMANDS_DIR" ] && [ "$(ls -A $COMMANDS_DIR 2>/dev/null)" ]; then
    BACKUP_NEEDED=true
fi

if [ "$BACKUP_NEEDED" = true ]; then
    BACKUP_DIR="$CLAUDE_DIR/backups/$(date +%Y%m%d_%H%M%S)"
    echo -e "\n${YELLOW}📦 Backing up existing commands to:${NC}"
    echo "   $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    cp -r "$COMMANDS_DIR"/* "$BACKUP_DIR" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Backup complete"
fi

# Install the learning handler
echo -e "\n${YELLOW}Installing learning handler...${NC}"
cat > "$COMMANDS_DIR/learn_handler.py" << 'HANDLER_EOF'
#!/usr/bin/env python3
"""
Claude Learning System - Learning Handler
Adds learnings to CLAUDE.md for persistence across sessions
"""

import sys
import os
from pathlib import Path
from datetime import datetime
import json

def add_learning(learning_text):
    """Add a learning to CLAUDE.md with proper formatting"""
    
    # Determine which CLAUDE.md to update (global vs project)
    global_claude = Path.home() / ".claude" / "CLAUDE.md"
    project_claude = Path.cwd() / "CLAUDE.md"
    
    # Decide which file to update based on content
    is_project_specific = any(keyword in learning_text.lower() for keyword in [
        'this project', 'this app', 'this repo', 'here', 'this codebase',
        'in this', 'for this'
    ])
    
    target_file = project_claude if is_project_specific and project_claude.exists() else global_claude
    
    # Ensure directory exists
    target_file.parent.mkdir(parents=True, exist_ok=True)
    
    # Read existing content
    if target_file.exists():
        content = target_file.read_text()
    else:
        content = "# Claude Instructions\n\n"
    
    # Check if we already have this learning (avoid duplicates)
    if learning_text in content:
        print(f"ℹ️ Already learned: {learning_text}")
        return
    
    # Add learned section if not exists
    section_name = "## Learned from Sessions"
    if section_name not in content:
        content += f"\n{section_name}\n"
    
    # Format the learning entry
    timestamp = datetime.now().strftime("%Y-%m-%d")
    
    # Enhanced categorization
    categories = {
        "Git/GitHub": ['gh ', 'git ', 'github', 'pull request', 'pr ', 'branch', 'commit', 'merge'],
        "Flutter/Dart": ['flutter', 'dart', 'widget', 'provider', 'riverpod', 'build'],
        "JavaScript/Node": ['npm', 'node', 'javascript', 'js', 'ts', 'typescript', 'react', 'vue'],
        "Python": ['python', 'pip', 'django', 'flask', 'pytest', 'venv'],
        "DevOps": ['docker', 'kubernetes', 'k8s', 'container', 'ci/cd', 'deploy'],
        "Testing": ['test', 'spec', 'jest', 'pytest', 'unittest', 'mock'],
        "Database": ['sql', 'postgres', 'mysql', 'mongodb', 'redis', 'database'],
        "Security": ['auth', 'token', 'password', 'encrypt', 'ssl', 'https'],
        "Performance": ['optimize', 'performance', 'speed', 'memory', 'cache'],
        "Bug Fixes": ['error', 'fix', 'bug', 'issue', 'problem', 'solve', 'crash'],
    }
    
    category = "General"
    learning_lower = learning_text.lower()
    for cat, keywords in categories.items():
        if any(kw in learning_lower for kw in keywords):
            category = cat
            break
    
    entry = f"\n- [{timestamp}] **{category}**: {learning_text}"
    
    # Find the section and add entry
    lines = content.split('\n')
    inserted = False
    
    for i, line in enumerate(lines):
        if line.startswith(section_name):
            # Look for the same category or insert at the end of section
            j = i + 1
            while j < len(lines) and lines[j].strip():
                if f"**{category}**:" in lines[j]:
                    # Insert after the last entry of this category
                    while j < len(lines) and lines[j].strip() and not lines[j].startswith("## "):
                        j += 1
                    lines.insert(j, entry.strip())
                    inserted = True
                    break
                j += 1
            
            if not inserted:
                # Add as first entry in this section
                lines.insert(i + 1, entry.strip())
                inserted = True
            break
    
    if not inserted:
        lines.append(entry.strip())
    
    content = '\n'.join(lines)
    
    # Write back
    target_file.write_text(content)
    
    # Output for Claude to see
    location = "project" if target_file == project_claude else "global"
    print(f"✅ Learned and saved to {location} CLAUDE.md:")
    print(f"   Category: {category}")
    print(f"   Learning: {learning_text}")
    print(f"📁 File: {target_file}")
    
    # Also update a JSON database for structured queries
    update_learning_db(learning_text, category)

def update_learning_db(learning, category):
    """Maintain a structured JSON database of learnings"""
    db_file = Path.home() / ".claude" / "learnings.json"
    
    # Load existing database
    if db_file.exists():
        try:
            with open(db_file, 'r') as f:
                db = json.load(f)
            # Ensure structure exists
            if "learnings" not in db:
                db["learnings"] = []
            if "stats" not in db:
                db["stats"] = {}
            if "categories" not in db:
                db["categories"] = {}
        except:
            db = {"learnings": [], "stats": {}, "categories": {}}
    else:
        db = {"learnings": [], "stats": {}, "categories": {}}
    
    # Add new learning
    db["learnings"].append({
        "text": learning,
        "category": category,
        "timestamp": datetime.now().isoformat(),
        "project": str(Path.cwd())
    })
    
    # Update stats
    db["stats"]["total"] = len(db["learnings"])
    db["stats"]["last_updated"] = datetime.now().isoformat()
    
    # Update category counts
    if category not in db["categories"]:
        db["categories"][category] = 0
    db["categories"][category] += 1
    
    # Save database
    db_file.parent.mkdir(exist_ok=True)
    with open(db_file, 'w') as f:
        json.dump(db, f, indent=2)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        learning = " ".join(sys.argv[1:])
        add_learning(learning)
    else:
        print("❌ No learning provided")
        print("Usage: /learn <what to learn>")
        sys.exit(1)
HANDLER_EOF

chmod +x "$COMMANDS_DIR/learn_handler.py"
echo -e "${GREEN}✓${NC} Learning handler installed"

# Install slash commands
echo -e "\n${YELLOW}Installing slash commands...${NC}"

# /learn command
cat > "$COMMANDS_DIR/learn.md" << 'EOF'
---
description: Teach Claude something new and save it to CLAUDE.md
argument-hint: <what to learn>
allowed-tools: Bash(echo), Bash(python3)
---

# Learn and Remember

Record a learning to CLAUDE.md so it persists across conversations.

```bash
python3 ~/.claude/commands/learn_handler.py "$ARGUMENTS"
```
EOF
echo -e "${GREEN}✓${NC} /learn command installed"

# /learnings command
cat > "$COMMANDS_DIR/learnings.md" << 'EOF'
---
description: Show recent learnings from CLAUDE.md
argument-hint: [category or number]
---

# Show Recent Learnings

View your teaching history with Claude.

```bash
if [ -z "$ARGUMENTS" ]; then
    echo "📚 Recent Learnings:"
    echo ""
    if [ -f ~/.claude/CLAUDE.md ]; then
        grep "^- \[" ~/.claude/CLAUDE.md 2>/dev/null | tail -10 || echo "No learnings yet. Use /learn to add some!"
    else
        echo "No learnings yet. Use /learn to add your first learning!"
    fi
else
    if [[ "$ARGUMENTS" =~ ^[0-9]+$ ]]; then
        echo "📚 Last $ARGUMENTS learnings:"
        echo ""
        grep "^- \[" ~/.claude/CLAUDE.md 2>/dev/null | tail -$ARGUMENTS || echo "No learnings found"
    else
        echo "📚 Learnings about '$ARGUMENTS':"
        echo ""
        grep -i "$ARGUMENTS" ~/.claude/CLAUDE.md 2>/dev/null | grep "^- \[" || echo "No learnings found about '$ARGUMENTS'"
    fi
fi
```
EOF
echo -e "${GREEN}✓${NC} /learnings command installed"

# /fix command
cat > "$COMMANDS_DIR/fix.md" << 'EOF'
---
description: Record a fix for the last error
argument-hint: <correct way>
allowed-tools: Bash(echo), Bash(python3)
---

# Fix Last Error

Record a correction for mistakes.

```bash
echo "📝 Recording fix: $ARGUMENTS"
python3 ~/.claude/commands/learn_handler.py "FIX: $ARGUMENTS"
```
EOF
echo -e "${GREEN}✓${NC} /fix command installed"

# /mistakes command
cat > "$COMMANDS_DIR/mistakes.md" << 'EOF'
---
description: Analyze common mistakes and patterns from learnings
---

# Analyze Common Mistakes

Review patterns in what Claude has learned.

```bash
echo "📊 Analyzing Claude's Learning Patterns..."
echo ""

if [ ! -f ~/.claude/CLAUDE.md ]; then
    echo "No learnings recorded yet. Use /learn to start teaching Claude!"
    exit 0
fi

# Count total learnings
total=$(grep -c "^- \[" ~/.claude/CLAUDE.md 2>/dev/null || echo 0)
echo "📈 Total learnings recorded: $total"
echo ""

if [ $total -gt 0 ]; then
    # Show category breakdown
    echo "📂 Categories:"
    for category in "Git/GitHub" "Flutter/Dart" "JavaScript/Node" "Python" "DevOps" "Testing" "Database" "Security" "Performance" "Bug Fixes" "General"; do
        count=$(grep -c "\*\*$category\*\*:" ~/.claude/CLAUDE.md 2>/dev/null || echo 0)
        if [ $count -gt 0 ]; then
            # Calculate percentage
            percent=$((count * 100 / total))
            # Create a simple bar chart
            bar=""
            for ((i=0; i<$percent/5; i++)); do bar="${bar}█"; done
            printf "  %-20s %3d  %s\n" "$category:" "$count" "$bar"
        fi
    done
    echo ""
    
    # Show recent learnings
    echo "🕐 Recent learnings:"
    grep "^- \[" ~/.claude/CLAUDE.md 2>/dev/null | tail -5 | while IFS= read -r line; do
        echo "  $line"
    done
    
    # Check JSON database for more stats
    if [ -f ~/.claude/learnings.json ]; then
        echo ""
        echo "📊 Additional Statistics:"
        python3 -c "
import json
from pathlib import Path
db_file = Path.home() / '.claude' / 'learnings.json'
if db_file.exists():
    with open(db_file) as f:
        db = json.load(f)
    if 'stats' in db:
        print(f\"  Last updated: {db['stats'].get('last_updated', 'Unknown')[:10]}\")
    if 'categories' in db:
        top_cat = max(db['categories'].items(), key=lambda x: x[1])
        print(f\"  Most common category: {top_cat[0]} ({top_cat[1]} learnings)\")
"
    fi
fi
```
EOF
echo -e "${GREEN}✓${NC} /mistakes command installed"

# Create initial CLAUDE.md if it doesn't exist
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo -e "\n${YELLOW}Creating initial CLAUDE.md...${NC}"
    cat > "$CLAUDE_DIR/CLAUDE.md" << 'EOF'
# Claude Instructions

This file contains instructions and learnings for Claude to reference across sessions.

## General Guidelines

- Be concise and direct
- Follow project conventions
- Ask for clarification when uncertain
- Apply learnings from previous sessions

## Learned from Sessions
<!-- Learnings will be added here automatically via /learn command -->

EOF
    echo -e "${GREEN}✓${NC} CLAUDE.md created"
else
    echo -e "${GREEN}✓${NC} CLAUDE.md already exists"
fi

# Print summary
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}📚 Available commands:${NC}"
echo "  /learn <what to learn>    - Teach Claude something new"
echo "  /learnings [filter]       - View past learnings"
echo "  /fix <correction>         - Record a fix"
echo "  /mistakes                 - Analyze patterns"
echo ""
echo -e "${YELLOW}🚀 Quick start:${NC}"
echo "  Try: /learn gh pr diff does not have --stat flag, use --name-only"
echo ""
echo -e "${BLUE}📖 Documentation:${NC}"
echo "  https://github.com/amilovidov/claude-learning-system"
echo ""
echo "Happy learning! 🎉"