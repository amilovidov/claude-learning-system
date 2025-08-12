# Contributing to Claude Learning System

We love your input! We want to make contributing to this project as easy and transparent as possible.

## Development Process

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

## Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. Ensure your code follows the existing style
4. Issue that pull request!

## Any contributions you make will be under the MIT License

When you submit code changes, your submissions are understood to be under the same [MIT License](LICENSE) that covers the project.

## Report bugs using GitHub Issues

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/your-username/claude-learning-system/issues/new).

## Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## Adding New Features

### Adding a New Command

1. Create a new markdown file in `commands/` directory
2. Follow the existing command format:
   ```markdown
   ---
   description: Brief description
   argument-hint: <expected args>
   allowed-tools: Bash(echo), Bash(python3)
   ---
   
   # Command Name
   
   Command implementation here
   ```

3. Update the installer to include your command
4. Add examples to the documentation

### Improving the Learning Handler

The learning handler (`handlers/learn_handler.py`) can be extended to:
- Add new categories
- Improve categorization logic
- Add new output formats
- Enhance duplicate detection

### Adding New Examples

Create new example files in `examples/` directory following the pattern:
- Use real-world scenarios
- Group related learnings
- Include both dos and don'ts
- Explain why certain patterns are preferred

## Code Style

### Python
- Follow PEP 8
- Use type hints where appropriate
- Document functions with docstrings

### Shell Scripts
- Use bash (not sh)
- Set `set -e` for error handling
- Use meaningful variable names
- Quote variables: `"$VAR"` not `$VAR`

### Markdown
- Use GitHub Flavored Markdown
- Include code examples with syntax highlighting
- Keep line length under 100 characters

## Testing

Before submitting:

1. Test the installer on a clean system
2. Verify all commands work as expected
3. Test both global and project-specific learnings
4. Ensure backward compatibility

## Community

- Be respectful and inclusive
- Help others when you can
- Share your learnings!

## Questions?

Feel free to open an issue for any questions about contributing.

Thank you for contributing! 🎉