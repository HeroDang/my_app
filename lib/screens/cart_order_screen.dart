import 'package:flutter/material.dart';
import 'package:my_app/model/product_item.dart';
import 'package:my_app/provider/cart_order.dart';
import 'package:my_app/provider/order.dart';
import 'package:my_app/screens/order_screen.dart';
import 'package:provider/provider.dart';

class CardOrderScreen extends StatelessWidget {
  static const routeName = '/card-order-products';

  const CardOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartOrder = CartOrderContainer.of(context);
    final cartItems = cartOrder.cardItems;
    final totalPrice = cartOrder.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Card'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Total',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '\$$totalPrice',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<OrderProvider>(context, listen: false).addOrder(cartItems);
                              cartOrder.clearCart();
                              Navigator.of(context).popAndPushNamed(OrderScreen.routeName);
                            },
                            child: const Text(
                              'ORDER NOW',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 2, color: Colors.red)),
                              child: Text(
                                cartOrder.isDeleteMode
                                    ? 'Delete selected'
                                    : 'Delete',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                if (cartOrder.isDeleteMode) {
                                  if (cartOrder.selectedItems.isEmpty) {
                                    cartOrder.tongleDeleteMode();
                                    return;
                                  }
                                  final selectedItems = [
                                    ...cartOrder.selectedItems
                                  ];
                                  cartOrder.deletedSelected();
                                  cartOrder.tongleDeleteMode();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text('Deletec Selected Items'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          cartOrder.undoDelete(selectedItems);
                                          cartOrder.tongleDeleteMode();
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  cartOrder.tongleDeleteMode();
                                }
                              })
                        ],
                      ))
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        if (cartOrder.isDeleteMode)
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                                value: cartOrder.isSelected(cartItems[index]),
                                onChanged: (value) {
                                  cartOrder.tongleSelected(cartItems[index]);
                                }),
                          ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '\$${cartItems[index].price.toString()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems[index].name,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Total: \$' +
                                    (cartItems[index].price *
                                            cartItems[index].quantity)
                                        .toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    CartOrderContainer.of(context)
                                        .degreeProd(cartItems[index]);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'x' + cartItems[index].quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () {
                                    CartOrderContainer.of(context)
                                        .addToCard(cartItems[index]);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
