# Claude Learning System Architecture

## Overview

The Claude Learning System is designed to provide persistent memory for Claude Code across sessions using a combination of markdown files, slash commands, and a JSON database.

## Core Components

### 1. CLAUDE.md Files

Claude Code automatically reads `CLAUDE.md` files at the start of each session:

- **Global**: `~/.claude/CLAUDE.md` - System-wide learnings
- **Project**: `./CLAUDE.md` - Project-specific learnings

These files use a structured markdown format that Claude can parse and understand.

### 2. Slash Commands

Located in `~/.claude/commands/`, these provide the user interface:

- **learn.md**: Primary command for teaching Claude
- **learnings.md**: Query and filter past learnings
- **fix.md**: Record corrections for mistakes
- **mistakes.md**: Analyze patterns and statistics

### 3. Learning Handler

The Python handler (`learn_handler.py`) processes learnings:

1. Categorizes input automatically
2. Determines scope (global vs project)
3. Updates markdown files
4. Maintains JSON database
5. Prevents duplicates

### 4. JSON Database

`~/.claude/learnings.json` provides structured storage:

```json
{
  "learnings": [
    {
      "text": "learning content",
      "category": "Git/GitHub",
      "timestamp": "ISO-8601",
      "project": "/path/to/project"
    }
  ],
  "stats": {
    "total": 42,
    "last_updated": "ISO-8601"
  },
  "categories": {
    "Git/GitHub": 15,
    "Flutter/Dart": 10
  }
}
```

## Data Flow

```
User Input (/learn command)
    ↓
Slash Command Handler
    ↓
Python Learning Handler
    ↓
Categorization Engine
    ↓
    ├→ CLAUDE.md (for Claude to read)
    └→ learnings.json (for queries)
```

## Categories

The system automatically categorizes learnings:

1. **Git/GitHub**: Version control and GitHub CLI
2. **Flutter/Dart**: Mobile development
3. **JavaScript/Node**: JS/TS ecosystem
4. **Python**: Python development
5. **DevOps**: Docker, K8s, CI/CD
6. **Testing**: Test frameworks and practices
7. **Database**: SQL and NoSQL
8. **Security**: Auth and encryption
9. **Performance**: Optimization
10. **Bug Fixes**: Error corrections
11. **General**: Uncategorized

## Scope Detection

The handler determines scope based on keywords:

- **Project-specific**: "this project", "this app", "here"
- **Global**: Everything else

## Duplicate Prevention

Before adding a learning:

1. Check if exact text exists in target file
2. Skip if duplicate found
3. Inform user about existing learning

## Backup Strategy

The installer creates timestamped backups:

```
~/.claude/backups/
├── 20240115_143022/
│   ├── learn.md
│   ├── learnings.md
│   └── ...
```

## Extension Points

### Adding New Categories

Edit the categories dictionary in `learn_handler.py`:

```python
categories = {
    "NewCategory": ['keyword1', 'keyword2'],
    # ...
}
```

### Custom Processing

Override the `add_learning()` function to:
- Add validation
- Implement custom formatting
- Integrate with external systems

### Alternative Storage

Replace or supplement the JSON database:
- SQLite for better querying
- Cloud sync for team sharing
- Git repository for version control

## Performance Considerations

- **File I/O**: Minimal, only on command execution
- **Memory**: Lightweight, no background processes
- **CPU**: Negligible, simple text processing
- **Storage**: Grows linearly with learnings (~100 bytes/learning)

## Security

- No network calls (all local)
- No sensitive data collection
- User controls all data
- Easy to audit (plain text storage)

## Compatibility

- **OS**: macOS, Linux (Windows via WSL)
- **Python**: 3.6+
- **Claude Code**: All versions with slash command support
- **Shell**: Bash 4.0+

## Future Enhancements

1. **Web Dashboard**: Visualize learning patterns
2. **Team Sync**: Share learnings across team
3. **AI Analysis**: Identify learning gaps
4. **Export Options**: PDF, HTML reports
5. **Integration**: VSCode extension