import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:totalclinic/progressdialog.dart';
import 'package:totalclinic/services/authentication.dart';
import 'package:totalclinic/services/shared_preferences.dart';
import 'package:totalclinic/signin.dart';
import 'package:totalclinic/services/database.dart';

import 'DoctorDatabase.dart';
import 'SignUpPage.dart';
import 'home.dart';
import 'main.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  //DatabaseMethods databaseMethods = new DatabaseMethods();
  User firebaseUser;
  User currentfirebaseUser;
  String _email, _password, _fullName, _mobileNumber;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
  new TextEditingController();
  TextEditingController userNameLowercaseTextEditingController =
  new TextEditingController();
  TextEditingController emailTextEditingController =
  new TextEditingController();
  TextEditingController passwordTextEditingController =
  new TextEditingController();

  TextEditingController phoneTextEditingController =
  new TextEditingController();





  signUpAccount() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text,
        "phone": phoneTextEditingController.text,

      };

      HelperFunctions.saveUserNamePreference(
          userNameTextEditingController.text);
      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text)
          .then((val) {
        // print("${val.uid}");

        //databaseMethods.setUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(

                            child: Padding(
                              padding: const EdgeInsets.only(top:70.0),
                              child: Image.asset(
                                "assets/images/l.png",

                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(

                              right: 40.0,
                              left: 40.0,
                              bottom: 20.0
                            ),
                            child: Text(
                              'Register If you are a Doctor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color:Colors.black,
                              ),
                            ),
                          ),
                          Container(

                            // transform:
                            // Matrix4.translationValues(0.0, 60.0, 0.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 50.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(

                                  margin: const EdgeInsets.all(20.0),
                                  child: TextFormField(

                                    onChanged: (value) {
                                      _fullName = value;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Name";
                                    },
                                    controller: userNameTextEditingController,
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 25.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: const Color(0xFFF01410),
                                      ),
                                      //
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.all(20.0),
                                  child: TextFormField(

                                    onChanged: (value) {
                                      _email = value;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Please enter a valid email address";
                                    },
                                    controller: emailTextEditingController,
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                      hintText: 'email@address.com',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 25.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.alternate_email,
                                        color:  const Color(0xFFF01410),
                                      ),
                                      //
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.all(20.0),
                                  child: TextFormField(

                                    onChanged: (value) {
                                      _mobileNumber = value;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Phone";
                                    },
                                    controller: phoneTextEditingController,
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                      hintText: 'Phone',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 25.0,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color:  const Color(0xFFF01410),
                                      ),
                                      //
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.all(20.0),

                                  child: TextFormField(
                                    onChanged: (value) {
                                      _password = value;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      return val.length > 6
                                          ? null
                                          : "Password must be greater than 6 characters";
                                    },
                                    controller: passwordTextEditingController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFb1b2c4),
                                      ),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(60),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.05),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color:  const Color(0xFFF01410),
                                      ),
                                      //
                                    ),
                                  ),
                                ),


                                // Container(
                                //   margin: const EdgeInsets.only(
                                //     left: 20.0,
                                //     right: 20.0,
                                //     bottom: 20.0,
                                //   ),
                                //   child: TextFormField(
                                //     keyboardType: TextInputType.visiblePassword,
                                //     validator: (val) {
                                //       return val.length > 6
                                //           ? null
                                //           : "Password must be greater than 6 characters";
                                //     },
                                //     controller: passwordTextEditingController,
                                //     obscureText: true,
                                //     decoration: InputDecoration(
                                //       hintText: 'password',
                                //       hintStyle: TextStyle(
                                //         color: Color(0xFFb1b2c4),
                                //       ),
                                //       border: new OutlineInputBorder(
                                //         borderSide: BorderSide.none,
                                //         borderRadius: BorderRadius.circular(60),
                                //       ),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide: BorderSide(
                                //             color:
                                //             Theme.of(context).primaryColor),
                                //         borderRadius: BorderRadius.circular(60),
                                //       ),
                                //       filled: true,
                                //       fillColor: Colors.black.withOpacity(0.05),
                                //       contentPadding: EdgeInsets.symmetric(
                                //         vertical: 20.0,
                                //         horizontal: 25.0,
                                //       ),
                                //       prefixIcon: Icon(
                                //         Icons.lock_outline,
                                //         color: Color(0xFF6aa6f8),
                                //       ),
                                //       //
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(

                      margin: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: RaisedButton(
                        color: const Color(0xFFF01410),
                        padding: EdgeInsets.all(15),
                        onPressed: () {

                          if (userNameTextEditingController.text.length < 0) {
                            displayToast("Name must be atleast 3 characters.", context);
                          }
                          else if (!emailTextEditingController.text.contains("@")) {
                            displayToast("Email address is not Valid", context);
                          }

                          else if (phoneTextEditingController.text.isEmpty) {
                            displayToast("PhoneNumber are mandatory", context);
                          }
                          //
                          else if (passwordTextEditingController.text.length < 6) {
                            displayToast("Password must be atleast 6 Characters", context);
                          }
                          else  {
                            Future.wait([registerNewUser(context),registerInfirestore(context)]
                            );

                          }

                        },
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Already have an account? Sign In instead.',
                            style: TextStyle(
                                color: Color(0xFFb1b2c4),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignInPage();
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> registerNewUser(BuildContext context)
  async {


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering,Please wait.....",);

        }


    );




    firebaseUser=(await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToast("Error"+errMsg.toString(), context);

    })).user;

    if (firebaseUser != null)// user created

        {
      //save use into to database


      Map userDataMap={
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),

      };
      Doctor.child(firebaseUser.uid).set(userDataMap);


      currentfirebaseUser = firebaseUser;



      displayToast("Congratulation, your account has been created", context);


      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          SignInPage()), (Route<dynamic> route) => false);

    }
    else
    {
      Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }
  Future<void>registerInfirestore(BuildContext context)async{
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _email.trim(), password: _password.trim());

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(_email)
          .set({
        'FullName': _fullName,
        'MobileNumber': _mobileNumber,
        'Email': _email,
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SignInScreen();
      //   }),
      // );

    }
  }

  displayToast(String message,BuildContext context)
  {
    Fluttertoast.showToast(msg: message);



//

  }
}
