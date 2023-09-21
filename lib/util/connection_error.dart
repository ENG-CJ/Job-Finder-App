import 'package:flutter/material.dart';
import 'package:job_finder/providers/Network/network.dart';
import 'package:job_finder/util/buton.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/pages/login_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import 'connection_activities.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
   Future.delayed(Duration(seconds: 4)).whenComplete((){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Login()));
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      blur: 1,
      color: Colors.white,
      progressIndicator: LoadingAnimationWidget.fourRotatingDots(
          color: colors['primary'] as Color, size: 80),
      inAsyncCall: true,
      child: Center(
        child: CText(text: "Connecting...."),
      ),
    ));
  }
}
