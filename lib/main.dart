import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder/views/components/job_details.dart';
import 'package:job_finder/views/pages/home_page.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

