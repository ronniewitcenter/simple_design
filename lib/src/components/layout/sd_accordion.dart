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
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List.filled(widget.items.length, false);
  }

  void _onTap(int index, bool isExpanded) {
    setState(() {
      if (widget.allowMultiple) {
        _expanded[index] = !isExpanded;
      } else {
        for (int i = 0; i < _expanded.length; i++) {
          _expanded[i] = i == index ? !isExpanded : false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: _onTap,
      children: widget.items.asMap().entries.map((entry) {
        final i = entry.key;
        final item = entry.value;
        return ExpansionPanel(
          isExpanded: _expanded[i],
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) => ListTile(
            leading: item.leading,
            title: Text(item.title),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: item.child,
          ),
        );
      }).toList(),
    );
  }
}
