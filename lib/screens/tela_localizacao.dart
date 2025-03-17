import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isLocationEnabled = true;
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(-21.984361, -47.111211);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Localização'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ativar localização',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isLocationEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Histórico de localização',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                LocationCard('Rua ABC, Bairro XYZ', '13/03/2025 - 19:45'),
                LocationCard('Avenida DEF, Centro', '13/03/2025 - 19:46'),
                LocationCard('Avenida BCA, Bairro QT', '13/03/2025 - 19:47'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () {},
              child: Text('Limpar Histórico', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final String address;
  final String date;

  LocationCard(this.address, this.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Colors.green),
        title: Text(address),
        subtitle: Text(date),
      ),
    );
  }
}
