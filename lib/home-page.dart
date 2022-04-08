import 'package:flutter/material.dart';
import 'package:login_mockup/login-page.dart';
import 'package:login_mockup/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const id = 'home-screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Text(Variables.vUserEmail,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
          ),

        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                print('CLICKED');
                Navigator.pushNamed(context, LoginPage.id);

              },
              child: const Text(
                'LOG OUT',
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
                  15,
                  35,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
