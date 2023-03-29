import 'package:flutter/material.dart';
import 'package:my_app/model/product_item.dart';

final List<ProductItem> productItems = <ProductItem>[
  ProductItem(
    id: '1',
    name: 'Android',
    price: 100,
    quantity: 1,
    image:
        'https://cdn-proxy.hoolacdn.com/daotaotester-18154-1fa76n8o6/sgp1/lib/image/banner-khlt-android_oZ7mnxq8oT7PtjBEo-original.png',
    description: 'Ok',
    favorite: false,
  ),
  ProductItem(
    id: '2',
    name: 'Flutter',
    price: 100,
    quantity: 1,
    image:
        'https://cdn-proxy.hoolacdn.com/daotaotester-18154-1fa76n8o6/sgp1/lib/image/z40432088445507d386de74fe06202c5509cfaa75463a7_WWXpPXyooHLXbowKK-original.jpg',
    description: 'Ok',
    favorite: false,
  ),
];

class ProductContainer extends StatefulWidget {
  final Widget child;

  const ProductContainer({Key? key, required this.child}) : super(key: key);

  static _ProductContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_ProductInheritedWidget>())!
        .data;
  }

  @override
  _ProductContainerState createState() {
    return _ProductContainerState();
  }
}

class _ProductContainerState extends State<ProductContainer> {
  final List<ProductItem> _items = productItems;

  List<ProductItem> get items => _items;

  void addProduct(ProductItem productItem) {
    setState(() {
      _items.add(productItem);
    });
  }

  void removeProduct(ProductItem productItem) {
    setState(() {
      _items.removeWhere((element) => productItem.id == element.id);
    });
  }

  void updateProduct(ProductItem productItem) {
    setState(() {
      final index =
          _items.indexWhere((element) => productItem.id == element.id);
      _items[index] = productItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ProductInheritedWidget(data: this, child: widget.child);
  }
}

class _ProductInheritedWidget extends InheritedWidget {
  final _ProductContainerState data;

  const _ProductInheritedWidget(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
