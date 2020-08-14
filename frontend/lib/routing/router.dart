import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/routing/route_names.dart';
import 'package:portfolio/services/string_extension.dart';
import 'package:portfolio/ui/about_page.dart';
import 'package:portfolio/ui/contact_page.dart';
import 'package:portfolio/ui/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    // Switch on the path from the data
    case HomeRoute:
      var username = routingData['username'].toString();
      return _getPageRoute(
          HomePage(
            username: username,
          ),
          settings);
    case ContactRoute:
      return _getPageRoute(ContactPage(), settings);
    case AboutRoute:
      return _getPageRoute(AboutPage(), settings);
//    case EpisodeDetailsRoute:
//      var id = int.tryParse(routingData['id']); // Get the id from the data.
//      return _getPageRoute(EpisodeDetails(id: id), settings);
    default:
      return _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
