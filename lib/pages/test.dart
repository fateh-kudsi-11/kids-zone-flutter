import 'package:flutter/cupertino.dart';
import '/layouts/heading_text.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: HeadingText(text: 'Test Page'),
      ),
    );
  }
}
