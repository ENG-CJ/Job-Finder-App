import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:job_finder/views/pages/user_type_page.dart';
import 'package:provider/provider.dart';

import 'consts/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: colors['primary']));
  runApp(const JobFinder());
}

class JobFinder extends StatelessWidget {
  const JobFinder({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData()
            .copyWith(scaffoldBackgroundColor: const Color(0xfff4f4f4)),
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
