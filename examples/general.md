# General Programming Example Learnings

Common learnings across various programming contexts:

```bash
# Error handling
/learn Always catch specific exceptions, not generic ones
/learn Log errors with context for easier debugging
/learn Provide user-friendly error messages
/learn Implement retry logic with exponential backoff
/learn Never expose sensitive information in error messages

# Code quality
/learn Keep functions under 50 lines when possible
/learn Use descriptive variable names over comments
/learn Follow DRY principle - Don't Repeat Yourself
/learn Write tests before fixing bugs to prevent regression
/learn Document why, not what in code comments

# Performance
/learn Profile before optimizing
/learn Cache expensive computations
/learn Lazy load resources when possible
/learn Dispose of resources properly to prevent leaks
/learn Use pagination for large data sets

# Security
/learn Never commit API keys or secrets
/learn Validate all user input
/learn Use environment variables for configuration
/learn Implement rate limiting for APIs
/learn Keep dependencies updated for security patches

# Testing
/learn Write unit tests for business logic
/learn Mock external dependencies in tests
/learn Aim for 80% code coverage
/learn Test edge cases and error conditions
/learn Use integration tests for critical user flows
```