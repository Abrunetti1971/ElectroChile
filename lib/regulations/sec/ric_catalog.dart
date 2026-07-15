class RicDocument {
  final int number;
  final String title;
  final String subject;
  final String officialUrl;
  final String version;

  const RicDocument({
    required this.number,
    required this.title,
    required this.subject,
    required this.officialUrl,
    required this.version,
  });

  String get code =>
      'RIC N°${number.toString().padLeft(2, '0')}';
}

class RicCatalog {
  RicCatalog._();

  static const List<RicDocument> documents = [
    RicDocument(
      number: 1,
      title: 'Empalmes',
      subject:
      'Exigencias generales para los empalmes de instalaciones de consumo.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N01-Empalmes.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 2,
      title: 'Tableros eléctricos',
      subject:
      'Requisitos de seguridad para tableros eléctricos.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/06/RIC-N02-Tableros-Electricos-170621-2.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 3,
      title: 'Alimentadores y demanda',
      subject:
      'Alimentadores, subalimentadores y cálculo de demanda.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/03/RIC-N03-Alimentadores-y-demanda-de-una-instalacion-V1.1-1.pdf',
      version: 'V1.1',
    ),
    RicDocument(
      number: 4,
      title: 'Conductores y canalizaciones',
      subject:
      'Conductores, materiales y sistemas de canalización.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N04-Conductores-y-Canalizaciones.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 5,
      title: 'Medidas de protección',
      subject:
      'Protección contra tensiones peligrosas y descargas eléctricas.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N05-Medidas-de-Proteccion-Contra-Tensiones-Peligrosas.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 6,
      title: 'Puesta a tierra',
      subject:
      'Puesta a tierra, protección contra rayos y enlaces equipotenciales.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N06-Puesta-a-Tierra.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 7,
      title: 'Instalaciones de equipos',
      subject:
      'Requisitos para la instalación de equipos eléctricos.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/03/RIC-N07-Instalaciones-de-Equipos-V1.1-1.pdf',
      version: 'V1.1',
    ),
    RicDocument(
      number: 8,
      title: 'Sistemas de emergencia',
      subject:
      'Requisitos de seguridad para sistemas de emergencia.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N08-Sistemas-de-Emergencia.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 9,
      title: 'Sistemas de autogeneración',
      subject:
      'Requisitos de seguridad para sistemas de autogeneración.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N09-Sistemas-de-autogeneracion.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 10,
      title: 'Instalaciones de uso general',
      subject:
      'Requisitos para instalaciones eléctricas de uso general.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N10-Instalaciones-de-uso-general.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 11,
      title: 'Instalaciones especiales',
      subject:
      'Requisitos para instalaciones eléctricas especiales.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N11-Instalaciones-Especiales.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 12,
      title: 'Ambientes explosivos',
      subject:
      'Instalaciones emplazadas en ambientes con riesgo de explosión.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N12-Instalaciones-en-Ambientes-Explosivos.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 13,
      title: 'Subestaciones y salas eléctricas',
      subject:
      'Diseño, operación e inspección de subestaciones y salas eléctricas.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N13-Subestaciones-y-Salas-Electricas.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 14,
      title: 'Eficiencia energética en edificios',
      subject:
      'Exigencias de eficiencia energética para edificios.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N14-Exigencias-de-eficiencia-energetica-para-edificios.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 15,
      title: 'Recarga de vehículos eléctricos',
      subject:
      'Infraestructura para la recarga de vehículos eléctricos.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2024/03/RIC-N15-Version-2024.pdf',
      version: '2024',
    ),
    RicDocument(
      number: 16,
      title: 'Subsistemas de distribución',
      subject:
      'Requisitos de seguridad para subsistemas de distribución.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N16-Subsistemas-de-Distribucio%CC%81n.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 17,
      title: 'Operación y mantenimiento',
      subject:
      'Intervención, operación y verificación de instalaciones.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N17-Operacion-y-Mantenimiento.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 18,
      title: 'Presentación de proyectos',
      subject:
      'Elaboración y presentación de proyectos eléctricos.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/01/RIC-N18-Presentacion-de-Proyectos.pdf',
      version: '2021',
    ),
    RicDocument(
      number: 19,
      title: 'Puesta en servicio',
      subject:
      'Procedimiento para la puesta en servicio de instalaciones.',
      officialUrl:
      'https://www.sec.cl/sitio-web/wp-content/uploads/2021/06/RIC-N19-Puesta-en-Servicio-080621.pdf',
      version: '2021',
    ),
  ];

  static RicDocument? findByNumber(int number) {
    for (final document in documents) {
      if (document.number == number) {
        return document;
      }
    }

    return null;
  }

  static List<RicDocument> search(String text) {
    final query = _normalize(text);

    if (query.isEmpty) {
      return documents;
    }

    return documents.where((document) {
      final content = _normalize(
        '${document.code} '
            '${document.title} '
            '${document.subject}',
      );

      return content.contains(query);
    }).toList();
  }

  static String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }
}