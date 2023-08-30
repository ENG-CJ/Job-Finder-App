import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/data/user_profile_data.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:intl/intl.dart';

class UserProfileUpdate extends StatelessWidget {
  const UserProfileUpdate({super.key});

  @override



  Widget build(BuildContext context) {
    final TextEditingController _dobController = TextEditingController();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      }
    }
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
                    initialValue: UserProfileData.mohamed.userName,
                    decoration: const InputDecoration(
                        labelText: tFullname,
                        hintText: tFullname,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.user)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 5,
                    initialValue: UserProfileData.mohamed.bio,
                    decoration: const InputDecoration(
                      labelText: tBio,
                      hintText: tBio,
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: UserProfileData.mohamed.userEmail,
                    decoration: const InputDecoration(
                        labelText: tEmail,
                        hintText: tEmail,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: UserProfileData.mohamed.phone,
                    decoration: const InputDecoration(
                        labelText: tPhone,
                        hintText: tPhone,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.phone)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: UserProfileData.mohamed.city,
                    decoration: const InputDecoration(
                        labelText: tCity,
                        hintText: tCity,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.city)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: UserProfileData.mohamed.professional,
                    decoration: const InputDecoration(
                        labelText: tProfession,
                        hintText: tProfession,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: UserProfileData.mohamed.languages != null
                        ? UserProfileData.mohamed.languages!.join(",")
                        : null,
                    decoration: const InputDecoration(
                        labelText: tLanguages,
                        hintText: tLanguages,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.language)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _dobController,
                    // initialValue: UserProfileData.mohamed.DOB != null
                    //     ? DateFormat('yyyy-MM-dd')
                    //         .format(UserProfileData.mohamed.DOB!)
                    //     : null,
                    onTap: ()=> _selectDate(context),
                    decoration: const InputDecoration(
                        labelText: tDOP,
                        hintText: tDOP,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.cakeCandles)),
                  ),
                  const SizedBox(
                    height: 10,
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
