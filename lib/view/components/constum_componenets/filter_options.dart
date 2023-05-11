import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final Function(String) onFilterSelected;
  final List<String> selectedFilters;

  const FilterOptions({
    Key? key,
    required this.onFilterSelected,
    required this.selectedFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading:
              selectedFilters.contains('All') ? const Icon(Icons.check) : null,
          title: const Text('All'),
          onTap: () => onFilterSelected('All'),
        ),
        ListTile(
          leading: selectedFilters.contains('event')
              ? const Icon(Icons.check)
              : null,
          title: const Text('event'),
          onTap: () => onFilterSelected('event'),
        ),
        ListTile(
          leading: selectedFilters.contains('General')
              ? const Icon(Icons.check)
              : null,
          title: const Text('General'),
          onTap: () => onFilterSelected('General'),
        ),
        ListTile(
          leading:
              selectedFilters.contains('job') ? const Icon(Icons.check) : null,
          title: const Text('job'),
          onTap: () => onFilterSelected('job'),
        ),
        ListTile(
          leading: selectedFilters.contains('Esprit')
              ? const Icon(Icons.check)
              : null,
          title: const Text('Esprit'),
          onTap: () => onFilterSelected('Esprit'),
        ),
        ListTile(
          leading: selectedFilters.contains('other')
              ? const Icon(Icons.check)
              : null,
          title: const Text('other'),
          onTap: () => onFilterSelected('other'),
        ),
        ListTile(
          leading: selectedFilters.contains('internship')
              ? const Icon(Icons.check)
              : null,
          title: const Text('internship'),
          onTap: () => onFilterSelected('internship'),
        ),
      ],
    );
  }
}
