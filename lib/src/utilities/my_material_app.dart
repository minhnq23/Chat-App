import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/routers/app_routers.dart';

class MyMaterialApp extends GetMaterialApp{
  MyMaterialApp({
    Key? key,
     String title="",
    required String initialRoute,
    required List<GetPage> getPages,
    bool debugShowCheckedModeBanner = false,
  }) : super(
    key: key,
    title: title,
    initialRoute: initialRoute,
    getPages: AppRouters.routes,
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
  );

  @override
  // TODO: implement debugShowCheckedModeBanner
  bool get debugShowCheckedModeBanner => false;

}
