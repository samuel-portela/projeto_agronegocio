import 'package:geolocator/geolocator.dart';

Future<Position?> obterLocalizacaoAtual() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Verifica se os serviços de localização estão habilitados
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Pode exibir um alerta para o usuário
    return null;
  }

  // Verifica a permissão de localização
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissão negada
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissão negada permanentemente
    return null;
  }

  // Pega a posição atual
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
