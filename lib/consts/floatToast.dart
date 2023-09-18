import 'package:flutter/material.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/text.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {super.key, e, required this.toastMessage,  this.type});

  final String toastMessage;
  final String? type;
  void showCustomSnackbar(BuildContext context) {
    Color bcColor;
    Color backColur() {
      if (type == "Success") {
        bcColor = Colors.green;
      } else if (type == "Warning") {
        bcColor = Colors.red.shade500;
      } else if (type == "Warning") {
        bcColor = Colors.orange.shade900;
      } else if (type == "Failure") {
        bcColor = Colors.red;
      } else {
        bcColor = Colors.black;
      }
      return bcColor;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          type == "Success"
              ? const Icon(Icons.check, color: Colors.white)
              : type == "Warning"
                  ? const Icon(Icons.warning, color: Colors.white)
                  : type == "Info"
                      ? const Icon(Icons.info, color: Colors.white)
                      : type == "Failure"
                          ? const Icon(Icons.error, color: Colors.white)
                          : const Icon(Icons.info, color: Colors.white),
          const SizedBox(width: 10), // Spacer
          Text(
            toastMessage,
            style: const TextStyle(
                fontFamily: 'Poppins-Light', fontSize: 14, color: Colors.white),
          ) // Snackbar message
        ],
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      animation: kAlwaysCompleteAnimation,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backColur(),
      margin: EdgeInsets.only(left: 4, right: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showCustomSnackbar(context);
        },
        child: Text('Show Snackbar with Icon'),
      ),
    );
  }
}
