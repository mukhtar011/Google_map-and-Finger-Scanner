import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiPage extends StatefulWidget {
  const GooglePlacesApiPage({super.key});

  @override
  State<GooglePlacesApiPage> createState() => _GooglePlacesApiPageState();
}

class _GooglePlacesApiPageState extends State<GooglePlacesApiPage> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessioToken = "11223344";

  List<dynamic> _placesList = [];

  @override
  void initState(){
    super.initState();
    _controller.addListener((){
      onChange();
    });
  }
 void onChange(){
    if(_sessioToken == null){
      setState(() {
        _sessioToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }
  void getSuggestion(String input)async{
    String _kPlaces_API_KEY = "AIzaSyDK9EioNR3LYc-3imXa__Q5rAnkmOXbY-Q";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$_kPlaces_API_KEY&sessiontoken=$_sessioToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);

    if(response.statusCode == 200){
      setState(() {
        _placesList = jsonDecode(response.body.toString()) ["prediction"];
      });

    }else {
      throw Exception('Failed to load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text('Google Search Places Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Search Places",
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: _placesList.length,
                    itemBuilder: (context, index){
                 return ListTile(
                   title: Text(_placesList[index]["description"]),
                 );
          }
                ),
        ),
      ]),
            )
    );
  }
}
