import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(24.92918, 67.09749),
    zoom: 14,
  );
  final List<Marker> _marker = <Marker> [Marker(
      markerId: MarkerId("1"),
     position: LatLng(24.92918, 67.09749),
    infoWindow: InfoWindow(
      title: 'The Current Location'
    )
  )
  ];
 loadData(){
   getUserCurrentLocation().then((value)async{
     print('My Current Location');
     print(value.latitude.toString()+value.longitude.toString());

     _marker.add(
         Marker(
             markerId: MarkerId('2'),
             position: LatLng(value.latitude,value.longitude),
             infoWindow: InfoWindow(
                 title: "My Current Location"
             )
         )
     );
     CameraPosition cameraPosition = CameraPosition(
       target: LatLng(value.latitude, value.longitude),
       zoom: 14,
     );
     final GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
     setState(() {

     });
   });
 }
  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){
      
    }).onError((error, stackTrace){
      print("error"+ error.toString());
    });
    return Geolocator.getCurrentPosition();

  }

  @override
  void initState() {

    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
      markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          child: Icon(Icons.local_activity),
          ),
    );
  }
}
