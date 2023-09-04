import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/data/user_profile_data.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:intl/intl.dart';

import '../../modals/users/user.dart';

class UserProfileUpdate extends StatelessWidget {
  final User? user;

  const UserProfileUpdate({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CText(
          text: "Edit Profile",
          decorations: TextDecorations(
              color: Colors.black, fontSize: 20, weight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
        actions: [
          TextButton(
              onPressed: () {},
              child: CText(
                text: tSaveBtn,
                decorations: TextDecorations(fontSize: 18),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* Top Profile Section */
              Center(
                child: Container(
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
              ),
              const SizedBox(
                height: 20,
              ),

              /*  Fields  */
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    initialValue: user?.username,
                    decoration: const InputDecoration(
                        labelText: tFullname,
                        hintText: tFullname,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.user)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    initialValue: user?.description!,
                    decoration: const InputDecoration(
                      labelText: tBio,
                      hintText: tBio,
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: user?.email,
                    decoration: const InputDecoration(
                        labelText: tEmail,
                        hintText: tEmail,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: user?.mobile.toString(),
                    decoration: const InputDecoration(
                        labelText: tPhone,
                        hintText: tPhone,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.phone)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: user?.regionOrCity,
                    decoration: const InputDecoration(
                        labelText: tCity,
                        hintText: tCity,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.city)),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
