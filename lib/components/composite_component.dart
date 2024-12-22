import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class CompositeComponent extends StatelessWidget {
  final Widget child;

  const CompositeComponent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(title: 'ChatAppYTM Ana Sayfa'), // Header Eklendi
        Expanded(child: child), // Ana içerik
        Footer(), // Footer Eklendi
      ],
    );
  }
}
