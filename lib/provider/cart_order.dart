import 'package:flutter/material.dart';

import '../model/product_item.dart';

final List<ProductItem> orderProductsList = [];

class _CardOrderInheritedWidget extends InheritedWidget {
  final _CartOrderContainerState data;

  const _CardOrderInheritedWidget(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class CartOrderContainer extends StatefulWidget {
  const CartOrderContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static _CartOrderContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_CardOrderInheritedWidget>())!
        .data;
  }

  @override
  _CartOrderContainerState createState() {
    return _CartOrderContainerState();
  }
}

class _CartOrderContainerState extends State<CartOrderContainer> {
  final List<ProductItem> _items = orderProductsList;
  final List<ProductItem> _selectedItems = [];

  bool isDeleteMode = false;

  List<ProductItem> get cardItems => _items;

  List<ProductItem> get selectedItems => _selectedItems;

  double get totalPrice {
    double total = 0;
    for (var element in _items) {
      total += element.price * element.quantity;
    }
    return total;
  }

  void addToCard(ProductItem orderProduct) {
    setState(() {
      final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
      if (productIndex < 0) {
        _items.add(orderProduct);
      } else {
        _items[productIndex] =
            orderProduct.copyWith(quantity: _items[productIndex].quantity + 1);
      }
    });
  }

  void degreeProd(ProductItem orderProduct) {
    setState(() {
      final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
      if (_items[productIndex].quantity > 1) {
        _items[productIndex] =
            orderProduct.copyWith(quantity: _items[productIndex].quantity - 1);
      } else {
        _items.removeAt(productIndex);
      }
    });
  }

  void clearCart(){
    setState(() {
      isDeleteMode = false;
      _items.clear();
      _selectedItems.clear();
    });
  }

  void tongleSelected(ProductItem orderProduct) {
    setState(() {
      final productIndex =
          _selectedItems.indexWhere((element) => element.id == orderProduct.id);
      if (productIndex < 0) {
        _selectedItems.add(orderProduct);
      } else {
        _selectedItems.removeWhere((element) => element.id == orderProduct.id);
      }
    });
  }

  void deletedSelected() {
    setState(() {
      for (var element in _selectedItems) {
        _items.removeWhere((e) => e.id == element.id);
      }

      _selectedItems.clear();
    });
  }

  void undoDelete(List<ProductItem> oldSelectedItems){
    setState(() {
      _items.addAll(oldSelectedItems);
      _selectedItems.addAll(oldSelectedItems);
    });
  }

  void tongleDeleteMode(){
    setState(() {
      isDeleteMode = !isDeleteMode;
    });
  }

  bool isSelected(ProductItem orderProduct){
    return _selectedItems.indexWhere((element) => element.id == orderProduct.id) >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return _CardOrderInheritedWidget(data: this, child: widget.child);
  }
}
