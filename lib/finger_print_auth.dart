import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/google_places_api_page.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintAuth extends StatefulWidget {
  const FingerPrintAuth({super.key});

  @override
  State<FingerPrintAuth> createState() => _FingerPrintAuthState();
}

class _FingerPrintAuthState extends State<FingerPrintAuth> {
  final LocalAuthentication auth = LocalAuthentication();

  authenticateCheck() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);

    if (isAvailable) {
      bool result = await auth.authenticate(
        localizedReason: "Scan your Finger",
      );
      if(result){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> GooglePlacesApiPage()),
        );
    } else{
      print('Permission Denied');
    }
  } else {
  print("No biometric Sensor detected");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Login to Home Page"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  authenticateCheck();
                });
              },
              child: Text("Authenticate"),),
        ],
      ),

    );
  }
}
