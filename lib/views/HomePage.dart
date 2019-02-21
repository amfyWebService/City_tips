import 'package:city_tips/core/auth/auth.dart';
import 'package:city_tips/views/BeaconPage.dart';
import 'package:city_tips/views/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:city_tips/views/HistoryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuItem> menu = [
    MenuItem(title: "History", icon: Icons.history, page: HistoryPage()),
    //MenuItem(title: "Beacon", icon: Icons.trip_origin, page: BeaconPage())
    MenuItem(title: "Settings", icon:Icons.settings_applications, page: SettingsPage()),
  ];

  MenuItem _menuItemSelected;
  String get _title => _menuItemSelected.title;

  @override
  void initState() {
    _menuItemSelected = menu[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> buildMenuDrawer(AuthenticationBloc authenticationBloc) {
    List<Widget> menuDrawer = [];

    menuDrawer.add(DrawerHeader(
      child: Text('City tips'),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    ));

    for (int i = 0; i < menu.length; i++) {
      menuDrawer.add(ListTile(
        leading: Icon(menu[i].icon),
        title: Text(menu[i].title),
        onTap: () {
          setState(() {
            _menuItemSelected = menu[i];
          });
          Navigator.pop(context);
        },
      ));
    }

    menuDrawer.add(ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Logout'),
        onTap: () {
          authenticationBloc.dispatch(LoggedOut());
        }));

    return menuDrawer;
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    List<Widget> menuDrawer = buildMenuDrawer(authenticationBloc);

    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: menuDrawer),
      ),
      body: Container(
        child: Center(child: _menuItemSelected.page),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  Widget page;

  MenuItem({@required this.title, @required this.icon, @required this.page});
}
