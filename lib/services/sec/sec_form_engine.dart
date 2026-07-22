import '../../models/project.dart';
import '../../models/circuit.dart';

enum SecValidationType {
  error,
  warning,
  info,
}

class SecValidationItem {
  final SecValidationType type;
  final String title;
  final String message;
  final String field;

  const SecValidationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.field,
  });
}

class SecValidationResult {
  final bool isValid;
  final double completion;
  final List<SecValidationItem> items;

  const SecValidationResult({
    required this.isValid,
    required this.completion,
    required this.items,
  });

  List<SecValidationItem> get errors =>
      items.where((e) => e.type == SecValidationType.error).toList();

  List<SecValidationItem> get warnings =>
      items.where((e) => e.type == SecValidationType.warning).toList();

  List<SecValidationItem> get infos =>
      items.where((e) => e.type == SecValidationType.info).toList();
}

class SecFormEngine {
  SecValidationResult validateProject({
    required Project project,
    required List<Circuit> circuits,
  }) {
    final items = <SecValidationItem>[];

    int completed = 0;
    const totalChecks = 10;

    void ok() => completed++;

    // Proyecto
    if (project.name.trim().isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.error,
          title: 'Proyecto',
          message: 'Debe indicar el nombre del proyecto.',
          field: 'project.name',
        ),
      );
    }

    // Cliente
    if (project.client.trim().isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.error,
          title: 'Cliente',
          message: 'Debe ingresar el propietario o cliente.',
          field: 'project.client',
        ),
      );
    }

    // Dirección
    if (project.address.trim().isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.error,
          title: 'Dirección',
          message: 'Debe ingresar la dirección.',
          field: 'project.address',
        ),
      );
    }

    // Comuna
    if (project.city.trim().isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.warning,
          title: 'Comuna',
          message: 'Falta indicar la comuna.',
          field: 'project.city',
        ),
      );
    }

    // Distribuidora
    if (project.distributor.trim().isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.warning,
          title: 'Distribuidora',
          message: 'Debe seleccionar la distribuidora.',
          field: 'project.distributor',
        ),
      );
    }

    // Circuitos
    if (circuits.isNotEmpty) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.error,
          title: 'Circuitos',
          message: 'El proyecto no posee circuitos.',
          field: 'circuits',
        ),
      );
    }

    // Potencia
    final totalPower = circuits.fold<double>(
      0,
          (sum, c) => sum + c.power,
    );

    if (totalPower > 0) {
      ok();
    } else {
      items.add(
        const SecValidationItem(
          type: SecValidationType.error,
          title: 'Potencia',
          message: 'No existe potencia instalada.',
          field: 'power',
        ),
      );
    }

    // Alimentadores
    items.add(
      const SecValidationItem(
        type: SecValidationType.info,
        title: 'Alimentadores',
        message: 'Validación disponible en Sprint SEC-02.',
        field: 'feeders',
      ),
    );

    // Puesta a tierra
    items.add(
      const SecValidationItem(
        type: SecValidationType.info,
        title: 'Puesta a tierra',
        message: 'Validación disponible en Sprint SEC-03.',
        field: 'ground',
      ),
    );

    // Empalme
    items.add(
      const SecValidationItem(
        type: SecValidationType.info,
        title: 'Empalme',
        message: 'Validación disponible en Sprint SEC-04.',
        field: 'service',
      ),
    );

    final completion = (completed / totalChecks) * 100;

    return SecValidationResult(
      isValid: items.where((e) => e.type == SecValidationType.error).isEmpty,
      completion: completion,
      items: items,
    );
  }
}