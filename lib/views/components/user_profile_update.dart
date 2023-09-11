import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/data/user_profile_data.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../modals/users/user.dart';

class UserProfileUpdate extends StatefulWidget {
  final User? user;

  const UserProfileUpdate({super.key, this.user});

  @override
  State<UserProfileUpdate> createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  

  final _usernameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  late final password;
  late final userId;
  late String? userImage;
  @override
  void initState() {
    super.initState();
    password = widget.user?.password;
    userId = widget.user?.id;
    _usernameController.text = widget.user?.username ?? '';
    _descriptionController.text = widget.user?.description ?? '';
    _emailController.text = widget.user?.email ?? '';
    _phoneController.text = widget.user?.mobile.toString() ?? 0.toString();
    _cityController.text = widget.user?.regionOrCity ?? '';
    userImage = widget.user!.profile_pic;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
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
              onPressed: () {
                User updateUser = User(
                    id: userId,
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: password,
                    regionOrCity: _cityController.text,
                    mobile: int.parse(_phoneController.text),
                    
                    );
                    Provider.of<UserProvider>(context,listen: false).updateUser(updateUser);
                    // userProvider.updateUser(updateUser);
                    Navigator.pop(context);
              },
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
                          Image.network('${API_BASE_URL}/images/$userImage'),
                ),
              ),),
              const SizedBox(
                height: 20,
              ),
              

              /*  Fields  */
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    // initialValue: widget.user?.username ?? '',
                    controller: _usernameController,
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
                    // initialValue: widget.user?.description!,
                    controller: _descriptionController,
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
                    // initialValue: widget.user?.email,
                    controller: _emailController,
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
                    // initialValue: widget.user?.mobile.toString(),
                    controller: _phoneController,
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
                    // initialValue: widget.user?.regionOrCity,
                    controller: _cityController,
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
