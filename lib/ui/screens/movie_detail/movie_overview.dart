import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  final String details;
  const MovieOverview({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Text(
        details,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}