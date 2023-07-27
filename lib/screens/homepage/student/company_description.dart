import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_utils.dart';

class CompanyDescriptionScreen extends StatefulWidget {
  final String id;
  CompanyDescriptionScreen({super.key, required this.id});

  @override
  _CompanyDescriptionScreenState createState() => _CompanyDescriptionScreenState();
}

class _CompanyDescriptionScreenState extends State<CompanyDescriptionScreen> {
  final ref = FirebaseFirestore.instance.collection("Users");
  final CollectionReference ref2 = FirebaseFirestore.instance.collection("Feedback");
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(iconColor: primarytheme),
                child: Icon(
                  Icons.arrow_back,
                  size: 23,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 65,
                  decoration: BoxDecoration(
                    //border: Border.all(width: 1.5, color: primarytheme),
                    color: whitetheme,
                    shape: BoxShape.circle,
                  ),
                  child: Image(image: AssetImage('assets/images/apple.png'),)
              ),

            ),

          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wavy.jpg'),
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.35), BlendMode.modulate),
                  fit: BoxFit.fill
              ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),

        backgroundColor: secondarytheme,
        elevation: 1,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white24
        ),
        child: FutureBuilder(
          future: ref.doc(widget.id).get(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else {
              var data = snapshot.data!.data();
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      22, MediaQuery
                      .of(context)
                      .size
                      .height * 0.04, 22, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(data!['company_name'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Expanded(child: OutlinedButton(onPressed: () {
                              Navigator.pop(context);
                            },
                              child: Text("Description"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primarytheme,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: primarytheme, width: 1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                            )
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: FilledButton(
                              onPressed: () {
                              }, child: Text("Company"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: primarytheme,
                                side: BorderSide(color: primarytheme, width: 1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                            )
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //reusableTextContainer("Job Description", MediaQuery.of(context).size.width),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "About Company",
                          style: TextStyle(color: primarytheme,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          data['about_company'].toString(),
                          style: TextStyle(color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w200
                          ),
                          textAlign: TextAlign.left,
                          maxLines: readMore ? 20 : 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                readMore = !readMore;
                              });
                            },
                            child: Text(readMore ? "Read less" : "Read more",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: primarytheme,
                              backgroundColor: secondarytheme,
                              //side: BorderSide(color: primarytheme, width: 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Website",
                          style: TextStyle(color: primarytheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 27,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              data['website'].toString(),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "LinkedIn",
                          style: TextStyle(color: primarytheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 27,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              data['linkedin'].toString(),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Industry",
                          style: TextStyle(color: primarytheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 27,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              data['industry_type'].toString(),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Type",
                          style: TextStyle(color: primarytheme,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        //height: 27,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                              data['company_type'].toString(),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 27,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Feedback",
                          style: TextStyle(color: primarytheme,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      Container(
                          child: StreamBuilder<QuerySnapshot>(
                                    stream: ref2.where('company',
                                        isEqualTo: data!['company_name'].toString()) // Replace 'field_name' with the actual field name you want to filter on
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Error: ${snapshot.error}'),
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      // Convert QuerySnapshot to a list of DocumentSnapshots
                                      final List<DocumentSnapshot> documents = snapshot
                                          .data!.docs;

                                      if (documents.isEmpty) {
                                        return Center(
                                          child: Text('No Feedback.'),
                                        );
                                      }
                                      return
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                                          child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: documents.length,
                                              itemBuilder: (_, index) {
                                                //bool expanded = false;
                                                final Map<String,
                                                    dynamic> data = documents[index]
                                                    .data() as Map<String, dynamic>;
                                                return Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                                  child: Align(
                                                      child: SingleChildScrollView(
                                                        child: Column(children: <Widget>[
                                                          Container(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .width,
                                                                  //height: 27,
                                                                  alignment: Alignment.topLeft,
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        data['feedback'],
                                                                        style: TextStyle(color: Colors.black,
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w200
                                                                        ),
                                                                        textAlign: TextAlign.left,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 8,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                      )),
                                                );
                                              }),
                                        );
                                    }
                                )
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        ),
      ),
    );
  }

}