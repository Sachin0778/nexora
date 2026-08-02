import 'package:flutter/material.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    this.message = 'No data available',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
