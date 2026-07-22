import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../services/circuit_service.dart';
import '../../services/ric/ric_validation_result.dart';
import '../../services/ric/ric_validation_service.dart';
import '../../repositories/circuit_repository.dart';

class ProjectValidationScreen extends StatefulWidget {
  final Project project;

  const ProjectValidationScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectValidationScreen> createState() =>
      _ProjectValidationScreenState();
}

class _ProjectValidationScreenState
    extends State<ProjectValidationScreen> {
  final RicValidationService _validator =
  RicValidationService();

  final CircuitService _circuitService =
  CircuitService(
    CircuitRepository(),
  );

  bool _loading = true;

  RicValidationReport? _report;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final circuits =
    await _circuitService.getCircuits(
      widget.project.id,
    );

    final report =
    await _validator.validateProject(
      project: widget.project,
      circuits: circuits,
    );

    if (!mounted) return;

    setState(() {
      _report = report;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _report == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final results = _report!.results;

    final errors = results
        .where(
          (e) => e.severity == RicSeverity.error,
    )
        .length;

    final warnings = results
        .where(
          (e) => e.severity == RicSeverity.warning,
    )
        .length;

    final score = results.isEmpty
        ? 100
        : (((results.length - errors) /
        results.length) *
        100)
        .round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Validación RIC',
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              title: const Text(
                'Cumplimiento',
              ),
              subtitle: Text('$score %'),
              trailing: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text('Errores: $errors'),
                  Text('Advertencias: $warnings'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, index) {
                final item = results[index];

                IconData icon;
                Color color;

                switch (item.severity) {
                  case RicSeverity.info:
                    icon = Icons.info;
                    color = Colors.blue;
                    break;

                  case RicSeverity.warning:
                    icon = Icons.warning;
                    color = Colors.orange;
                    break;

                  case RicSeverity.error:
                    icon = Icons.cancel;
                    color = Colors.red;
                    break;
                }

                return ListTile(
                  leading: Icon(
                    icon,
                    color: color,
                  ),
                  title: Text(item.title),
                  subtitle: Text(item.message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}