import 'package:cooki/common/component/main_scaffold.dart';
import 'package:flutter/material.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Text(
        'Shopping List${id}',
      ),
    );
  }
}
