import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> rotaObserver = RouteObserver<ModalRoute<void>>();

class RotaObserver extends RouteObserver<PageRoute<dynamic>> {

  void _log(String evento, PageRoute<dynamic> route) {
    final nomeRota = route.settings.name ?? 'rota sem nome';
    debugPrint('[TRACKING] $evento: $nomeRota');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) _log('Entrou em', route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is PageRoute) _log('Saiu de', route);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is PageRoute) _log('Substituiu por', newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
