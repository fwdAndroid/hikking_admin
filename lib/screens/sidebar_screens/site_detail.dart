import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hikking_admin/widgets/side_bar.dart';

class SiteDetail extends StatefulWidget {
  String description;
  String elevation;
  String photo;
  String time;
  String name;
  String location;
  String date;
  String distance;
  String uuid;
  SiteDetail(
      {super.key,
      required this.description,
      required this.elevation,
      required this.date,
      required this.photo,
      required this.time,
      required this.uuid,
      required this.distance,
      required this.location,
      required this.name});

  @override
  State<SiteDetail> createState() => _SiteDetailState();
}

class _SiteDetailState extends State<SiteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2a2a2a),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 135,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SideDrawer()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "assets/logo.png",
                            height: 67,
                            width: 121,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.1,
                              0.4,
                              0.6,
                              0.9,
                            ],
                            colors: [
                              Color(0xff2A2A2A00),
                              Color(0xff2A2A2AE6),
                              Color(0xff2A2A2A),
                              Color(0xff2A2A2A),
                            ],
                          )),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('events')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator(); // Show loading indicator while fetching data
                            }

                            final documents = snapshot.data!.docs;

                            return CarouselSlider.builder(
                              itemCount: documents.length,
                              itemBuilder: (context, index, realIndex) {
                                final imageUrl = documents[index]['eventPhoto'];
                                return Image.network(imageUrl,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    width: 1000);
                              },
                              options: CarouselOptions(
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                autoPlay: true,
                              ),
                            );
                          },
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                widget.name,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 196,
                    width: 711,
                    child: Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white.withOpacity(.8),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Color(0xffffff00),
                              size: 15,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(widget.location,
                                style: GoogleFonts.poppins(
                                    color: Color(0xffA0A0A0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Color(0xffffff00),
                                size: 15,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(widget.date,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffA0A0A0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/lc.png"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Distance",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Color(0xffA0A0A0),
                                        ),
                                      ),
                                      Text(
                                        widget.distance,
                                        style: TextStyle(
                                          color: Color(0xffffff00),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/lp.png"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Elevation",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Color(0xffA0A0A0),
                                        ),
                                      ),
                                      Text(
                                        widget.elevation,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xffffff00),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/lg.png"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Time",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Color(0xffA0A0A0),
                                        ),
                                      ),
                                      Text(
                                        widget.time,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xffffff00),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(1000, 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        backgroundColor: Color(0xffffff00)),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("events")
                          .doc(widget.uuid)
                          .delete();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Delete Page",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xffaca7a7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Other Events By the same organizer:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    height: 220,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("events")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                var data = snapshot.data!.docs[index];

                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (builder) => SiteDetail(
                                    //               name: data['eventName'],
                                    //               date: data['eventDate'],
                                    //               description:
                                    //                   data['eventDescription'],
                                    //               elevation:
                                    //                   data['eventElevation'],
                                    //               photo: data['eventPhoto'],
                                    //               time: data['eventTime'],
                                    //               distance:
                                    //                   data['eventDistance'],
                                    //               location:
                                    //                   data['eventLocation'],
                                    //             )));
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Container(
                                        height: 200,
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (builder) =>
                                                //             SiteDetail(
                                                //               name: data[
                                                //                   'eventName'],
                                                //               date: data[
                                                //                   'eventDate'],
                                                //               description: data[
                                                //                   'eventDescription'],
                                                //               elevation: data[
                                                //                   'eventElevation'],
                                                //               photo: data[
                                                //                   'eventPhoto'],
                                                //               time: data[
                                                //                   'eventTime'],
                                                //               distance: data[
                                                //                   'eventDistance'],
                                                //               location: data[
                                                //                   'eventLocation'],
                                                //             )));
                                              },
                                              child: Card(
                                                child: Image.network(
                                                  data['eventPhoto'].toString(),
                                                  width: 150,
                                                  height: 200,
                                                  fit: BoxFit.fill,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 80,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffff00),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                width: 60,
                                                height: 30,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        data['eventDistance'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        "KM",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    data['eventName'],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, bottom: 25),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      color: Color(0xffffff00),
                                                      size: 12,
                                                    ),
                                                    Text(
                                                      data['eventLocation'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }));
                        }),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: 84,
                width: 714,
                child: Center(
                    child: Text(
                  "CopyRight: 2023 - Hikking App",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
