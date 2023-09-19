import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/services/local/local_storage.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/user_profile_update.dart';

import 'package:provider/provider.dart';
import '../../consts/colors.dart';
import '../../modals/users/user.dart';
import '../Widgets/Profile_Tile.dart';
import '../pages/login_page.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user;
  // String userImage = "assets/icon_user.png";
  // late final profileImage ;

  @override
  void initState() {
    super.initState();
    LocalStorageSharedPref().getLocalData().then((value) {
      if (value == null) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        var provider = Provider.of<UserProvider>(context, listen: false);
      }
    });
    // List<int> userImageBytes = utf8.encode(userImage);
    // profileImage = base64Decode(user?.profile_pic_base64  ?? base64Encode(userImageBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.black,
              )),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileUpdate(user: user)),
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Consumer<UserProvider>(builder: (_, data, child) {
        user = data.user;
        return data.profileLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  /* Profile Header */
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(left: 16, top: 20),
                        decoration: BoxDecoration(
                            // color: Colors.red
                            ),
                        child: user!.imagePath == null ||
                                user!.imagePath == "null" ||
                                user!.imagePath == "no_profile"
                            ? ProfileImage(
                                asBackgroundImage: true,
                                imagePath: "assets/default.png")
                            : ProfileImage(
                                fromNetwork: true,
                                asBackgroundImage: true,
                                imagePath:
                                    "$API_BASE_URL/uploads/${user!.imagePath}"),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: data.user!.username,
                            decorations: TextDecorations(
                                color: Colors.black,
                                fontSize: 20,
                                family: 'Roboto-Bold',
                                weight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CText(
                            text: "Access As : ${data.user!.type}",
                            decorations: TextDecorations(
                                fontSize: 16,
                                color: Colors.grey,
                                family: 'Poppins-Bold'),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  /* Phone And Email */
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 18),
                              child: Icon(
                                Icons.phone,
                                color: Colors.grey[700],
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          CText(
                            text: data.user!.mobile.toString(),
                            decorations: TextDecorations(
                                fontSize: 16, color: Colors.grey.shade700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 18),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.grey[700],
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          CText(
                            text: data.user!.email,
                            decorations: TextDecorations(
                                fontSize: 16, color: Colors.grey.shade700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 16, top: 5, right: 10, bottom: 10),
                        child: CText(
                          createMaxLines: false,
                          wrapText: false,
                          text: data.user!.description!,
                          decorations: TextDecorations(
                              fontSize: 15,
                              color: Colors.black,
                              family: 'Roboto-Bold',
                              weight: FontWeight.w400,
                              height: 1.5),
                        ),
                      ),
                      Divider(),
                      const SizedBox(
                        height: 10,
                      ),

                      /* Other Profile Categories */
                      ProfileTile(
                        title: tBookmark,
                        icon: FontAwesomeIcons.bookmark,
                        onPress: () {},
                        leadingIconColor: colors['primary'],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      ProfileTile(
                        title: tSetting,
                        icon: FontAwesomeIcons.gear,
                        onPress: () {},
                        leadingIconColor: colors['primary'],
                      ),
                      ProfileTile(
                        title: tLogOut,
                        icon: FontAwesomeIcons.arrowRightFromBracket,
                        onPress: () {
                          LocalStorageSharedPref()
                              .removeLocalData("userData")
                              .whenComplete(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => Login()),
                                (route) => false);
                          });
                        },
                        endIcon: false,
                        color: Colors.red,
                        leadingIconColor: Colors.red,
                      ),
                    ],
                  )
                ],
              );
      })),
    );
  }
}
