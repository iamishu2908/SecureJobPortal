import 'package:flutter/material.dart';
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
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Result:',
                style: TextStyle(color: neutral, fontSize: 22.0),
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
                    style: const TextStyle(fontSize: 30.0),
                  )),
              const SizedBox(height: 20.0),
              Text(
                result == questionLength / 2
                    ? 'Almost there'
                    : result < questionLength / 2
                        ? 'Better Luck next time!'
                        : 'Great!',
                style: const TextStyle(color: neutral,
                fontSize: 12.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddSkill()),
                  );
                },
                child: Text('Move back to profile page'),
              ),
            ]),
      ),
    );
  }
}
