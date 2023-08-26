import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/profile.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/user_profile_update.dart';
import 'package:intl/intl.dart';
import '../../consts/colors.dart';
import '../../data/user_profile_data.dart';
import '../Widgets/Profile_Tile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
                        builder: (context) => const UserProfileUpdate()),
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
        child: Column(
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
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child:
                          const Image(image: AssetImage("assets/mo_ali.jpeg"))),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: UserProfileData.mohamed.userName,
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
                      text: UserProfileData.mohamed.professional!,
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
                      text: UserProfileData.mohamed.phone,
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
                      text: UserProfileData.mohamed.userEmail,
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
                          Icons.cake_outlined,
                          color: Colors.grey[700],
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    CText(
                      text:
                          "Born ${UserProfileData.mohamed.DOB != null ? DateFormat('yyyy-MM-dd').format(UserProfileData.mohamed.DOB!) : ''}",
                      decorations: TextDecorations(
                          fontSize: 16, color: Colors.grey.shade700),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 16, top: 5, right: 10, bottom: 10),
                  child: CText(
                    text: UserProfileData.mohamed.bio!,
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
                ProfileTile(
                  title: tInfo,
                  icon: FontAwesomeIcons.info,
                  onPress: () {},
                  leadingIconColor: colors['primary'],
                ),
                ProfileTile(
                  title: tManagement,
                  icon: FontAwesomeIcons.userCheck,
                  onPress: () {},
                  leadingIconColor: colors['primary'],
                ),
                ProfileTile(
                  title: tPrivacy,
                  icon: Icons.security_outlined,
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
                  onPress: () {},
                  endIcon: false,
                  color: Colors.red,
                  leadingIconColor: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
