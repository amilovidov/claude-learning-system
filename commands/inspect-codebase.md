# Systematic Codebase Analysis and Improvement

## Objective
Perform a comprehensive analysis of the codebase to identify improvement opportunities without immediate implementation.

## Analysis Scope
Analyze the following areas in priority order:
1. **Performance Bottlenecks**
   - Memory leaks and unbounded caches
   - Inefficient algorithms (O(n²) or worse)
   - Unnecessary re-renders or rebuilds
   - Network request optimization
   - Database query efficiency

2. **Code Quality Issues**
   - Code duplication (DRY violations)
   - Complex methods (>20 lines)
   - Deep nesting (>3 levels)
   - Missing error handling
   - Inconsistent naming conventions
   - Dead code

3. **Architecture Concerns**
   - Separation of concerns violations
   - Tight coupling between components
   - Missing abstraction layers
   - Inconsistent state management
   - Circular dependencies

## Constraints & Principles
- **KISS**: Prefer simple solutions over clever ones
- **YAGNI**: Don't add functionality until needed
- **DRY**: Eliminate duplication, but don't over-abstract
- **SOLID**: Focus especially on Single Responsibility
- **No Workarounds**: Address root causes, not symptoms
- **Material Design 3**: Ensure UI compliance with MD3 expressive & adaptive guidelines

## Deliverables
For each identified issue, create a GitHub issue with:
1. **Priority Label**: P0 (Critical), P1 (High), P2 (Medium), P3 (Low)
2. **Category Label**: performance, code-quality, architecture, security, ui, testing
3. **Issue Template**:
Problem

   [Clear description of the issue]

Current Implementation

   [Code snippet or file:line reference]

Impact

- Performance: [metrics if available]
- Maintainability: [specific concerns]
- User Experience: [if applicable]

Proposed Solution

   [High-level approach without implementation details]

Acceptance Criteria

- Specific, measurable criteria

Estimated Effort

   [Small/Medium/Large or hours]

## Analysis Method
1. **Start with critical paths**: Authentication, data flow, user interactions
2. **Use tooling**: Run analyzers, linters, performance profilers first
3. **Sample, don't exhaustive search**: Check 3-5 examples of each pattern
4. **Document patterns, not instances**: "Multiple services use pattern X" vs listing all
5. **Consider effort/impact ratio**: Prioritize high-impact, low-effort improvements

## Exclusions
- Don't flag issues already tracked in existing tickets
- Skip deprecated code marked for removal
- Ignore test files unless they have critical issues
- Don't suggest premature optimizations

## Success Metrics
- Each issue should be actionable and specific
- Solutions should reduce complexity, not add it
- Improvements should be measurable
- No breaking changes without migration path
