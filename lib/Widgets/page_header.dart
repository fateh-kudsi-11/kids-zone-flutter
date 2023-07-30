import 'package:flutter/material.dart';
import 'package:kidszone/layouts/logo.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Logo(),
        ),
      ],
    );
  }
}
