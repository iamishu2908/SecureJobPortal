import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

class OptionCard extends StatelessWidget {
  const OptionCard(
      {super.key,
      required this.option,
      required this.color});
  final String option;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: whitetheme,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            option,
            textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w300,
                color: color,
                fontSize: 16,
              ),
          ),
        ),
      ),
    );
  }
}
