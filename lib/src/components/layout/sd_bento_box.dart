import 'package:flutter/material.dart';

/// A cell in a [SDBentoBox] row.
class SDBentoItem {
  const SDBentoItem({required this.child, this.flex = 1});

  final Widget child;

  /// Relative width within its row. Higher values take more space.
  final int flex;
}

/// A grid-based bento layout.
///
/// Each row is a list of [SDBentoItem]s. Items within a row share width
/// proportionally via their [SDBentoItem.flex] values.
///
/// ```dart
/// SDBentoBox(
///   gap: 8,
///   rowHeight: 120,
///   rows: [
///     // Two equal cells
///     [SDBentoItem(child: SDCard.filled(child: Text('A'))),
///      SDBentoItem(child: SDCard.filled(child: Text('B')))],
///     // One wide + one narrow
///     [SDBentoItem(flex: 2, child: SDCard.elevated(child: Text('Wide'))),
///      SDBentoItem(flex: 1, child: SDCard.outlined(child: Text('Narrow')))],
///   ],
/// )
/// ```
class SDBentoBox extends StatelessWidget {
  const SDBentoBox({
    super.key,
    required this.rows,
    this.gap = 8,
    this.rowHeight = 120,
  });

  final List<List<SDBentoItem>> rows;
  final double gap;

  /// Height of each row. All rows share the same height.
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int r = 0; r < rows.length; r++) ...[
          if (r > 0) SizedBox(height: gap),
          SizedBox(
            height: rowHeight,
            child: Row(
              children: [
                for (int c = 0; c < rows[r].length; c++) ...[
                  if (c > 0) SizedBox(width: gap),
                  Expanded(
                    flex: rows[r][c].flex,
                    child: rows[r][c].child,
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
