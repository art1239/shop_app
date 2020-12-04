import 'package:flutter/material.dart';
import 'package:shop_app/screens/OrdersScreen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Best Recipes',
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
              }),
          MenuItem(
              title: 'Order',
              icon: Icons.check_box,
              selectLink: () {
                Navigator.of(context).pushReplacementNamed(OrderScreen.path);
              })
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
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
      onTap: selectLink,
    );
  }
}
