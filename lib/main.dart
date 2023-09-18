import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:job_finder/providers/Network/network.dart';
import 'package:job_finder/providers/jobs/job_provider.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/util/connection_error.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'consts/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: colors['primary']));

  await Hive.initFlutter();
  await Hive.openBox('bookmark');
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
        ChangeNotifierProvider<NetworkProvider>(
            create: (_) => NetworkProvider()),
      ],
      child: ScreenUtilInit(
        builder: (_, child) => MaterialApp(
          theme: ThemeData()
              .copyWith(scaffoldBackgroundColor: const Color(0xfff4f4f4)),
          debugShowCheckedModeBanner: false,
          home: child,
          builder: EasyLoading.init(),
        ),
        child: const ConnectionChecker(),
      ),
    );
  }
}
