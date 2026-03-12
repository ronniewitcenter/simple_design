import 'package:flutter/material.dart';
import 'package:simple_design/simple_design.dart';

class ButtonsScreen extends StatefulWidget {
  static const String routeName = '/buttons';

  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  bool _primaryLoading = false;
  bool _secondaryLoading = false;
  bool _ghostLoading = false;
  bool _dangerLoading = false;

  void _simulateLoad(void Function(bool) setter) {
    setter(true);
    Future.delayed(SDAnimation.slow * 4, () {
      if (mounted) setState(() => setter(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _Section(
            title: 'Primary',
            children: [
              SDButton.primary(label: 'Default', onPressed: () {}),
              const SizedBox(height: 12),
              SDButton.primary(
                label: 'Loading',
                onPressed: _primaryLoading ? null : () => setState(() => _simulateLoad((v) => _primaryLoading = v)),
                loading: _primaryLoading,
              ),
              const SizedBox(height: 12),
              const SDButton.primary(label: 'Disabled', onPressed: null),
            ],
          ),
          const SDDivider.horizontal(),
          _Section(
            title: 'Secondary',
            children: [
              SDButton.secondary(label: 'Default', onPressed: () {}),
              const SizedBox(height: 12),
              SDButton.secondary(
                label: 'Loading',
                onPressed: _secondaryLoading ? null : () => setState(() => _simulateLoad((v) => _secondaryLoading = v)),
                loading: _secondaryLoading,
              ),
              const SizedBox(height: 12),
              const SDButton.secondary(label: 'Disabled', onPressed: null),
            ],
          ),
          const SDDivider.horizontal(),
          _Section(
            title: 'Ghost',
            children: [
              SDButton.ghost(label: 'Default', onPressed: () {}),
              const SizedBox(height: 12),
              SDButton.ghost(
                label: 'Loading',
                onPressed: _ghostLoading ? null : () => setState(() => _simulateLoad((v) => _ghostLoading = v)),
                loading: _ghostLoading,
              ),
              const SizedBox(height: 12),
              const SDButton.ghost(label: 'Disabled', onPressed: null),
            ],
          ),
          const SDDivider.horizontal(),
          _Section(
            title: 'Danger',
            children: [
              SDButton.danger(label: 'Delete', onPressed: () {}),
              const SizedBox(height: 12),
              SDButton.danger(
                label: 'Deleting…',
                onPressed: _dangerLoading ? null : () => setState(() => _simulateLoad((v) => _dangerLoading = v)),
                loading: _dangerLoading,
              ),
              const SizedBox(height: 12),
              const SDButton.danger(label: 'Disabled', onPressed: null),
            ],
          ),
          const SDDivider.horizontal(),
          _Section(
            title: 'With Icon',
            children: [
              SDButton.primary(label: 'Add Item', onPressed: () {}, leadingIcon: Icons.add),
              const SizedBox(height: 12),
              SDButton.secondary(label: 'Share', onPressed: () {}, leadingIcon: Icons.share),
              const SizedBox(height: 12),
              SDButton.ghost(label: 'Settings', onPressed: () {}, leadingIcon: Icons.settings),
            ],
          ),
          const SDDivider.horizontal(),
          _Section(
            title: 'Full Width',
            children: [
              SDButton.primary(label: 'Full Width Primary', onPressed: () {}, fullWidth: true),
              const SizedBox(height: 12),
              SDButton.secondary(label: 'Full Width Secondary', onPressed: () {}, fullWidth: true),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SDText.label(title, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
