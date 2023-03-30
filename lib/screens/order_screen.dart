import 'package:flutter/material.dart';
import 'package:my_app/drawer_menu.dart';
import 'package:my_app/provider/order.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('order Screen'),
      ),
      body: Builder(builder: (context) {
        final orderItems =
            Provider.of<OrderProvider>(context, listen: true).items;
        return ListView.separated(
            itemBuilder: (context, index) {
              final orderItem = orderItems[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(orderItem.name,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(orderItem.price.toString()),
                  ),
                  ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, productIndex) {
                        final product = orderItem.products[productIndex];
                        return ListTile(
                          title: Text(product.name),
                          subtitle:
                              Text('${product.price} x ${product.quantity}'),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: orderItem.products.length)
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: orderItems.length);
      }),
    );
  }
}
