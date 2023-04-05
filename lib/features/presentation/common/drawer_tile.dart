import 'package:ceylife_digital/utils/app_extensions.dart';
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final DrawerItem drawerItem;
  final VoidCallback callback;

  const DrawerTile({Key key, @required this.icon, @required this.drawerItem, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _handleDrawerItemClick(context);
      },
      key: key,
      leading: Icon(icon, color: Colors.white, size: 26),
      title: Text(
        drawerItem.value,
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 15, color: Colors.white),
      ),
    );
  }

  void _handleDrawerItemClick(BuildContext context) {
    switch (drawerItem) {
      case DrawerItem.PAYMENT_HISTORY:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.PAYMENT_HISTORY_VIEW);
        break;
      case DrawerItem.CUSTOMER_SERVICE_REQUEST:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.CUSTOMER_SERVICE_REQUEST_ROOT_VIEW);
        break;
      case DrawerItem.SETTINGS:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.SETTINGS_VIEW);
        break;
      case DrawerItem.PASSWORD_RESET:
        Navigator.pop(context);
        if(callback!=null) callback();
        break;
      case DrawerItem.BRANCH_LOCATOR:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.BRANCH_VIEW);
        break;
      case DrawerItem.CONTACT_US:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.CONTACT_US_VIEW);
        break;
      case DrawerItem.FAQ:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.FAQ_VIEW);
        break;
      case DrawerItem.FEATURE1:
        break;
      case DrawerItem.FEATURE2:
        break;
      case DrawerItem.LANGUAGE_SELECTION:
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.LANGUAGE_VIEW);
        break;
    }
  }
}
