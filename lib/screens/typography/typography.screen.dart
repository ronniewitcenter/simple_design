import 'package:flutter/material.dart';
import 'package:simple_design/simple_design.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});
  static const routeName = '/typography';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: SDAppBar(title: 'Typography'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Type Scale ─────────────────────────────────────────────────
          SDText.heading3('Type Scale'),
          const SizedBox(height: 16),
          _TypeRow(widget: SDText.displayLg('Display Large'),  token: 'displayLarge'),
          _TypeRow(widget: SDText.displaySm('Display Small'),  token: 'displaySmall'),
          _TypeRow(widget: SDText.heading1('Headline Large'),  token: 'headlineLarge'),
          _TypeRow(widget: SDText.heading2('Headline Medium'), token: 'headlineMedium'),
          _TypeRow(widget: SDText.heading3('Headline Small'),  token: 'headlineSmall'),
          _TypeRow(widget: SDText.bodyLg('Body Large'),        token: 'bodyLarge'),
          _TypeRow(widget: SDText.body('Body Medium'),         token: 'bodyMedium'),
          _TypeRow(widget: SDText.bodySm('Body Small'),        token: 'bodySmall'),
          _TypeRow(widget: SDText.label('Label Large'),        token: 'labelLarge'),
          _TypeRow(widget: SDText.caption('Label Small'),      token: 'labelSmall'),

          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Color Variations ───────────────────────────────────────────
          SDText.heading3('Color Variations'),
          const SizedBox(height: 12),
          SDText.body('Default — onSurface'),
          const SizedBox(height: 4),
          SDText.body('Muted', color: cs.onSurfaceVariant),
          const SizedBox(height: 4),
          SDText.body('Primary', color: cs.primary),
          const SizedBox(height: 4),
          SDText.body('Error', color: cs.error),
          const SizedBox(height: 4),
          SDText.body('Tertiary', color: cs.tertiary),

          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Alignment ─────────────────────────────────────────────────
          SDText.heading3('Alignment'),
          const SizedBox(height: 12),
          SDText.body('Left aligned (default)', textAlign: TextAlign.left),
          const SizedBox(height: 4),
          SDText.body('Centered', textAlign: TextAlign.center),
          const SizedBox(height: 4),
          SDText.body('Right aligned', textAlign: TextAlign.right),

          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Overflow ──────────────────────────────────────────────────
          SDText.heading3('Overflow'),
          const SizedBox(height: 12),
          SDText.body(
            'This is a long line of text that should be truncated after one line with an ellipsis at the end.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          SDText.body(
            'This paragraph is clamped at two lines. '
            'Everything beyond the second line will be cut off with an ellipsis. '
            'Useful for card subtitles and list item descriptions.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow({required this.widget, required this.token});
  final Widget widget;
  final String token;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(child: widget),
          const SizedBox(width: 12),
          Text(
            token,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
