import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLongitudeLatitude extends StatefulWidget {
  const ConvertLongitudeLatitude({super.key});

  @override
  State<ConvertLongitudeLatitude> createState() => _ConvertLongitudeLatitudeState();
}

class _ConvertLongitudeLatitudeState extends State<ConvertLongitudeLatitude> {
String stAddress= '', stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Google Map')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap:() async {
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
              //final coordinates = new Coordinates(24.9172,67.0924);

              setState(() {
                stAddress = locations.last.latitude.toString()+""+locations.last.longitude.toString();
              stAdd = placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString();
              });
              },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(child: Text("Converter")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
