import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gpt_app/src/routers/app_routers.dart';
import 'package:gpt_app/src/screens/sign_in.dart';
import 'package:gpt_app/src/utilities/my_material_app.dart';
import 'package:gpt_app/src/utilities/shared_preferences_app.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'src/screens/sign_up.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MyMaterialApp(
      title: "Your app",
      initialRoute: '/signin',
      getPages:
        // GetPage(name: '/signup', page: () => SignUp()),
        // GetPage(name: '/signin', page: () => SignIn())
        AppRouters.routes
      ,

    );
  }
}



