import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/util/dashboard_card.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/dashboard/screens/job_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/users/user_provider.dart';
import '../../../services/local/local_storage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int indexPage = 0;
  List<Widget> screens = [
    DashboardView(),
    JobView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            onTap: (newIndex) {
              if (newIndex > 1) {
                return;
              }
              setState(() {
                indexPage = newIndex;
              });
            },
            buttonBackgroundColor: colors['primary'] as Color,
            backgroundColor: Colors.white,
            color: colors['primary'] as Color,
            items: [
              FaIcon(
                FontAwesomeIcons.chartLine,
                color: Colors.white,
              ),
              FaIcon(
                FontAwesomeIcons.suitcase,
                color: Colors.white,
              ),
              FaIcon(
                FontAwesomeIcons.codePullRequest,
                color: Colors.white,
              ),
              FaIcon(
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
            ]),
        body: screens[indexPage]);
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value != null) {
        var provider = Provider.of<UserProvider>(context, listen: false);
        provider.fetchUser(value['email']).whenComplete(() {
          if (provider.user != null) {
            setState(() {
              username = provider.user!.username;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: EdgeInsets.only(top: 18, left: 9, right: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconImage(iconImagePath: "assets/afro.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: username ?? "Account loading",
                          decorations: TextDecorations(
                              fontSize: 19, family: "Poppins Medium"),
                        ),
                        CText(
                          text: "Corporation",
                          decorations: TextDecorations(
                              fontSize: 15, family: "Poppins Light"),
                        )
                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.arrowRightFromBracket,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 9,
        ),
        Divider(),
        DashboardCard(
          counterTitle: "56",
          subtitle: "Posted Jobs",
          rightIcon: FontAwesomeIcons.suitcase,
        ),
        DashboardCard(
          backgroundColor: Color(0xff27005D),
          counterTitle: "190",
          subtitle: "Request From Applicants",
          rightIcon: FontAwesomeIcons.codePullRequest,
        ),
        DashboardCard(
          backgroundColor: Color(0xffFF6969),
          counterTitle: "4k",
          subtitle: "You Rejected",
          rightIcon: FontAwesomeIcons.readme,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFbcbae5).withOpacity(1),
                  offset: Offset(-1, -7),
                  blurRadius: 10,
                  spreadRadius: -4,
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: "Incoming Requests",
                            decorations: TextDecorations(
                                fontSize: 20, family: "Poppins Medium"),
                          ),
                          CText(
                              text: "This is all requests you get",
                              decorations: TextDecorations(
                                  fontSize: 15, family: "Poppins Light"))
                        ],
                      ),
                      CText(
                          text: "+ 800",
                          decorations: TextDecorations(
                              fontSize: 27,
                              family: "Poppins Bold",
                              color: Colors.green))
                    ],
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: "Pednidng Requests",
                            decorations: TextDecorations(
                                fontSize: 20, family: "Poppins Medium"),
                          ),
                          CText(
                              text: "This is all requests you get",
                              decorations: TextDecorations(
                                  fontSize: 15, family: "Poppins Light"))
                        ],
                      ),
                      CText(
                          text: "+ 200",
                          decorations: TextDecorations(
                              fontSize: 27,
                              family: "Poppins Bold",
                              color: Colors.orangeAccent))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
