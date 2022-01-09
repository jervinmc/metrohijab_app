import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metrohijab/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductDetails extends StatefulWidget {
  dynamic args = Get.arguments;
  @override
  _ProductDetailsState createState() => _ProductDetailsState(this.args);
}

class _ProductDetailsState extends State<ProductDetails> {
  final args;
  bool _load=false;
  _ProductDetailsState(this.args);
  TextEditingController _quantity = new TextEditingController();
  static String BASE_URL = ''+Global.url+'/sales/1';
  static String BASE_URL_DELETE = ''+Global.url+'/products/1';
    void addSales() async {
      final prefs = await SharedPreferences.getInstance();
     print(prefs.getBool("isLoggedIn"));
      var params = {
        "product_name":args[0],
        "quantity":_quantity.text,
        "price":args[2],
        "total_price":int.parse(_quantity.text)*args[2],
        "user_id":prefs.getInt('_id'),
        "product_id":args[3],
      };
      setState(() {
        _load=true;
      });
      final response = await http.post(Uri.parse(BASE_URL),headers: {"Content-Type": "application/json"},body:json.encode(params));
      print(response.body);
      setState(() {
          AwesomeDialog(
                context: context,
                dialogType:DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Successfully Added',
                desc: '',
                btnOkOnPress: () {
                  // _productName.text='';
                  // _quantity.text='';
                  // _price.text='';
                   Get.toNamed('/dashboard');
                },
                )..show();
          _load=false;
        });
      if(response.statusCode==201){
        setState(() {
          AwesomeDialog(
                context: context,
                dialogType:DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Successfully created',
                desc: '',
                btnOkOnPress: () {
                  // _productName.text='';
                  // _quantity.text='';
                  // _price.text='';
                },
                )..show();
          _load=false;
        });
        // notify(DialogType.SUCCES, 'Successfully Created', 'You may now enjoy your account.');
        // _email.text="";
        // _password.text="";
      }
      else{
        _load=false;
      //   notify(DialogType.ERROR, 'Account is already exists.', "Please use other account.");
      //  setState(() {
      //    _load=false;
      //  });
      }
      
  }
  void deleteProducts()async{
    final prefs = await SharedPreferences.getInstance();
      var params = {
        "product_id":args[3],
      };
      setState(() {
        _load=true;
      });
      final response = await http.delete(Uri.parse(BASE_URL_DELETE),headers: {"Content-Type": "application/json"},body:json.encode(params));
      print(response.body);
      setState(() {
          AwesomeDialog(
                context: context,
                dialogType:DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Successfully Deleted',
                desc: '',
                btnOkOnPress: () {
                  // _productName.text='';
                  // _quantity.text='';
                  // _price.text='';
                   Get.toNamed('/dashboard');
                },
                )..show();
          _load=false;
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details',style:TextStyle(color: Colors.white)),backgroundColor: Colors.purple),
      body:Column(
        children: [
          Center(child: Text(args[0],style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold))),
          Text('Quantity : ${args[1]}',style:TextStyle(fontSize: 20.0)),
          Text('Total Price: Php ${args[2]*args[1]}',style:TextStyle(fontSize: 20.0)),
          
          Container(
              padding: EdgeInsets.all( 20),
              child: TextField(
                controller: _quantity,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Quantity',
                ),
              ),
            ),
          Container(
              padding: EdgeInsets.all(20),
              child: new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if(int.parse(_quantity.text)>args[1]){
                        AwesomeDialog(
                context: context,
                dialogType:DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: "Please Enter Valid Quantity",
                desc: "",
                btnOkOnPress: () {
                 
                },
                )..show();
                    }
                    else{
                       if((args[1]-int.parse(_quantity.text))<=3){
                        AwesomeDialog(
                context: context,
                dialogType:DialogType.WARNING,
                animType: AnimType.BOTTOMSLIDE,
                title: "this item is getting out of stock.",
                desc: "",
                btnOkOnPress: () {
                       addSales();
                },
                )..show();
                    }
                 
                    }
                    //  uploadImage();
                  },
                  child: Text('Add to Sales'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                )),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    AwesomeDialog(
                context: context,
                dialogType:DialogType.INFO,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Are you sure you want to delete this products?',
                desc: '',
                btnOkOnPress: (){
                   deleteProducts();
                  //  Get.toNamed('/dashboard');
                },
                btnCancelOnPress: (){

                },
                )..show();
                    //  uploadImage();
                  },
                  child: Text('Delete Product'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                )),
            ),
             _load ? Container(
                            color: Colors.white10,
                            width: 70.0,
                            height: 70.0,
                            child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
                          ) :Text("")
        ],
      )
    );
  }
}