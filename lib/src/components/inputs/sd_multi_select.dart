import 'package:flutter/material.dart';
import 'sd_dropdown.dart';

/// A tappable field that opens a dialog for selecting multiple items.
///
/// ```dart
/// SDMultiSelect<String>(
///   label: 'Tags',
///   items: [SDDropdownItem(value: 'dart', label: 'Dart')],
///   selected: _selected,
///   onChanged: (v) => setState(() => _selected = v),
/// )
/// ```
class SDMultiSelect<T> extends StatelessWidget {
  const SDMultiSelect({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  final List<SDDropdownItem<T>> items;
  final List<T> selected;
  final ValueChanged<List<T>> onChanged;
  final String? label;
  final bool enabled;

  String get _displayText {
    if (selected.isEmpty) return '';
    return items
        .where((item) => selected.contains(item.value))
        .map((item) => item.label)
        .join(', ');
  }

  Future<void> _openDialog(BuildContext context) async {
    final result = await showDialog<List<T>>(
      context: context,
      builder: (ctx) => _MultiSelectDialog<T>(
        items: items,
        initial: selected,
        title: label,
      ),
    );
    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final display = _displayText;

    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? () => _openDialog(context) : null,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.arrow_drop_down),
            enabled: enabled,
          ),
          child: display.isEmpty
              ? null
              : Text(
                  display,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: enabled
                            ? cs.onSurface
                            : cs.onSurface.withValues(alpha: 0.38),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}

class _MultiSelectDialog<T> extends StatefulWidget {
  const _MultiSelectDialog({
    required this.items,
    required this.initial,
    this.title,
  });

  final List<SDDropdownItem<T>> items;
  final List<T> initial;
  final String? title;

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<T>.from(widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title != null ? Text(widget.title!) : null,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item.label),
              value: _selected.contains(item.value),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    _selected.add(item.value);
                  } else {
                    _selected.remove(item.value);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selected),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
