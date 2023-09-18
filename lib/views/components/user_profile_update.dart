import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/api_url.dart';
import 'package:job_finder/consts/texts.dart';
import 'package:job_finder/data/user_profile_data.dart';
import 'package:job_finder/providers/users/user_provider.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../consts/api_url.dart';
import '../../consts/colors.dart';
import '../../mixins/image_picker_resource.dart';
import '../../modals/users/user.dart';
import '../../services/local/local_storage.dart';
import '../../util/profile.dart';

class UserProfileUpdate extends StatefulWidget {
  final User? user;

  const UserProfileUpdate({super.key, this.user});

  @override
  State<UserProfileUpdate> createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate>
    with ImagePickerResource {
  final _usernameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();

  File? imagePath;


  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.user?.username ?? '';
    _descriptionController.text = widget.user?.description ?? '';
    _emailController.text = widget.user?.email ?? '';
    _phoneController.text = widget.user?.mobile.toString() ?? 0.toString();
    _cityController.text = widget.user?.regionOrCity ?? '';
 
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
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
                  imagePath: widget.user!.imagePath,
                  imageFile: imagePath,
                  id: widget.user!.id,
                  username: _usernameController.text,
                  email: _emailController.text,
                  password: widget.user!.password,
                  regionOrCity: _cityController.text,
                  description: _descriptionController.text,
                  mobile: int.parse(_phoneController.text),
                );

                provider.updateUser(updateUser).whenComplete(() {
                  if (!provider.hasError) {
                    LocalStorageSharedPref().getLocalData().then((value) {
                      if (value != null) {
                        provider.fetchUser(value['user_id']).whenComplete(() {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: CText(text: provider.response)));
                        });
                      }
                    });
                  } else {
                    EasyLoading.showError(
                        dismissOnTap: true,
                        duration: Duration(seconds: 7),
                        provider.error);
                  }
                });
              },
              child: CText(
                text: tSaveBtn,
                decorations: TextDecorations(fontSize: 18),
              ))
        ],
      ),
      body: ModalProgressHUD(
        blur: 1,
        color: Colors.white,
        progressIndicator: LoadingAnimationWidget.fourRotatingDots(
            color: colors['primary'] as Color, size: 80),
        inAsyncCall: provider.isSaving,
        child: SingleChildScrollView(
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: imagePath != null
                              ? ProfileImage(
                                  radius: 50,
                                  fromFile: true,
                                  imageFile: imagePath,
                                  asBackgroundImage: true,
                                  imagePath: "assets/default.png")
                              : widget.user!.imagePath == null ||
                                      widget.user!.imagePath == "null" ||
                                      widget.user!.imagePath == "no_profile"
                                  ? ProfileImage(
                                      radius: 50,
                                      asBackgroundImage: true,
                                      imagePath: "assets/default.png")
                                  : ProfileImage(
                                      radius: 50,
                                      fromNetwork: true,
                                      asBackgroundImage: true,
                                      imagePath:
                                          "$API_BASE_URL/uploads/${widget.user!.imagePath}"),
                        ),
                        Positioned(
                          top: 60,
                          right: 0,
                          left: 50,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colors['primary'],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () async {
                                provider.isSaving = true;
                                var image = await getImagePicked();
                                if (image != null) {
                                  setState(() {
                                    imagePath = image;
                                  });
                                }
                                provider.isSaving = false;
                              },
                              color: Colors.red,
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.yellow,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
