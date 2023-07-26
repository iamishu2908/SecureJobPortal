import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/previewpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';


Future<Uint8List> makePdf(UserData user) async {

  final pdf = Document();
  pdf.addPage(
      Page(
          margin: const EdgeInsets.all(25),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[Text("${user.name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ), Text("Email: ${user.email}")]),
                  SizedBox(height: 2),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[_UrlText("LinkedIn: xprillion.com", 'xprillion.com'),  Text("Mobile: +91-XXX-XXXX-XXX")]),
                  SizedBox(height: 2),
                  _UrlText("Github: github.com/xprillion", 'github.com/xprillion'),
                  SizedBox(height: 10),
                  Text("EDUCATION", style: TextStyle(fontSize: 14) ),
                  Divider(thickness: 1, height: 2),
                  SizedBox(height: 5),
                  Padding(padding: EdgeInsets.all(0.0),child: ListView.builder(
                      itemBuilder: (context, int index){
                        return Column(children: <Widget>[Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[Text("${user.education_list[index]["institute"]}", style: TextStyle(fontWeight: FontWeight.bold)), Text("Shillong, India")]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[Text("${user.education_list[index]["level"]} - ${user.education_list[index]["field"]}", style: TextStyle(fontStyle: FontStyle.italic)), Text("${user.education_list[index]['start']} - ${user.education_list[index]['end']}")]), SizedBox(height: 10),]);
                      },
                      itemCount: user.education_list.length)),

                  Text("SKILLS SUMMARY", style: TextStyle(fontSize: 14) ),
                  Divider(thickness: 1, height: 2),
                  Row(children: <Widget>[Text("Skills: ", style: TextStyle(fontWeight: FontWeight.bold)),Text("${user.skill}")]),
                  SizedBox(height: 10),
                  Text("EXPERIENCE", style: TextStyle(fontSize: 14) ),
                  Divider(thickness: 1, height: 2),
                  Padding(padding: EdgeInsets.all(0.0),child: ListView.builder(
                      itemBuilder: (context, int index){
                        return Column(children: <Widget>[Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[Text("${user.experience_list[index]["compName"]}", style: TextStyle(fontWeight: FontWeight.bold)), Text("Remote")]), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[Text("${user.experience_list[index]["jobTitle"]}", style: TextStyle(fontStyle: FontStyle.italic)), Text("${user.experience_list[index]["startDate"]} - ${user.experience_list[index]["endDate"]}")]), SizedBox(height: 5),Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text("${user.experience_list[index]['description']}",textAlign: TextAlign.justify)),
                        ]);
                      },
                      itemCount: user.experience_list.length)),

                  SizedBox(height: 10),

                  Text("Honors and Awards", style: TextStyle(fontSize: 14) ),
                  Divider(thickness: 1, height: 2),

                  Expanded(child: ListView.builder(
                      itemBuilder: (context, int index){
                        return Text("${user.achievement_list[index]}");
                      },
                      itemCount: user.achievement_list.length))

                ]
            );
          }
      ));
  return pdf.save();
}
class _UrlText extends StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  Widget build(Context context) {
    return UrlLink(
      destination: url,
      child: Text(text),
    );
  }
}

