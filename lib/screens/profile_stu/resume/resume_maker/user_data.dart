
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
class UserData{
  String achievement = "";
  String name = "";
  String email = "";
  String github = "";
  String linkedin = "";
  String mobile = "";

  String skill = "";
  List<String> achievement_list = [];
  List<Map> experience_list = [];
  List<Map> education_list = [];

  final String? userId;

  UserData({required this.userId});
  void getUserDataResume() async {
  try {
    final common = await firestore.collection("Users").doc(userId).get();
    final data = common.data();
    email = data!['email'];
    name = data!['name'];
    linkedin = data!['linkedin'];
    github = data!['github'];
    mobile = data!['phone'];

    final ref_ac = firestore.collection("Users").doc(userId).collection('achievement');
    final userSnapshotsAc = ref_ac.snapshots();
    await for (final snapshot in userSnapshotsAc){
      int count1 = snapshot.docs.length;
      for(int i = 0; i < count1; i++) {
        achievement = snapshot.docs[i].data()!['description'];
        achievement_list.add(achievement);
      }
      break;
    }

    final ref_skill = firestore.collection("Users").doc(userId).collection('skills');
    final userSnapshotsSkill = ref_skill.snapshots();
    await for (final snapshot in userSnapshotsSkill){
      int count4 = snapshot.docs.length;
      for(int i = 0; i < count4; i++) {
        skill += " " + snapshot.docs[i].data()['skill'];
      }
      break;
    }

    final ref_ed = firestore.collection("Users").doc(userId).collection('education');
    final userSnapshotsEd = ref_ed.snapshots();
    await for (final snapshot in userSnapshotsEd){
      int count3 = snapshot.docs.length;
      print(count3);
      for(int i = 0; i < count3; i++) {
        var education = {"institute" : "", "field" : "", "start" : "", "end" : "", "level" : "", "location" : ""};

        education["field"] = snapshot.docs[i].data()['field_of_study'];

        education["institute"] = snapshot.docs[i].data()['institute_name'];

        education["start"] = snapshot.docs[i].data()['start_year'];

        education["end"] = snapshot.docs[i].data()['end_year'];

        education["level"] = snapshot.docs[i].data()['level_of_edu'];

        education["location"] = snapshot.docs[i].data()['location'];

        education_list.add(education);
        print(education_list);
      }
      break;
    }

    final ref_exp = firestore.collection("Users").doc(userId).collection('work_exp');
    final userSnapshotsExp = ref_exp.snapshots();
    await for (final snapshot in userSnapshotsExp){
      int count2 = snapshot.docs.length;
      print("count $count2");
      for(int i = 0; i <= count2; i++) {
        print("i $i");
        var experience = {"description" : "", "compName" : "", "startDate" : "", "endDate" : "", "jobTitle" : "", "location": ""};
        experience["description"] = snapshot.docs[i].data()['description'];
        experience["compName"] = snapshot.docs[i].data()['com_name'];
        experience["startDate"] = snapshot.docs[i].data()['start_year'];
        experience["endDate"] = snapshot.docs[i].data()['end_year'];
        experience["jobTitle"] = snapshot.docs[i].data()['job_title'];
        experience["location"] = snapshot.docs[i].data()['location'];
        experience_list.add(experience);
        print(experience_list);

      }
      break;
    }

  } catch (error) {
    print('Error retrieving user data: $error');
  }
}
}
