import 'ric_conductors_validator.dart';
import 'ric_project_validator.dart';
import 'ric_protections_validator.dart';
import 'ric_validator.dart';
import 'voltage_drop_validator.dart';

class RicRegistry {
  final List<RicValidator> _validators = [];

  RicRegistry({
    Iterable<RicValidator>? validators,
  }) {
    if (validators == null) {
      registerDefaults();
    } else {
      registerAll(validators);
    }
  }

  List<RicValidator> get validators =>
      List.unmodifiable(_validators);

  int get length => _validators.length;

  bool get isEmpty => _validators.isEmpty;

  bool get isNotEmpty => _validators.isNotEmpty;

  void registerDefaults() {
    register(const RicProjectValidator());
    register(const RicConductorsValidator());
    register(const RicProtectionsValidator());
    register(const VoltageDropValidator());
  }

  void register(RicValidator validator) {
    if (_validators.any((v) => v.id == validator.id)) {
      return;
    }

    _validators.add(validator);
  }

  void registerAll(
      Iterable<RicValidator> validators,
      ) {
    for (final validator in validators) {
      register(validator);
    }
  }

  bool unregister(String validatorId) {
    final index = _validators.indexWhere(
          (validator) => validator.id == validatorId,
    );

    if (index < 0) {
      return false;
    }

    _validators.removeAt(index);
    return true;
  }

  RicValidator? findById(String validatorId) {
    for (final validator in _validators) {
      if (validator.id == validatorId) {
        return validator;
      }
    }

    return null;
  }

  void clear() {
    _validators.clear();
  }
}