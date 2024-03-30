import 'dart:io';

import 'package:ecosync/features/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/controller/login_data_store.dart';
import '../controller/logout_controller.dart';
import '../controller/menu_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text("EcoSync"),
          ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Home",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(0);
              },
            ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Manage User",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(1);
              },
            ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Manage Roles",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(2);
              },
            ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Manage Vehicles",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(3);
              },
            ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Manage STS",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(4);
              },
            ),
          DrawerListTile(
            title: "Waste Collection",
            icon: Icons.home,
            press: () {
              context.read<MenuAppController>().controlSelection(5);
            },
          ),
          DrawerListTile(
            title: "Waste Disposal",
            icon: Icons.home,
            press: () {
              context.read<MenuAppController>().controlSelection(6);
            },
          ),
          if (context.read<LoginDataSave>().getData.role_id == 1)
            DrawerListTile(
              title: "Billings",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(7);
              },
            ),
          // DrawerListTile(
          //   title: "Profile",
          //   icon: Icons.home,
          //   press: () {
          //     context.read<MenuAppController>().controlSelection(8);
          //   },
          // ),
          const SizedBox(
            height: 100,
          ),
          DrawerListTile(
            title: "Logout",
            icon: Icons.logout,
            press: () {
              context.read<LogoutController>().logout(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
