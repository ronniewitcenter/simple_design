import 'package:flutter/material.dart';

/// A horizontal paging carousel with optional dot indicator.
///
/// ```dart
/// SDCarousel(
///   height: 200,
///   items: [
///     SDCard.elevated(child: Text('Slide 1')),
///     SDCard.elevated(child: Text('Slide 2')),
///     SDCard.elevated(child: Text('Slide 3')),
///   ],
/// )
///
/// // Peeking adjacent cards
/// SDCarousel(height: 180, viewportFraction: 0.85, items: [...])
/// ```
class SDCarousel extends StatefulWidget {
  const SDCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.showIndicator = true,
    this.viewportFraction = 1.0,
  });

  final List<Widget> items;
  final double height;
  final bool showIndicator;

  /// Fraction of the viewport each page occupies.
  /// Use < 1.0 (e.g. 0.85) to peek at adjacent cards.
  final double viewportFraction;

  @override
  State<SDCarousel> createState() => _SDCarouselState();
}

class _SDCarouselState extends State<SDCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.viewportFraction < 1.0 ? 4 : 0,
              ),
              child: widget.items[i],
            ),
          ),
        ),
        if (widget.showIndicator && widget.items.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.items.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentPage ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _currentPage
                      ? cs.primary
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
