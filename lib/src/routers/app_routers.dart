import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_app/src/screens/chat_screen.dart';
import 'package:gpt_app/src/screens/home.dart';
import 'package:gpt_app/src/screens/sign_in.dart';
import 'package:gpt_app/src/screens/sign_up.dart';

class AppRouters{
  static final signUp = GetPage(name: '/signup', page: () => SignUp());
  static final signIn = GetPage(name: '/signin', page: () => SignIn());
  static final home = GetPage(name: '/home', page: () => Home());
  static final chat = GetPage(name: '/chatscreen', page: () => ChatScreen());

  static final List<GetPage> routes = [signIn, signUp, home,chat];

}