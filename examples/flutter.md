# Flutter/Dart Example Learnings

Common learnings for Flutter and Dart development:

```bash
# Flutter commands
/learn flutter analyze should be run on specific files, not entire project
/learn flutter test --coverage generates coverage reports
/learn flutter clean resolves many build cache issues
/learn Use flutter pub get after adding dependencies
/learn flutter build ios requires Xcode and valid provisioning

# Dart best practices
/learn Always dispose controllers in dispose() method
/learn Timer references should be nullified after cancel()
/learn Use ref.watch in build methods, ref.read in callbacks
/learn Prefer const constructors for better performance
/learn Use late initialization carefully to avoid runtime errors

# Widget patterns
/learn Extract widgets when build method exceeds 200 lines
/learn Use Keys when reordering lists of widgets
/learn StatelessWidget for static UI, StatefulWidget for dynamic
/learn Wrap long text in Flexible or Expanded widgets
/learn Use MediaQuery for responsive design

# State management
/learn Riverpod providers should be declared globally
/learn StateNotifier for complex state, Provider for simple values
/learn Always handle loading and error states in UI
/learn Dispose of subscriptions to prevent memory leaks
```