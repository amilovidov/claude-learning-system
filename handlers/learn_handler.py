#!/usr/bin/env python3
"""
Learning handler for Claude slash command
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
        'this project', 'this app', 'this repo', 'here', 'this codebase'
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
    
    # Categorize the learning
    if "gh " in learning_text or "git " in learning_text:
        category = "Git/GitHub"
    elif "flutter" in learning_text or "dart" in learning_text:
        category = "Flutter/Dart"
    elif "error" in learning_text or "fix" in learning_text:
        category = "Bug Fixes"
    else:
        category = "General"
    
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
    print(f"   {learning_text}")
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
        except:
            db = {"learnings": [], "stats": {}}
    else:
        db = {"learnings": [], "stats": {}}
    
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