import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metrohijab/config/global.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Reports extends StatefulWidget {
  const Reports({ Key? key }) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}


class _ReportsState extends State<Reports> {
  static String BASE_URL = ''+Global.url+'/reports';
     Future<String> getData() async {
  final prefs = await SharedPreferences.getInstance();
    int? _id = prefs.getInt("_id");
   final response = await http.get(Uri.parse(BASE_URL+'/'+_id.toString()),headers: {"Content-Type": "application/json"});
   var data=json.decode(response.body);
    setState(() {
       dataMap={"Sales": double.parse(data['total_sales']),"Inventory":double.parse(data['total_products'])};
      print(data);
    });
    return "";
  }
  Map<String, double> dataMap = {
    "Sales": 0,
    "Inventory": 0,
  };
@override
void initState(){
  getData();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports'),backgroundColor:Colors.purple),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top:30)),
          Center(
            child: Text('Reports',style:TextStyle(fontWeight: FontWeight.bold,fontSize:25.0)),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Pie(dataMap),
          )
        ],
      )
    );
  }
}

class Pie extends StatelessWidget {
  Map<String, double> dataMap ;
  Pie(this.dataMap);
  
  @override
  Widget build(BuildContext context) {
    return PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: [Colors.black45,Colors.blue,Colors.red,Colors.pink,Colors.green,Colors.orange,Colors.yellow],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "Total",
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            );
  }
}