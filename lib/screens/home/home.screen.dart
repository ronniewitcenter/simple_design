import 'package:flutter/material.dart';
import 'package:simple_design/simple_design.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Design')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _ColorPaletteSection(),
          SDDivider.horizontal(),
          _TypeScaleSection(),
          SDDivider.horizontal(),
          _AnimationTokensSection(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Color Palette ────────────────────────────────────

class _ColorPaletteSection extends StatelessWidget {
  const _ColorPaletteSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final swatches = [
      _Swatch('primary', cs.primary, cs.onPrimary),
      _Swatch('secondary', cs.secondary, cs.onSecondary),
      _Swatch('tertiary', cs.tertiary, cs.onTertiary),
      _Swatch('error', cs.error, cs.onError),
      _Swatch('surface', cs.surface, cs.onSurface),
      _Swatch('surfaceVariant', cs.surfaceContainerHighest, cs.onSurfaceVariant),
      _Swatch('outline', cs.outline, cs.surface),
      _Swatch('outlineVariant', cs.outlineVariant, cs.onSurface),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SDText.heading3('Color Palette'),
          const SizedBox(height: 4),
          SDText.bodySm(
            'Generated from a single seed color via ColorScheme.fromSeed',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.8,
            children: swatches.map((s) => _SwatchTile(swatch: s)).toList(),
          ),
        ],
      ),
    );
  }
}

class _Swatch {
  const _Swatch(this.name, this.color, this.onColor);
  final String name;
  final Color color;
  final Color onColor;
}

class _SwatchTile extends StatelessWidget {
  const _SwatchTile({required this.swatch});
  final _Swatch swatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: swatch.color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        swatch.name,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: swatch.onColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ── Type Scale ───────────────────────────────────────

class _TypeScaleSection extends StatelessWidget {
  const _TypeScaleSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SDText.heading3('Type Scale'),
          const SizedBox(height: 4),
          SDText.bodySm(
            'Mapped to Flutter\'s Material 3 TextTheme',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          const _TypeRow('displayLg', SDText.displayLg('Aa')),
          const _TypeRow('displaySm', SDText.displaySm('Aa')),
          const _TypeRow('heading1', SDText.heading1('Heading 1')),
          const _TypeRow('heading2', SDText.heading2('Heading 2')),
          const _TypeRow('heading3', SDText.heading3('Heading 3')),
          const _TypeRow('bodyLg', SDText.bodyLg('Body Large — lorem ipsum dolor')),
          const _TypeRow('body', SDText.body('Body — lorem ipsum dolor sit amet')),
          const _TypeRow('bodySm', SDText.bodySm('Body Small — lorem ipsum dolor sit amet')),
          const _TypeRow('label', SDText.label('Label')),
          const _TypeRow('caption', SDText.caption('Caption text')),
        ],
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow(this.name, this.sample);
  final String name;
  final Widget sample;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontFamily: 'monospace',
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: sample),
        ],
      ),
    );
  }
}

// ── Animation Tokens ─────────────────────────────────

class _AnimationTokensSection extends StatelessWidget {
  const _AnimationTokensSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SDText.heading3('Animation Tokens'),
          const SizedBox(height: 4),
          SDText.bodySm(
            'SDAnimation — the only custom token class',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          _TokenRow('SDAnimation.fast', '${SDAnimation.fast.inMilliseconds}ms', 'Hover, press feedback'),
          _TokenRow('SDAnimation.normal', '${SDAnimation.normal.inMilliseconds}ms', 'Expand / collapse'),
          _TokenRow('SDAnimation.slow', '${SDAnimation.slow.inMilliseconds}ms', 'Modals, page transitions'),
          _TokenRow('SDAnimation.curve', 'easeInOut', 'Standard easing'),
        ],
      ),
    );
  }
}

class _TokenRow extends StatelessWidget {
  const _TokenRow(this.token, this.value, this.description);
  final String token;
  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              token,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'monospace'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onPrimaryContainer),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: SDText.caption(description, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
