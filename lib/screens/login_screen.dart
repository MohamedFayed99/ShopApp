import 'file:///F:/courses/android%20studio%20projects/final_shop_app/lib/screens/admin_screens/admin_home_screen.dart';
import 'package:finalshopapp/screens/home_screen.dart';
import 'package:finalshopapp/screens/signup_screen.dart';
import 'package:finalshopapp/services/auth.dart';
import 'package:finalshopapp/widgets/custom_textField.dart';
import 'package:finalshopapp/widgets/draw_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey= GlobalKey<FormState>();
  String email,password;
  final auth = Auth();
  bool isLoading = false;
  bool isAdmin = false;
  final adminPassword = 'admin1234';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              DrawLogo(),
              SizedBox(height: height*.1,),
              CustomTextField(
                hint:'Enter your Email',
                icon: Icons.email,
                onClicked: (value){
                  email = value;
                },
              ),
              SizedBox(height: height*.03,),
              CustomTextField(
                  hint: 'Enter your Password',
                  icon: Icons.lock,
                onClicked: (value){
                    password = value;
                },
              ),
              SizedBox(height: height*.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Builder(
                  builder: (context) => FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                      onPressed: () => validateLogin(context),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: height*.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(SignupScreen.id);
                      },
                      child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isAdmin = true;
                          });
                        },
                        child: Text('Iam an Admin',style: TextStyle(
                          color: isAdmin ? kMainColor : Colors.white,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isAdmin = false;
                          });
                        },
                        child: Text('Iam a User',style: TextStyle(
                          color: isAdmin ? Colors.white : kMainColor,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateLogin(BuildContext context) async {

      if(globalKey.currentState.validate()){
        globalKey.currentState.save();
        setState(() {
          isLoading = true;
        });
        if(isAdmin){
          setState(() {
            isLoading = true;
          });
          if(password == adminPassword){
            try {
              final result = await auth.login(email.trim(), password);
              print(result.user.email);
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).popAndPushNamed(AdminScreen.id);
            } catch(e) {
              setState(() {
                isLoading = false;
              });
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message),
                  ));
            }
          } else {
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something went wrong !'),
                ));
          }
        } else {
          try {
            final result = await auth.login(email.trim(), password);
            print(result.user.email);
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).popAndPushNamed(HomeScreen.id);
          } catch(e) {
            setState(() {
              isLoading = false;
            });
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                ));
          }

      }
      setState(() {
        isLoading = false;
      });
    }
  }
}


