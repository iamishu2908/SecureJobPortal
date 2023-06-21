import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/home.dart';
import 'package:secure_job_portal/screens/mainpage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

List<String> profilemenu = [
  'About Me',
  'Work Experience',
  'Education',
  'Skills',
  'Achievements',
  'Resume'
];

List<IconData> iconmenu = [
  Icons.person_pin_rounded,
  Icons.work_outline_rounded,
  Icons.school,
  Icons.lightbulb,
  Icons.workspace_premium_outlined,
  Icons.file_present_rounded
];

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.2,
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
                  style: TextButton.styleFrom(iconColor: Colors.white),
                  child: Icon(
                    Icons.arrow_back,
                    size: 23,
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 2),
                  height: 50,
                  child: Image(
                    image: AssetImage('assets/images/profile.png'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, top: 10),
                  child: Text(
                    'Test123',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: whitetheme,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: primarytheme,
          elevation: 5.0,
          actions: [
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 50,
                alignment: Alignment.topRight,
                child: Icon(Icons.share_rounded)),
            Container(
                padding: EdgeInsets.only(left: 20, right: 10, top: 20),
                height: 50,
                alignment: Alignment.topRight,
                child: Icon(Icons.settings)),
          ]),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              // height: SizeConfig.screenHeight,
              height: 5 * 190,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profilemenu.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: qbox(profilemenu.elementAt(index),
                            iconmenu.elementAt(index)));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class qbox extends StatefulWidget {
  // int index;
  // List<ClassFaq> catlist;
  String title;
  IconData icon;
  qbox(this.title, this.icon);

  // qbox(this.catlist, this.index);

  @override
  State<qbox> createState() => _qboxState();
}

class _qboxState extends State<qbox> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () {
            expand = !expand;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.02),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.all(12),
            child: (expand == false)
                ? Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          widget.icon,
                          size: 22.0,
                          color: orangetheme,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.title}',
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.edit,
                          size: 22.0,
                          color: orangetheme,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    widget.icon,
                                    size: 22.0,
                                    color: orangetheme,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${widget.title}',
                                  // overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.edit,
                                    size: 22.0,
                                    color: orangetheme,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'I am a curious person interested in solving real world problems using the latest technologies.I\'m a tech geek!',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            // Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             height: 200,
            //             child: Text(
            //               '1.Question',
            //               textAlign: TextAlign.left,
            //               style: GoogleFonts.dmSans(
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.black,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Divider(
            //             height: 1,
            //             color: pink1,
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Flexible(
            //             child: Text(
            //               'Answer 1',
            //               textAlign: TextAlign.left,
            //               style: GoogleFonts.dmSans(
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.black,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Center(
            //             child: Text(
            //               "^ Click to minimize ^",
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.dmSans(
            //                 fontWeight: FontWeight.w200,
            //                 color: Colors.black,
            //                 fontSize: 11,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
          ),
        ),
      ),
    );
  }
}
