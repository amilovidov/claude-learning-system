---
description: Record a fix for the last error
argument-hint: <correct way>
allowed-tools: Bash(echo), Bash(python3)
---

# Fix Last Error

Record a correction for the last command error.

## Save the fix:

When I make an error, use this to teach me the correct way:

```bash
# Get the context from the last error
echo "📝 Recording fix: $ARGUMENTS"

# Add to CLAUDE.md with "FIX" marker
python3 -c "
import sys
from pathlib import Path
from datetime import datetime

fix = '$ARGUMENTS'
timestamp = datetime.now().strftime('%Y-%m-%d')

claude_md = Path.home() / '.claude' / 'CLAUDE.md'
content = claude_md.read_text() if claude_md.exists() else ''

if '## Fixes and Corrections' not in content:
    content += '\n## Fixes and Corrections\n'

entry = f'\n- [{timestamp}] FIX: {fix}'

lines = content.split('\n')
for i, line in enumerate(lines):
    if line.startswith('## Fixes and Corrections'):
        lines.insert(i + 1, entry)
        break

claude_md.write_text('\n'.join(lines))
print(f'✅ Fix recorded: {fix}')
"
```

## Examples:
- `/fix Use gh pr diff --name-only instead of --stat`
- `/fix Run flutter analyze before committing`
- `/fix Check if provider is disposed before accessing`