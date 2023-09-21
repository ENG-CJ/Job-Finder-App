import 'package:flutter/material.dart';
import 'package:job_finder/providers/Network/network.dart';
import 'package:job_finder/util/connection_error.dart';
import 'package:job_finder/util/text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../views/pages/login_page.dart';
import 'buton.dart';
import 'helpers/text_helper.dart';

class ConnectionActivity extends StatelessWidget {
  final String? connectionMessage;
  const ConnectionActivity({super.key,this.connectionMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/connection.gif")),
            CText(
              text: "No Internet Connection $connectionMessage",
              decorations: TextDecorations(
                  fontSize: 22,
                  family: "Poppins SemiBold",
                  color: colors['error-color'] as Color),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
              ),
              child: CText(
                text:
                    "You don't seem to have an active internet connection, Check your internet connection",
                decorations: TextDecorations(family: "Poppins Medium"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CButton(
                  onClicked: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => ConnectionChecker()));
                  },
                  backgroundColor: colors['primary'],
                  padding: 20,
                  width: double.maxFinite,
                  widget: Center(
                    child: CText(
                      text: Provider.of<NetworkProvider>(context)
                              .searchConnectivity
                          ? "Connecting..."
                          : "Reload",
                      decorations: TextDecorations(
                          fontSize: 17,
                          family: "Poppins Medium",
                          color: colors['white-color'] as Color),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
