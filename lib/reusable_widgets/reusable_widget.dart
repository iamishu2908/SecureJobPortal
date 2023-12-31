import 'package:flutter/material.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

Container reusableTextContainer(String text, double Width) {
  return Container(
    width: Width,
    height: 25,
    alignment: Alignment.topLeft,
    child: Text(
      text,
      style: TextStyle(color: primarytheme,
          fontSize: 15,
          fontWeight: FontWeight.w500
      ),
      textAlign: TextAlign.left,
    ),
  );
}

TextField reusableTextField(String text, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    maxLines: 1,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.grey.shade500,
    style: TextStyle(color: Colors.grey.shade600),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.shade500,
      fontSize: 14),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 1, style: BorderStyle.none),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.indigo.shade900),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
    height: 55,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade500;
            }
            return primarytheme;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
    ),
  );
}