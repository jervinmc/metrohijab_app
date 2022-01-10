import 'package:flutter/material.dart';
import 'package:metrohijab/config/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
class AddInventory extends StatefulWidget {
  const AddInventory({Key? key}) : super(key: key);

  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  static String BASE_URL = ''+Global.url+'/products/1';
  bool _load=false;
  TextEditingController _productName = new TextEditingController();
  TextEditingController _quantity = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}
    void addProduct() async {
      if(!isNumeric(_price.text) || !isNumeric(_quantity.text)){
           AwesomeDialog(
                context: context,
                dialogType:DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Please enter valid value.',
                desc: '',
                btnOkOnPress: () {
                
                  _quantity.text='';
                  _price.text='';
                },
                )..show();
                return;
      }
      if(_productName.text=='' || _price.text=='' || _quantity.text==''){
        AwesomeDialog(
                context: context,
                dialogType:DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Please fill up the form completely.',
                desc: '',
                btnOkOnPress: () {
                },
                )..show();
                return;
      }

      final prefs = await SharedPreferences.getInstance();
     print(prefs.getBool("isLoggedIn"));
      var params = {
        "productName":_productName.text,
        "quantity":_quantity.text,
        "price":_price.text,
        "user_id":prefs.getInt('_id'),
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
                title: 'Successfully created',
                desc: '',
                btnOkOnPress: () {
                  _productName.text='';
                  _quantity.text='';
                  _price.text='';
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
                  _productName.text='';
                  _quantity.text='';
                  _price.text='';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Add Products"), backgroundColor: Colors.purple),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all( 20),
              child: TextField(
                controller: _productName,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Product Name',
                ),
              ),
            ),
            Container(
             padding: EdgeInsets.all( 20),
              child: TextField(
                controller:_quantity,
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
             padding: EdgeInsets.all( 20),
              child: TextField(
                controller: _price,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Price',
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
                    addProduct();
                    //  uploadImage(  );
                  },
                  child: Text('Save'),
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
                dialogType:DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Payment Method',
                desc: '*COD',
                btnOkOnPress: () {
                  addProduct();
                },
                btnCancelOnPress: (){

                }
                )..show();
                    
                    //  uploadImage(  );
                  },
                  child: Text('Payment Method'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
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
        ));
  }
}
