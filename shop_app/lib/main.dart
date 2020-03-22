import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // adding providers inside the main root app DOES NOT mean the entire app rebuilds.
    // only widgets that are listening will rebuild.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // create: (BuildContext context) => ProductsProvider(),
          // the provider value constructor helps in reducing issues that may arise when we have list views
          // that listen to the provider. because of the way widgets recycle off-screen, the builder method
          // may cause unexpected behaviour. value constructor also auto-cleans the old data.
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          }),
    );
  }
}
