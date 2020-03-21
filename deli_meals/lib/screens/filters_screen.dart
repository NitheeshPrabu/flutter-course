import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildFilter(String title, String description, bool currentValue,
      Function updateFilterValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateFilterValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              var selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildFilter(
                  'Gluten-free',
                  'Only include Gluten-free meals.',
                  _glutenFree,
                  (newValue) => setState(() {
                    _glutenFree = newValue;
                  }),
                ),
                _buildFilter(
                  'Lactose-free',
                  'Only include Lactose-free meals.',
                  _lactoseFree,
                  (newValue) => setState(() {
                    _lactoseFree = newValue;
                  }),
                ),
                _buildFilter(
                  'Vegetarian',
                  'Only include Vegetarian meals.',
                  _vegetarian,
                  (newValue) => setState(() {
                    _vegetarian = newValue;
                  }),
                ),
                _buildFilter(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue) => setState(() {
                    _vegan = newValue;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
