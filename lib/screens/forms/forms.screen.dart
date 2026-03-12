import 'package:flutter/material.dart';
import 'package:simple_design/simple_design.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});
  static const routeName = '/forms';

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  // Text fields
  final _controller = TextEditingController();

  // Dropdown
  String? _country;
  static final _countries = <SDDropdownItem<String>>[
    SDDropdownItem(value: 'us', label: 'United States'),
    SDDropdownItem(value: 'kr', label: 'South Korea'),
    SDDropdownItem(value: 'jp', label: 'Japan'),
    SDDropdownItem(value: 'gb', label: 'United Kingdom'),
  ];

  // Multi-select
  List<String> _tags = [];
  static final _tagOptions = <SDDropdownItem<String>>[
    SDDropdownItem(value: 'dart', label: 'Dart'),
    SDDropdownItem(value: 'flutter', label: 'Flutter'),
    SDDropdownItem(value: 'firebase', label: 'Firebase'),
    SDDropdownItem(value: 'supabase', label: 'Supabase'),
  ];

  // Checkboxes
  bool _terms = false;
  bool _newsletter = false;
  final bool _updates = true;

  // Radio
  String _plan = 'free';

  // Switches
  bool _darkMode = false;
  bool _notifications = true;

  // Slider
  double _volume = 0.5;

  // Date picker
  DateTime? _birthDate;

  // Full form
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _formCountry;
  bool _formValidated = false;

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forms')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Text Fields ─────────────────────────────────────────────────
          SDText.heading3('Text Fields'),
          const SizedBox(height: 12),
          SDTextField(
            controller: _controller,
            label: 'Username',
            hint: 'Enter your username',
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          const SDTextField(
            label: 'Email',
            hint: 'you@example.com',
            errorText: 'Invalid email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          const SDTextField(
            label: 'Disabled field',
            hint: 'Not editable',
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Dropdown ─────────────────────────────────────────────────────
          SDText.heading3('Dropdown'),
          const SizedBox(height: 12),
          SDDropdown<String>(
            label: 'Country',
            items: _countries,
            value: _country,
            onChanged: (v) => setState(() => _country = v),
          ),
          const SizedBox(height: 12),
          SDDropdown<String>(
            label: 'Disabled dropdown',
            items: _countries,
            value: 'us',
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Multi-Select ─────────────────────────────────────────────────
          SDText.heading3('Multi-Select'),
          const SizedBox(height: 12),
          SDMultiSelect<String>(
            label: 'Technologies',
            items: _tagOptions,
            selected: _tags,
            onChanged: (v) => setState(() => _tags = v),
          ),
          if (_tags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: _tags
                  .map((t) => Chip(
                        label: Text(
                          _tagOptions
                              .firstWhere((i) => i.value == t)
                              .label,
                        ),
                        onDeleted: () =>
                            setState(() => _tags.remove(t)),
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Checkboxes ───────────────────────────────────────────────────
          SDText.heading3('Checkbox'),
          const SizedBox(height: 4),
          SDCheckbox(
            label: 'Accept terms and conditions',
            value: _terms,
            onChanged: (v) => setState(() => _terms = v ?? _terms),
          ),
          SDCheckbox(
            label: 'Subscribe to newsletter',
            value: _newsletter,
            onChanged: (v) => setState(() => _newsletter = v ?? _newsletter),
          ),
          SDCheckbox(
            label: 'Disabled (checked)',
            value: _updates,
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Radio ────────────────────────────────────────────────────────
          SDText.heading3('Radio Group'),
          const SizedBox(height: 4),
          SDRadioGroup<String>(
            label: 'Plan',
            value: _plan,
            options: const [
              SDRadioOption(value: 'free', label: 'Free'),
              SDRadioOption(value: 'pro', label: 'Pro'),
              SDRadioOption(value: 'enterprise', label: 'Enterprise'),
            ],
            onChanged: (v) => setState(() => _plan = v ?? _plan),
          ),
          const SizedBox(height: 8),
          SDRadioGroup<String>(
            label: 'Disabled',
            value: 'free',
            options: const [
              SDRadioOption(value: 'free', label: 'Free'),
              SDRadioOption(value: 'pro', label: 'Pro'),
            ],
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Switch ───────────────────────────────────────────────────────
          SDText.heading3('Switch'),
          const SizedBox(height: 4),
          SDSwitch(
            label: 'Dark mode',
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          SDSwitch(
            label: 'Push notifications',
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          SDSwitch(
            label: 'Disabled switch',
            value: false,
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Slider ───────────────────────────────────────────────────────
          SDText.heading3('Slider'),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: SDSlider(
                  label: 'Volume',
                  value: _volume,
                  divisions: 10,
                  onChanged: (v) => setState(() => _volume = v),
                ),
              ),
              SizedBox(
                width: 40,
                child: SDText.bodySm('${(_volume * 100).round()}%'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SDSlider(
            label: 'Disabled slider',
            value: 0.3,
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Date Picker ──────────────────────────────────────────────────
          SDText.heading3('Date Picker'),
          const SizedBox(height: 12),
          SDDatePicker(
            label: 'Birth date',
            value: _birthDate,
            onChanged: (d) => setState(() => _birthDate = d),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ),
          const SizedBox(height: 12),
          SDDatePicker(
            label: 'Disabled date picker',
            value: DateTime(1990, 6, 15),
            onChanged: (_) {},
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SDDivider.horizontal(),
          const SizedBox(height: 24),

          // ── Full Form ────────────────────────────────────────────────────
          SDText.heading3('Full Form'),
          const SizedBox(height: 12),
          SDForm(
            formKey: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SDTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hint: 'Jane Smith',
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: 12),
                SDTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'jane@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                SDDropdown<String>(
                  label: 'Country',
                  items: _countries,
                  value: _formCountry,
                  onChanged: (v) => setState(() => _formCountry = v),
                ),
                const SizedBox(height: 16),
                SDButton.primary(
                  label: 'Validate',
                  onPressed: () {
                    final valid = _formKey.currentState!.validate();
                    setState(() => _formValidated = valid);
                  },
                  fullWidth: true,
                ),
                if (_formValidated) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SDText.body('Form is valid!'),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
