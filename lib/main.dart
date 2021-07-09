import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_project/enums/connectivity_status.dart';
import 'package:tentwenty_project/services/connectivity_service.dart';
import 'package:tentwenty_project/ui/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) => ConnectivityService().connectionStatusController.stream,

      child: MaterialApp(
        title: 'Connectivity Aware UI',
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: Home(),
      ),
    );
  }
}


