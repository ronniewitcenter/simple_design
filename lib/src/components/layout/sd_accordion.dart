import 'package:flutter/material.dart';

/// A single section definition for [SDAccordion].
class SDAccordionItem {
  const SDAccordionItem({
    required this.title,
    required this.child,
    this.leading,
  });

  final String title;
  final Widget child;
  final Widget? leading;
}

/// An expand/collapse accordion.
///
/// Set [allowMultiple] to true to allow more than one panel open at a time.
///
/// ```dart
/// SDAccordion(items: [
///   SDAccordionItem(title: 'What is Flutter?', child: Text('A UI toolkit...')),
///   SDAccordionItem(title: 'Pricing',          child: Text('Free forever.')),
/// ])
///
/// SDAccordion(allowMultiple: true, items: [...])
/// ```
class SDAccordion extends StatefulWidget {
  const SDAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
  });

  final List<SDAccordionItem> items;

  /// When false (default), opening one panel closes all others.
  final bool allowMultiple;

  @override
  State<SDAccordion> createState() => _SDAccordionState();
}

class _SDAccordionState extends State<SDAccordion> {
  late final List<ExpansibleController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.items.length,
      (_) => ExpansibleController(),
    );
  }

  void _onExpansionChanged(int tappedIndex, bool isNowExpanded) {
    if (!widget.allowMultiple && isNowExpanded) {
      for (int i = 0; i < _controllers.length; i++) {
        if (i != tappedIndex && _controllers[i].isExpanded) {
          _controllers[i].collapse();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (i) {
        final item = widget.items[i];
        return ExpansionTile(
          controller: _controllers[i],
          leading: item.leading,
          title: Text(item.title),
          onExpansionChanged: (expanded) => _onExpansionChanged(i, expanded),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [item.child],
        );
      }),
    );
  }
}
