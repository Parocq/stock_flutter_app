import 'package:flutter/material.dart';

class NavigationDrawer {
  Drawer getNavigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text("Header"),
          ),
          ListTile(
            title: Text("accounts"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text("drivers"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/drivers');
            },
          ),
          ListTile(
            title: Text("operators"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/operators');
            },
          ),
          ListTile(
            title: Text("products"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}


