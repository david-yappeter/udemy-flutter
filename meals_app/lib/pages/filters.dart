import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> filters;

  const FilterPage({
    Key? key,
    required this.filters,
    required this.saveFilters,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget buildSwitchListTile({
    required String title,
    required bool value,
    required String subtitle,
    required Function(bool? value) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: onChanged,
    );
  }

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'] as bool;
    _vegetarian = widget.filters['vegetarian'] as bool;
    _vegan = widget.filters['vegan'] as bool;
    _lactoseFree = widget.filters['lactose'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.saveFilters({
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              });

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile(
                  title: 'Gutlen-free',
                  value: _glutenFree,
                  subtitle: 'Only include gluten-free meals',
                  onChanged: (bool? value) {
                    setState(() {
                      _glutenFree = value as bool;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegetarian',
                  value: _vegetarian,
                  subtitle: 'Only include vegetarian meals',
                  onChanged: (bool? value) {
                    setState(() {
                      _vegetarian = value as bool;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegan',
                  value: _vegan,
                  subtitle: 'Only include Vegan meals',
                  onChanged: (bool? value) {
                    setState(() {
                      _vegan = value as bool;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Lactose-free',
                  value: _lactoseFree,
                  subtitle: 'Only include Lactose-free meals',
                  onChanged: (bool? value) {
                    setState(() {
                      _lactoseFree = value as bool;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
