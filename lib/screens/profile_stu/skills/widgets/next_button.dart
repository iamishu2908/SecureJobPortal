import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.nextQuestion});
  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: secondarytheme, borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Next Question',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
          ),
          ),
        ),
      ),
    );
  }
}
