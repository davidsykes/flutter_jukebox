import 'package:flutter/material.dart';

class SelectableItem<T> {
  String name;
  String subtitle;
  T item;
  bool isSelected = false;
  SelectableItem(this.name, this.subtitle, this.item);
}

class MySelectableList<T> {
  void Function(T sItem)? _onSelect;
  late List<SelectableItem<T>> _selectables;

  MySelectableList({void Function(T sItem)? onSelect}) {
    _onSelect = onSelect;
    _selectables = List.empty();
  }

  Widget makeListWidget() {
    return ListView(
      children: _makeItemsList(),
    );
  }

  void refresh(List<T> items, String Function(T item) getName,
      String Function(T item) getSubtitle) {
    _selectables = items
        .map((e) => SelectableItem(getName(e), getSubtitle(e), e))
        .toList();
  }

  List<T> get selectedItems => _selectables
      .where((element) => element.isSelected)
      .map((e) => e.item)
      .toList();

  void selectAll() {
    for (var item in _selectables) {
      if (!item.isSelected && _onSelect != null) {
        _onSelect!(item.item);
      }
      item.isSelected = true;
    }
  }

  List<Widget> _makeItemsList() {
    return _selectables.map((e) => _makeTappableItem(e)).toList();
  }

  Widget _makeTappableItem(SelectableItem<T> sItem) {
    return GestureDetector(
      onTap: () {
        sItem.isSelected = !sItem.isSelected;
        if (_onSelect != null) {
          _onSelect!(sItem.item);
        }
      },
      child: _makeItem(sItem),
    );
  }

  Widget _makeItem(SelectableItem<T> sItem) {
    return ListTile(
      title: Text(sItem.name,
          style: sItem.isSelected
              ? const TextStyle(fontWeight: FontWeight.bold)
              : const TextStyle(fontWeight: FontWeight.normal)),
      subtitle: Text(sItem.subtitle),
    );
  }
}
