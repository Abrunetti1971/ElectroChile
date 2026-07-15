import 'package:flutter/material.dart';

enum EcStatusType {

  success,

  warning,

  error,

  info,

}

class EcStatusChip extends StatelessWidget {

  final String texto;

  final EcStatusType tipo;

  const EcStatusChip({

    super.key,

    required this.texto,

    required this.tipo,

  });

  Color get _background {

    switch (tipo) {

      case EcStatusType.success:
        return Colors.green.shade50;

      case EcStatusType.warning:
        return Colors.orange.shade50;

      case EcStatusType.error:
        return Colors.red.shade50;

      case EcStatusType.info:
        return Colors.blue.shade50;

    }

  }

  Color get _foreground {

    switch (tipo) {

      case EcStatusType.success:
        return Colors.green;

      case EcStatusType.warning:
        return Colors.orange;

      case EcStatusType.error:
        return Colors.red;

      case EcStatusType.info:
        return Colors.blue;

    }

  }

  IconData get _icon {

    switch (tipo) {

      case EcStatusType.success:
        return Icons.verified;

      case EcStatusType.warning:
        return Icons.warning_amber;

      case EcStatusType.error:
        return Icons.cancel;

      case EcStatusType.info:
        return Icons.info;

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(

        horizontal: 14,

        vertical: 10,

      ),

      decoration: BoxDecoration(

        color: _background,

        borderRadius: BorderRadius.circular(12),

      ),

      child: Row(

        mainAxisSize: MainAxisSize.min,

        children: [

          Icon(

            _icon,

            color: _foreground,

            size: 20,

          ),

          const SizedBox(width: 8),

          Text(

            texto,

            style: TextStyle(

              color: _foreground,

              fontWeight: FontWeight.bold,

            ),

          ),

        ],

      ),

    );

  }

}