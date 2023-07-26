
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
class UserData{
  String achievement = "";
  String name = "";
  String email = "";
  String skill = "";
  List<String> achievement_list = [];
  List<Map> experience_list = [];
  List<Map> education_list = [];

  var education = {"institute" : "", "field" : "", "start" : "", "end" : "", "level" : ""};
  var experience = {"description" : "", "compName" : "", "startDate" : "", "endDate" : "", "jobTitle" : ""};
  final String? userId;

  UserData({required this.userId});
  void getUserDataResume() async {
  try {
    final common = await firestore.collection("Users").doc(userId).get();
    final data = common.data();
    email = data!['email'];
    name = data!['name'];
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
    final ref_exp = firestore.collection("Users").doc(userId).collection('work_exp');
    final userSnapshotsExp = ref_exp.snapshots();
    await for (final snapshot in userSnapshotsExp){
      int count2 = snapshot.docs.length;
      for(int i = 0; i < count2; i++) {
        experience = {"description" : "", "compName" : "", "startDate" : "", "endDate" : "", "jobTitle" : ""};

        experience["description"] = snapshot.docs[0].data()!['description'];
        experience["compName"] = snapshot.docs[0].data()!['com_name'];
        experience["startDate"] = snapshot.docs[0].data()!['start_date'];
        experience["endDate"] = snapshot.docs[0].data()!['end_date'];
        experience["jobTitle"] = snapshot.docs[0].data()!['job_title'];
        experience_list.add(experience);

      }
      break;
    }
    final ref_ed = firestore.collection("Users").doc(userId).collection('education');
    final userSnapshotsEd = ref_ed.snapshots();
    await for (final snapshot in userSnapshotsEd){
      int count3 = snapshot.docs.length;
      for(int i = 0; i < count3; i++) {
        education = {"institute" : "", "field" : "", "start" : "", "end" : "", "level" : ""};

        education["field"] = snapshot.docs[0].data()!['field_of_study'];
        education["institute"] = snapshot.docs[0].data()!['institute_name'];
        education["start"] = snapshot.docs[0].data()!['start_date'];
        education["end"] = snapshot.docs[0].data()!['end_date'];
        education["level"] = snapshot.docs[0].data()!['level_of_edu'];
        education_list.add(education);
      }
      break;
    }
    final ref_skill = firestore.collection("Users").doc(userId).collection('skills');
    final userSnapshotsSkill = ref_skill.snapshots();
    await for (final snapshot in userSnapshotsSkill){
      int count4 = snapshot.docs.length;
      for(int i = 0; i < count4; i++) {
        skill += " " + snapshot.docs[i].data()!['skill'];
      }
      break;
    }

  } catch (error) {
    print('Error retrieving user data: $error');
  }
}
}
