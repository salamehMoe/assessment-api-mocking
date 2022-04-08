import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_mockup/registration_screen.dart';
import 'package:login_mockup/reusable-ui/login-page-text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:login_mockup/variables.dart';
import 'home-page.dart';
import 'networking.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
  'email',
]);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const id = 'login-screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    _googleSignIn.disconnect();
    super.initState();
  }

  Future googleSignIn() async {
    try {
      await _googleSignIn.signIn();

      Variables.vUserEmail=_googleSignIn.currentUser?.email ?? ' ';
      print('SIGNED IN ${_googleSignIn.currentUser?.email} and THE PASSED ${Variables.vUserEmail}');
      if(_googleSignIn.currentUser?.email!=null){
        Navigator.pushNamed(context, HomePage.id);
      }

    } catch (e) {
      print('ERROr $e');
    }
  }

  Color textColor = Colors.black54; //Color(0xFFEB5757);
  // (0xFF011627).withOpacity(0.1);
  bool isWrong = false;
  IconData passwordSuffixIcon = CupertinoIcons.eye;
  Color passwordSuffixColor = Colors.black54;
  bool isHidden = true;
  String theUserEmail = '';
  String theUserPass = '';
  bool errorShown = false;
  String theErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
                      theText: 'Welcome',
                      textSize: 32,
                    ),
                    SingInText(
                      theText: 'Enter your credentials to continue',
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
                          if (theUserPass.length < 6) {
                            setState(() {
                              passwordSuffixColor = Color(0xFFEB5757);
                              theErrorMessage =
                                  'Password must be more that 6 charecters';
                              errorShown = true;
                            });
                          } else if (theUserPass.length >= 6 &&
                              EmailValidator.validate(theUserEmail)) {
                            setState(() {
                              errorShown = false;
                              Variables.vUserEmail = theUserEmail;
                            });

                            Networking.logInUser(
                                theUserEmail, theUserPass, context);
                            if (Variables.apiStatus != 0) {
                              setState(() {
                                theErrorMessage =
                                    'Email or Password are incorrect';
                                errorShown = true;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'LOGIN',
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
                    ElevatedButton(
                      onPressed: () {
                        googleSignIn();
                      },
                      child: const Text(
                        'LOGIN WITH GOOGLE',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(color: Colors.blueAccent),
                        minimumSize: const Size(
                          150,
                          35,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('MOVING TO REGISER');
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black54,
                            fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0.0,
                      ),
                    ),
                    Visibility(
                        visible: errorShown,
                        child: Text(
                          theErrorMessage,
                          style: TextStyle(color: Color(0xFFEB5757)),
                        )),
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
