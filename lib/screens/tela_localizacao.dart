import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_agro/widgets/app_bar.dart';
import 'package:smart_agro/widgets/menu_hamburguer.dart';

void main() {
  runApp(MyApp());
}

class LocationRecord {
  final String address;
  final String date;

  LocationRecord(this.address, this.date);
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
  List<LocationRecord> locationHistory = []; // Lista de histórico

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addLocationToHistory(String address) {
    // Simula a adição de um novo local ao histórico com a data atual
    String date = DateTime.now().toString();
    setState(() {
      locationHistory.add(LocationRecord(address, date));
    });
  }

  void _clearLocationHistory() {
    setState(() {
      locationHistory.clear(); // Limpa o histórico
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: 'A'),
      drawer: DrawerWidget(nome: 'Antonio', email: 'joao.silva@exemplo.com'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ativar localização', style: TextStyle(fontSize: 16)),
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
            child: ListView.builder(
              itemCount: locationHistory.length,
              itemBuilder: (context, index) {
                final location = locationHistory[index];
                return LocationCard(location.address, location.date);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: _clearLocationHistory,
              child: Text(
                'Limpar Histórico',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () {
                // Simulando a adição de um novo local
                _addLocationToHistory('Rua ABC, Bairro XYZ');
              },
              child: Text(
                'Adicionar Localização',
                style: TextStyle(color: Colors.white),
              ),
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
