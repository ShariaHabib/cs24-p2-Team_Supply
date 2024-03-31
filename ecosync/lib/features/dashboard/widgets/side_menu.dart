import 'dart:io';

import 'package:ecosync/features/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../login/controller/login_data_store.dart';
import '../controller/logout_controller.dart';
import '../controller/menu_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.roleId,
  }) : super(key: key);
  final int roleId;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              padding: EdgeInsets.all(20),
              child: Image.asset(
                "assets/images/logo.png",
                alignment: Alignment.center,
              ),
            ),
          ),
          if (roleId == 1)
            DrawerListTile(
              title: "Home",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(0);
              },
            ),
          if (roleId == 1)
            DrawerListTile(
              title: "Manage User",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(1);
              },
            ),
          if (roleId == 1)
            DrawerListTile(
              title: "Manage Roles",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(2);
              },
            ),
          if (roleId == 1)
            DrawerListTile(
              title: "Manage Vehicles",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(3);
              },
            ),
          if (roleId == 1)
            DrawerListTile(
              title: "Manage STS",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(4);
              },
            ),
          if (roleId == 1 || roleId == 2)
            DrawerListTile(
              title: "Vehicles",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(9);
              },
            ),
          if (roleId == 1 || roleId == 2)
            DrawerListTile(
              title: "Waste Collection",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(5);
              },
            ),
          if (roleId == 1 || roleId == 3)
            DrawerListTile(
              title: "Waste Disposal",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(6);
              },
            ),
          if (roleId == 1)
            DrawerListTile(
              title: "Billings",
              icon: Icons.home,
              press: () {
                context.read<MenuAppController>().controlSelection(7);
              },
            ),
          SizedBox(
            height: roleId == 1 ? 100 : 450,
          ),
          DrawerListTile(
            title: "Logout",
            icon: Icons.logout,
            press: () {
              context.read<LogoutController>().logout(context);
              context.read<MenuAppController>().controlSelection(0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
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
