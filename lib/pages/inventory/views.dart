import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metrohijab/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Inventory extends StatefulWidget {
  const Inventory({ Key? key }) : super(key: key);

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool _load=false;
  int _id = 0 ;
  List data=[];
static String BASE_URL = ''+Global.url+'/sales';

  Future<String> getData() async {
    setState(() {
      _load=true;
    });
    final prefs = await SharedPreferences.getInstance();
   var _id = prefs.getInt("_id");
    final response = await http.get(
        Uri.parse(BASE_URL +'/'+ _id.toString()),
        headers: {"Content-Type": "application/json"});

    this.setState(() {
      try {
        _load = false;
        data = json.decode(response.body);
      } finally {
        _load = false;
      }
    });
    return "";
  }

  @override
  void initState() {
    this.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('Inventory'),backgroundColor: Colors.purple,),
      body:_load ?  Center(child: new CircularProgressIndicator(),
                          ) : new ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  onTap: () {
                    Get.toNamed('/productdetails',arguments:[data[index]['product_name'],data[index]['quantity'],data[index]['price'],data[index]['id']]);
                  },
                  title: Text(data[index]['product_name']),
                  subtitle: Text( 'quantity: ${data[index]['quantity']}x'),
                  trailing: Text('Php ${data[index]['price']}'),
                );
              },separatorBuilder: (context, index) {
                  return Divider();
                },
            ),
            
    );
  }
}