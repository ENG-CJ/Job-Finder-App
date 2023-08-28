import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder/views/components/job_details.dart';
import 'package:job_finder/views/pages/applied_page.dart';
import 'package:job_finder/views/pages/home_page.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:job_finder/views/pages/on_boarding.dart';
import 'package:job_finder/views/pages/registrations/conpany.dart';
import 'package:job_finder/views/pages/registrations/user_reg.dart';
import 'package:job_finder/views/pages/user_type_page.dart';

import 'consts/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: colors['primary']
  ));
  runApp(const JobFinder());
}

class JobFinder extends StatelessWidget {
  const JobFinder({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xfff4f4f4)
      ),
      debugShowCheckedModeBanner: false,
      home: OnBoarding(),

    );
  }
}

