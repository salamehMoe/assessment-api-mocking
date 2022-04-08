import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_mockup/login-page.dart';
import 'package:login_mockup/reusable-ui/login-page-text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login_mockup/variables.dart';
import 'networking.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const id = 'registration-screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Color textColor = Colors.black54; //Color(0xFFEB5757);
  // (0xFF011627).withOpacity(0.1);
  bool isWrong = false;
  IconData passwordSuffixIcon = CupertinoIcons.eye;
  Color passwordSuffixColor = Colors.black54;
  bool isHidden = true;
  String theUserEmail = '';
  String theUserPass = '';
  String theUserName = 'John Doe';
  String theReUserPass = '';

  String theErrorMessage = '';
  bool errorShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingInText(
                      theText: 'We\'d love it if you join us',
                      textSize: 32,
                    ),
                    SingInText(
                      theText: 'Register with your email to continue',
                      textSize: 16,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textColor)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                        ),
                        hintText: 'john@Doe.com',
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          color: textColor,
                          size: 24,
                        ),
                        suffixIcon: Visibility(
                          visible: isWrong,
                          child: const Icon(
                            CupertinoIcons.multiply_circle,
                            color: Color(0xFFEB5757),
                          ),
                        ),
                        fillColor: textColor,
                      ),
                      cursorColor: textColor,
                      onChanged: (value) {
                        if (EmailValidator.validate(value)) {
                          setState(() {
                            theUserEmail = value;
                          });
                        }
                      },
                    ),
                    TextField(
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: passwordSuffixColor)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: passwordSuffixColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: passwordSuffixColor),
                        ),
                        hintText: 'password',
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: passwordSuffixColor,
                          size: 24,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print('Changing Icon');
                            setState(() {
                              (passwordSuffixIcon == CupertinoIcons.eye)
                                  ? passwordSuffixIcon =
                                      CupertinoIcons.eye_slash
                                  : passwordSuffixIcon = CupertinoIcons.eye;
                              (passwordSuffixIcon == CupertinoIcons.eye)
                                  ? isHidden = true
                                  : isHidden = false;
                            });
                          },
                          child: Icon(
                            passwordSuffixIcon,
                            color: passwordSuffixColor,

                            // CupertinoIcons.checkmark_alt_circle,color: Color(0xFF02C697),
                          ),
                        ),
                        fillColor: passwordSuffixColor,
                      ),
                      cursorColor: passwordSuffixColor,
                      onChanged: (value) {
                        setState(() {
                          theUserPass = value;
                        });
                      },
                    ),
                    TextField(
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: passwordSuffixColor)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: passwordSuffixColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: passwordSuffixColor),
                        ),
                        hintText: 're-enter password',
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: passwordSuffixColor,
                          size: 24,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print('Changing Icon');
                            setState(() {
                              (passwordSuffixIcon == CupertinoIcons.eye)
                                  ? passwordSuffixIcon =
                                      CupertinoIcons.eye_slash
                                  : passwordSuffixIcon = CupertinoIcons.eye;
                              (passwordSuffixIcon == CupertinoIcons.eye)
                                  ? isHidden = true
                                  : isHidden = false;
                            });
                          },
                          child: Icon(
                            passwordSuffixIcon,
                            color: passwordSuffixColor,

                            // CupertinoIcons.checkmark_alt_circle,color: Color(0xFF02C697),
                          ),
                        ),
                        fillColor: passwordSuffixColor,
                      ),
                      cursorColor: passwordSuffixColor,
                      onChanged: (value) {
                        setState(() {
                          theReUserPass = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!EmailValidator.validate(theUserEmail)) {
                            setState(() {
                              textColor = const Color(0xFFEB5757);
                              isWrong = true;
                              theErrorMessage =
                                  'Make sure you entered a valid email';
                              errorShown = true;
                            });
                          }
                          if (theUserPass != theReUserPass) {
                            setState(() {
                              theErrorMessage = 'Passwords does not match';
                              passwordSuffixColor = Color(0xFFEB5757);
                              errorShown = true;
                            });
                          }
                          if (theUserPass.length < 6) {
                            setState(() {
                              passwordSuffixColor = Color(0xFFEB5757);
                              theErrorMessage =
                                  'Password must be more that 6 charecters';
                              errorShown = true;
                            });
                          } else if (theUserPass.length >= 6 &&
                              theUserPass == theReUserPass &&
                              EmailValidator.validate(theUserEmail)) {
                            setState(() {
                              errorShown = false;
                              Variables.vUserEmail = theUserEmail;
                            });

                            Networking.registerNewUser(theUserEmail,
                                theUserName, theUserPass, context);
                            if (Variables.apiStatus != 0) {
                              setState(() {
                                theErrorMessage =
                                'Email Already Exists';
                                errorShown = true;
                              });

                            }
                          }
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.black54),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: const BorderSide(color: Colors.black54),
                          minimumSize: const Size(
                            double.infinity,
                            35,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: errorShown,
                        child: Text(
                          theErrorMessage,
                          style: TextStyle(color: Color(0xFFEB5757)),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        print('MOVING TO Login');
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black54,
                            fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
