import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_job_portal/Models/FirebaseResponse.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _UserCollection =
    _firestore.collection('UserProfile');

class FirebaseProfile {
  ///add
  static Future<Response> addProfile({
    required String namedb,
    required String aboutdb,
    required String work_experiencedb,
    required String educationdb,
    required String skillsdb,
    required String achievementsdb,
    required String resumedb,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": namedb,
      "about": aboutdb,
      "work_experience": work_experiencedb,
      "edu": educationdb,
      "skills": skillsdb,
      "resume": resumedb,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  ///read
  static Stream<QuerySnapshot> readProfile() {
    CollectionReference notesItemCollection = _UserCollection;
    return notesItemCollection.snapshots();
  }

  ///edit
  static Future<Response> updateProfile({
    required String namedb,
    required String aboutdb,
    required String work_experiencedb,
    required String educationdb,
    required String skillsdb,
    required String achievementsdb,
    required String resumedb,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": namedb,
      "about": aboutdb,
      "work_experience": work_experiencedb,
      "edu": educationdb,
      "skills": skillsdb,
      "achievements": achievementsdb,
      "resume": resumedb,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Profile";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
