import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metrohijab/pages/AddInventory/views.dart';
import 'package:metrohijab/pages/dashboard/views.dart';
import 'package:metrohijab/pages/inventory/views.dart';
import 'package:metrohijab/pages/login/views.dart';
import 'package:metrohijab/pages/product_details/views.dart';
import 'package:metrohijab/pages/reports/views.dart';
import 'package:metrohijab/pages/sales/views.dart';
import 'package:metrohijab/pages/signup/views.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter',
      theme: ThemeData(
      ),
      getPages: [
        GetPage(name: "/login", page:()=>Login()),
        GetPage(name: "/dashboard", page:()=>Dashboard()),
        GetPage(name: "/addinventory", page:()=>AddInventory()),
        GetPage(name: "/reports", page:()=>Reports()),
        GetPage(name: "/inventory", page:()=>Inventory()),
        GetPage(name: "/sales", page:()=>Sales()),
        GetPage(name: "/productdetails", page:()=>ProductDetails()),
        GetPage(name: "/signup", page:()=>SignUp()),
        // GetPage(name: "/products", page:()=>Products()),
        // GetPage(name: "/cart", page:()=>Cart()),
        // GetPage(name: "/favorites", page:()=>Favorites()),
        // GetPage(name: "/product_details", page:()=>ProductDetails()),
      ],
      initialRoute: "/login"  ,
    );
  }
}
