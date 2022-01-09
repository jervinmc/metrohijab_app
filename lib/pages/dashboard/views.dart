import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _email = '';
  void getPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString("_email")!;

      print(_email);
    });
  }

  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    _email,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
              // ListTile(
              //   trailing: Icon(Icons.settings),
              //   title: const Text('Settings'),
              //   onTap: () {
              //     Get.toNamed('/profile');
              //   },
              // ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      animType: AnimType.BOTTOMSLIDE,
                      title: "Are you sure you want to logout ?",
                      btnOkOnPress: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        Navigator.pop(context);
                        Get.toNamed('/login');
                        // runApp(());
                      },
                      btnCancelOnPress: () {})
                    ..show();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Get.toNamed('/sales');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.store,
                                size: 120,
                                color: Colors.purple,
                              ),
                              Text(
                                'View Sales',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                  Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Get.toNamed('/reports');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.analytics,
                                size: 120,
                                color: Colors.purple,
                              ),
                              Text(
                                'Reports',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Get.toNamed('/addinventory');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 120,
                                color: Colors.purple,
                              ),
                              Text(
                                'Add Product',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                  Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Get.toNamed('/inventory');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.inventory,
                                size: 120,
                                color: Colors.purple,
                              ),
                              Text(
                                'View Products',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                ],
              ),
            ],
          ),
        ));
  }
}
