import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///E:/shekhar%20workspace/jaikisan_map/lib/utils/permission_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splashScreenState();
  }
}

class _splashScreenState extends State<Splashscreen> {
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  @override
  void initState() {
    // TODO: implement initState
    launchNextScreen();
    super.initState();
  }

  void launchNextScreen() async {
      Future.delayed(const Duration(milliseconds: 6000), () async {
        Navigator.of(context).pushReplacementNamed('/Home');
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset('assets/logo.png'),
                  Container(
                    padding: new EdgeInsets.all(50),
                    child: Text(
                      "Leveraging technology and long standing value chain networks to facilitate a suite of financial products for theun/underserved rural Indian",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          letterSpacing: 1,
                          wordSpacing: 2),
                    ),
                  ),
                  Image.asset(
                    'assets/farming-prod.png',
                    height: 100,
                  ),
                  Image.asset('assets/farming-invest.png', height: 100),
                  Image.asset('assets/farmer-testm.png', height: 100),
                  Image.asset('assets/farmer-reco.png', height: 100),
                  Image.asset('assets/del.png', height: 100)
                ],
              ),
            )
          ],
        ));
  }
}
