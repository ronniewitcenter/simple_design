import 'package:flutter/material.dart';

/// A centered empty-state placeholder with icon, title, message, and optional action.
///
/// ```dart
/// SDEmptyState(
///   message: 'No results found.',
/// )
///
/// SDEmptyState(
///   icon: Icons.search_off_outlined,
///   title: 'Nothing here',
///   message: 'Try adjusting your filters.',
///   action: SDButton.primary(label: 'Clear filters', onPressed: () {}),
/// )
/// ```
class SDEmptyState extends StatelessWidget {
  const SDEmptyState({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  final String message;
  final String? title;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: cs.onSurfaceVariant),
          const SizedBox(height: 16),
          if (title != null) ...[
            Text(
              title!,
              style: tt.titleMedium?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
          Text(
            message,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const SizedBox(height: 24),
            action!,
          ],
        ],
      ),
    );
  }
}
