

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import '../add_skills.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {super.key, required this.result, required this.questionLength});
  final int result;
  final int questionLength;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whitetheme,
      content: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Result:',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w800,
                    color: Colors.indigo[900],
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 20.0),
                CircleAvatar(
                    radius: 60.0,
                    backgroundColor: result == questionLength / 2
                        ? Colors.yellow
                        : result < questionLength / 2
                            ? incorrect
                            : correct,
                    child: Text(
                      '$result / $questionLength',
                      style: const TextStyle(fontSize: 30.0,
                      color: Colors.white),
                    )),
                const SizedBox(height: 20.0),
                Text(
                  result == questionLength / 2
                      ? 'Almost there'
                      : result < questionLength / 2
                          ? 'Better Luck next time!'
                          : 'Great!',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo[900],
                      fontSize: 15,
                    ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSkill()),
                    );
                  },
                  child: Text('Go Back',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      color: whitetheme,
                      fontSize: 13,
                    ),),
                ),
              ]),
        ),
      ),
    );
  }
}
