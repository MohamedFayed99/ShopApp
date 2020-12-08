import 'package:finalshopapp/screens/home_screen.dart';
import 'package:finalshopapp/screens/login_screen.dart';
import 'package:finalshopapp/services/auth.dart';
import 'package:finalshopapp/widgets/custom_textField.dart';
import 'package:finalshopapp/widgets/draw_logo.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


import '../constants.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> globalKey= GlobalKey<FormState>();
  String email,password;
  final auth = Auth();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              DrawLogo(),
              SizedBox(height: height*.04,),
              CustomTextField(
                  hint:'Enter your Name',
                  icon: Icons.perm_identity,
                  onClicked: (value){


                  },
              ),
              SizedBox(height: height*.02,),
              CustomTextField(
                  hint: 'Enter your Email',
                  icon: Icons.email,
                  onClicked: (value){
                    email = value;
                  },
              ),
              SizedBox(height: height*.02,),
              CustomTextField(
                hint: 'Enter your Password',
                icon: Icons.lock,
                onClicked: (value){
                    password = value;

                },

              ),
              SizedBox(height: height*.03,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Builder(
                  builder:(context) => FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if(globalKey.currentState.validate()){
                          globalKey.currentState.save();
                          try {
                            final result = await auth.signUp(
                                email.trim(), password);
                            print(result.user.email);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).popAndPushNamed(HomeScreen.id);
//                            Navigator.of(context).pushReplacement(
//                                MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
//                            );
                          } catch(e){
                            setState(() {
                              isLoading = false;
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                )
                            );
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: height*.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


