import 'package:app1/controller/app_controller.dart';
import 'package:app1/pages/image_upload.dart';
import 'package:app1/pages/login_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue,
        brightness: AppController.instance.theme ? 
          Brightness.dark :
          Brightness.light
          ),
        
        initialRoute: '/',
        routes:{
          '/': (context) => LoginPage(),
          '/upload': (context) => ImageUpload(),
        },
        );
      },
       
    
    
    );
  }

} 