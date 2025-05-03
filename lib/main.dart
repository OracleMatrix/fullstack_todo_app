import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      title: "TODO",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
