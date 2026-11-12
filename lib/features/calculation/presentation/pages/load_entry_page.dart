import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../calculation/domain/solar_calculation_engine.dart';
import '../../data/report_repository.dart';
import 'calculation_result_page.dart';

/// شاشة إدخال أحمال الأجهزة المنزلية.
///
/// كل جهاز يحتوي على القدرة والكمية وساعات التشغيل نهارًا وليلاً.
class LoadEntryPage extends StatefulWidget {
  const LoadEntryPage({super.key});

  @override
  State<LoadEntryPage> createState() => _LoadEntryPageState();
}

class _LoadEntryPageState extends State<LoadEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _reportTitleController = TextEditingController();
  final _engine = const SolarCalculationEngine();
  final _repository = ReportRepository();

  final List<_LoadDraft> _drafts = [_LoadDraft()];
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _reportTitleController.dispose();
    for (final draft in _drafts) {
      draft.dispose();
    }
    super.dispose();
  }

  void _addLoad() {
    setState(() => _drafts.add(_LoadDraft()));
  }

  void _removeLoad(int index) {
    if (_drafts.length == 1) return;
    final removed = _drafts.removeAt(index);
    removed.dispose();
    setState(() {});
  }

  Future<void> _calculateAndSave() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;

    final loads = _drafts.map((draft) => draft.toModel()).toList();
    final input = SolarCalculationInput(loads: loads);

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final result = _engine.calculate(input);
      final reportId = await _repository.saveReport(
        title: _reportTitleController.text.trim().isEmpty
            ? l10n.defaultReportTitle
            : _reportTitleController.text.trim(),
        input: input,
        result: result,
      );

      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              CalculationResultPage(result: result, reportId: reportId),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      // نعرض التفاصيل مؤقتًا للتشخيص؛ سنعيدها إلى رسالة عامة بعد إصلاح السبب.
      setState(() => _errorMessage = '${l10n.calculationSaveFailed}\n$error');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.loadEntryTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.loadEntrySubtitle, style: const TextStyle(fontSize: 17)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reportTitleController,
              decoration: InputDecoration(
                labelText: l10n.reportTitle,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              _drafts.length,
              (index) => _LoadCard(
                draft: _drafts[index],
                index: index,
                canRemove: _drafts.length > 1,
                onRemove: () => _removeLoad(index),
                l10n: l10n,
              ),
            ),
            OutlinedButton.icon(
              onPressed: _isSaving ? null : _addLoad,
              icon: const Icon(Icons.add),
              label: Text(l10n.addAppliance),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.error),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _isSaving ? null : _calculateAndSave,
              icon: _isSaving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.calculate_outlined),
              label: Text(l10n.calculateSystem),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadDraft {
  final name = TextEditingController();
  final wattage = TextEditingController();
  final quantity = TextEditingController(text: '1');
  final dayHours = TextEditingController(text: '0');
  final nightHours = TextEditingController(text: '0');
  bool runsDuringPeak = false;

  ApplianceLoad toModel() => ApplianceLoad(
    name: name.text,
    wattageW: double.parse(wattage.text),
    quantity: int.parse(quantity.text),
    dayHours: double.parse(dayHours.text),
    nightHours: double.parse(nightHours.text),
    runsDuringPeak: runsDuringPeak,
  );

  void dispose() {
    name.dispose();
    wattage.dispose();
    quantity.dispose();
    dayHours.dispose();
    nightHours.dispose();
  }
}

class _LoadCard extends StatefulWidget {
  const _LoadCard({
    required this.draft,
    required this.index,
    required this.canRemove,
    required this.onRemove,
    required this.l10n,
  });

  final _LoadDraft draft;
  final int index;
  final bool canRemove;
  final VoidCallback onRemove;
  final AppLocalizations l10n;

  @override
  State<_LoadCard> createState() => _LoadCardState();
}

class _LoadCardState extends State<_LoadCard> {
  String? _numberValidator(String? value) {
    final number = double.tryParse(value ?? '');
    return number == null || number < 0 ? widget.l10n.invalidNumber : null;
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final l10n = widget.l10n;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.appliance} ${widget.index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                if (widget.canRemove)
                  IconButton(
                    onPressed: widget.onRemove,
                    tooltip: l10n.removeAppliance,
                    icon: const Icon(Icons.delete_outline),
                  ),
              ],
            ),
            TextFormField(
              controller: draft.name,
              decoration: InputDecoration(labelText: l10n.applianceName),
              validator: (value) => value == null || value.trim().isEmpty
                  ? l10n.nameRequired
                  : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: draft.wattage,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.wattage),
                    validator: (value) =>
                        (double.tryParse(value ?? '') ?? 0) <= 0
                        ? l10n.wattageRequired
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: draft.quantity,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.quantity),
                    validator: (value) => (int.tryParse(value ?? '') ?? 0) <= 0
                        ? l10n.quantityRequired
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: draft.dayHours,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.dayHours),
                    validator: _numberValidator,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: draft.nightHours,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.nightHours),
                    validator: _numberValidator,
                  ),
                ),
              ],
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.runsDuringPeak),
              value: draft.runsDuringPeak,
              onChanged: (value) =>
                  setState(() => draft.runsDuringPeak = value),
            ),
          ],
        ),
      ),
    );
  }
}
