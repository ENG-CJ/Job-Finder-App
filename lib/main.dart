import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/views/dashboard/screens/add_job.dart';
import 'package:job_finder/views/dashboard/screens/dashboard.dart';
import 'package:job_finder/views/dashboard/screens/job_view.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:job_finder/views/pages/registrations/conpany.dart';
import 'package:job_finder/views/pages/registrations/user_reg.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<JobProvider>(create: (_) => JobProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData()
            .copyWith(scaffoldBackgroundColor: const Color(0xfff4f4f4)),
        debugShowCheckedModeBanner: false,
        home: const Login(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
