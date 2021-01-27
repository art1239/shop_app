import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/OrdersScreen.dart';
import 'package:shop_app/screens/UserManagingProducts_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Welcome ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MenuItem(
            title: 'Shop',
            icon: Icons.shop,
            selectLink: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          MenuItem(
            title: 'Order',
            icon: Icons.check_box,
            selectLink: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.path);
            },
          ),
          Divider(),
          MenuItem(
            title: 'Manage',
            icon: Icons.insert_chart,
            selectLink: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.path);
            },
          ),
          Divider(),
          MenuItem(
            title: 'Log Out',
            icon: Icons.logout,
            selectLink: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function selectLink;
  const MenuItem({
    this.title,
    this.icon,
    this.selectLink,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.red,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      onTap: selectLink,
    );
  }
}
