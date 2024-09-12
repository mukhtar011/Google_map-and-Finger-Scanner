import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(24.9400144,67.1009651),
    zoom: 14,
  );

 List<Marker> _marker = [];
 List<Marker> _list = const [
   Marker(
       markerId: MarkerId('1'),
     position: LatLng(24.9400144,67.1009651),
     infoWindow: InfoWindow(
       title: "My Current Location",
     )
   ),
   Marker(
       markerId:MarkerId('2'),
     position: LatLng( 24.92918, 67.09749),
     infoWindow: InfoWindow(
       title: "Disco bakery",
     ),
   ),
 ];

  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async{
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(24.92918, 67.09749),
                zoom: 14,
              )
              ),
          );
          setState(() {

          });
    },
    ));
  }
}
