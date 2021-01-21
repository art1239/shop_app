import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/OrdersScreen.dart';
import 'package:shop_app/screens/UserManagingProducts_screen.dart';
import 'package:shop_app/screens/addOrEditProduct_screen.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_catalog_screen.dart';
import './providers/products.dart';

import 'providers/Order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(),
          update: (ctx, auth, previousProudctState) =>
              Products(authToken: auth.token),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (context, auth, previousOrders) =>
              Orders(authToken: auth.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authMode, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.red,
              accentColor: Colors.grey,
              fontFamily: 'Lato'),
          home: authMode.isAuth ? ProductsCatalog() : AuthScreen(),
          routes: {
            ProductDetail.path: (ctx) => ProductDetail(),
            CartScreen.path: (ctx) => CartScreen(),
            OrderScreen.path: (ctx) => OrderScreen(),
            UserProductScreen.path: (ctx) => UserProductScreen(),
            AddEditProduct.path: (ctx) => AddEditProduct(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Text(this.title),
      ),
    );
  }
}
