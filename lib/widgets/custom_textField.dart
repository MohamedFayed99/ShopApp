import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClicked;
  final String initialValue;
  CustomTextField({this.hint,this.icon,this.onClicked,this.initialValue});

  String errorMessage(String hintText){
    switch(hint){
      case 'Enter your Name': return 'Name is empty !';
      case 'Enter your Email': return 'Email is empty !';
      case 'Enter your Password': return'Password is empty !';
      case 'Product Name' : return 'Please Enter Product Name !';
      case 'Product Price' : return 'Please Enter Product Price !';
      case 'Product Description' : return 'Please Enter Product Description !';
      case 'Product Category' : return 'Please Enter Product Category !';
      case 'Product Image Path' : return 'Please enter Product Image Path !';
      case 'Enter your Address' : return 'Please Enter the Address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30),
      child: TextFormField(
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: kSecondaryColor,
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )
          ),
        ),
        obscureText: hint =='Enter your Password' ? true : false,
        validator: (value){
          if (value.isEmpty){
            return errorMessage(hint);
          }
          // ignore: missing_return
          //return null;
        },
        onSaved: onClicked,
        initialValue: initialValue,
      ),
    );
  }
}