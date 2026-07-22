import 'package:flutter/material.dart';

import '../../models/feeder.dart';
import '../../models/project.dart';
import '../../repositories/feeder_repository.dart';
import '../../services/feeder_service.dart';

class FeedersScreen extends StatefulWidget {
  final Project project;

  const FeedersScreen({
    super.key,
    required this.project,
  });

  @override
  State<FeedersScreen> createState() => _FeedersScreenState();
}

class _FeedersScreenState extends State<FeedersScreen> {
  final FeederService _service =
      FeederService(FeederRepository());

  List<Feeder> _feeders = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data =
        await _service.getFeeders(widget.project.id);

    if (!mounted) return;

    setState(() {
      _feeders = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alimentadores - ${widget.project.name}',
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
      ),
      body: _loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : _feeders.isEmpty
              ? const Center(
                  child: Text(
                    'No existen alimentadores.',
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.all(16),
                  itemCount: _feeders.length,
                  itemBuilder: (_, index) {
                    final feeder =
                        _feeders[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            feeder.number
                                .toString(),
                          ),
                        ),
                        title: Text(
                          feeder.name,
                        ),
                        subtitle: Text(
                          '${feeder.current.toStringAsFixed(2)} A\\n'
                              '${feeder.installedPower.toStringAsFixed(0)} W',
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }
}
