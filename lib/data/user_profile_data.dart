import 'dart:convert';
import 'package:job_finder/modals/Profile/profile_modal.dart';

class UserProfileData {
  static Profile mohamed = Profile(
    userName: "Mohamed Ali Abdi",
    userEmail: "dudu921@gmail.com",
    phone: "+252613625352",
    DOB: DateTime(1997, 7, 21),
    professional: "Software Engineer",
    bio: getBioById(1),
    // imageUrl: "assets/mo_ali.jpeg"
  );
  static Profile abdirahman = Profile(
    userName: "Abdirahman Haji ",
    userEmail: "abdirah24@gmail.com",
    phone: "613625352",
    DOB: DateTime(2002, 1, 21),
    professional: "Software Engineer",
    languages: ['Somali','English'],
    bio: getBioById(2),
    // imageUrl: "assets/abdirahman_cj.jpeg",
  );



  static String getBioById(int id) {
    // Read the JSON data from the file.
    String jsonData = '''
      {
        "bio": [
          {
            "id": 1,
            "bio": "Enthusiastic Tech Gig Learning Android and IOS Dev | Java Geek😎 | Dart⭐| C#(Winforms), Html&Css Javascrip(Reactjs🤩 and Nodejs) and last but not the when I'm not immersed in lines of code you'll find me outdoors, indulging in my love for Chess♟"
          },
          {
            "id": 2,
            "bio": "A passionate and innovative software engineer with a relentless curiosity for crafting efficient and elegant solutions to complex technical challenges."
          },
          {
            "id": 3,
            "bio": "..."
          }
        ]
      }
    ''';


    Map<String, dynamic> data = json.decode(jsonData);

    Map<String, dynamic> bioObject = data['bio'].firstWhere((bio) => bio['id'] == id, orElse: () => null);

    if (bioObject != null) {
      return bioObject['bio'];
    } else {
      return '';
    }
  }
}
