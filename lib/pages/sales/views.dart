import 'package:flutter/material.dart';
import 'package:metrohijab/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  bool _load = false;
  int _id = 0;
  List data = [];
  static String BASE_URL = '' + Global.url + '/products';

  Future<String> getData() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    final response = await http.get(Uri.parse(BASE_URL + '/' + _id.toString()),
        headers: {"Content-Type": "application/json"});
setState(() {
      _load = false;
    });
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
      appBar: AppBar(
        title: Text('Sales'),
        backgroundColor: Colors.purple,
      ),
      body: _load
          ? Center(
              child: new CircularProgressIndicator(),
            )
          : data.length==0 ? Text('No data.') : new ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  onTap: () {},
                  title: Text(data[index]['product_name']),
                  subtitle: Text('Total Quantity: ${data[index]['quantity']}'),
                  trailing: Text('Total Price - Php ${data[index]['price']}'),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
    );
  }
}
