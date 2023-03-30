import 'package:flutter/material.dart';
import 'package:my_app/drawer_menu.dart';
import 'package:my_app/provider/cart_order.dart';
import 'package:my_app/provider/product.dart';
import 'package:my_app/screens/cart_order_screen.dart';
import 'package:my_app/screens/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = '/product-list';

  const ProductListScreen({super.key});

  @override
  ProductListScreenState createState() {
    return ProductListScreenState();
  }
}

class ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final productContainer = ProductContainer.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer : const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          CardWidget(
              count: CartOrderContainer
                  .of(context)
                  .cardItems
                  .length,
              onTap: () {
                Navigator.pushNamed(context, CardOrderScreen.routeName);
              })
        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 600 ? 3 : 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2 / 2,
          ),
          itemCount: productContainer.items.length,
          itemBuilder: (context, index) {
            final product = productContainer.items[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailSreen.routeName, arguments: product);
                  },
                  child: Image(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  leading: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        product.favorite = !product.favorite;
                      });
                    },
                    icon: product.favorite ? Icon(Icons.favorite) : Icon(
                        Icons.favorite_border),
                  ),
                  title: Text(
                    product.name,
                    textAlign: TextAlign.center,
                  ),
                  trailing: CardWidget(
                    count: CartOrderContainer.of(context)
                      .cardItems
                      .firstWhere((item) => item.id == product.id, orElse: () => product.copyWith(quantity: 0),)
                      .quantity,
                    onTap: (){
                      CartOrderContainer.of(context).addToCard(product);
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const CardWidget({Key? key, required this.count, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          IconButton(onPressed: onTap, icon: const Icon(Icons.shopping_cart)),
          Positioned(
            right: 5,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.5),
              ),
              constraints: const BoxConstraints(
                minHeight: 15,
                minWidth: 15,
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
