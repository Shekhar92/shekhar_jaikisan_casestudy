import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'file:///E:/shekhar%20workspace/jaikisan_map/lib/utils/app_contants.dart';
import 'file:///E:/shekhar%20workspace/jaikisan_map/lib/utils/permission_utils.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mapTool;
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homeScreenState();
  }
}

class _homeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _controller1;
  List<LatLng> selectedPointers = [];
  List<mapTool.LatLng> pointsToCalculate = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String cal = "";
  Set<Polygon> poly = Set<Polygon>();
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imageBytes;
  Color sliderColor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Permission.storage.request().isPermanentlyDenied == true ||
        Permission.location.request().isPermanentlyDenied == true) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      PermissionUtils().requestPermission();
    }
  }

  void resetMarkers() {
    setState(() {
      cal = "";
      poly.clear();
      markers.clear();
      selectedPointers.clear();
      pointsToCalculate.clear();
      _imageBytes = null;
      sliderColor = Colors.transparent;
    });
  }

  void captureImage() async {
    if (await Permission.storage.request().isGranted) {
      final imageBytes = await _controller1?.takeSnapshot();
      setState(() {
        _imageBytes = imageBytes;
      });
      String imageName = "jai_kisan_" + cal;
      screenshotController.capture().then((File image) async {
        final result =
            await ImageGallerySaver.saveImage(_imageBytes, name: imageName);
        print("File Saved to Gallery" + result);
      }).catchError((onError) {
        print(onError);
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      AppSettings.openAppSettings();
    } else {
      PermissionUtils().requestPermission();
    }
  }

  void calculateArea() async {
    if (await Permission.location.request().isPermanentlyDenied) {
      AppSettings.openAppSettings();
    } else {
      pointsToCalculate.clear();
      setState(() {
        sliderColor = Colors.blueAccent;
        for (int i = 0; i < selectedPointers.length; i++) {
          pointsToCalculate.add(mapTool.LatLng(
              selectedPointers[i].latitude, selectedPointers[i].longitude));
          print("Lat long" +
              selectedPointers[i].latitude.toString() +
              selectedPointers[i].longitude.toString());
        }
        cal = (mapTool.SphericalUtil.computeArea(pointsToCalculate) /
                4046.8564224)
            .toString();
        poly.add(Polygon(
            polygonId: PolygonId(selectedPointers.length.toString()),
            points: selectedPointers,
            strokeWidth: 2,
            consumeTapEvents: true,
            fillColor: Color.fromRGBO(94, 5, 5, 0.3),
            zIndex: 5));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Jai Kisan"),
      ),
      body: Stack(
        children: [
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Screenshot(
                controller: screenshotController,
                child: GoogleMap(
                    polygons: poly,
                    onTap: (LatLng latlng) {
                      setState(() {
                        var markerIdVal = markers.length + 1;
                        String mar = markerIdVal.toString();
                        final MarkerId markerId = MarkerId(mar);
                        final Marker marker =
                            Marker(markerId: markerId, position: latlng);
                        markers[markerId] = marker;
                        selectedPointers.add(latlng);
                      });
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(21.146633, 79.088860), zoom: 4),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      setState(() {
                        _controller1 = controller;
                      });
                    },
                    markers: Set<Marker>.of(markers.values)),
              )),
          Align(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30))),
                  child: Text("Calculate area"),
                  elevation: 5,
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  splashColor: Colors.lightGreen,
                  onPressed: calculateArea,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30))),
                  child: Text("Reset markers"),
                  splashColor: Colors.redAccent,
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                  onPressed: resetMarkers,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            alignment: Alignment.centerRight,
          ),
          SlidingUpPanel(
              color: sliderColor,
              panel: Column(
                children: [
                  Container(
                    child: calculatedArea(),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Icon(
                        Icons.camera_rounded,
                        size: 50,
                      ),
                      onTap: captureImage,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  imageVIew()
                ],
              ))
        ],
      ),
    );
  }

  Widget calculatedArea() {
    if (cal != "") {
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text("Calculated area: " + cal + " Acres",
              style:
                  TextStyle(fontSize: 15, color: Colors.white, wordSpacing: 2)),
          SizedBox(
            height: 10,
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  Widget imageVIew() {
    if (_imageBytes != null) {
      return Image.memory(
        _imageBytes,
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 2.5,
      );
    } else {
      return Text("Capture");
    }
  }
}
