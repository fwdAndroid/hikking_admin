import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikking_admin/services/storage.dart';
import 'package:hikking_admin/utils/controllers.dart';
import 'package:hikking_admin/utils/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  Uint8List? _eventPhoto;
  bool _isLoading = false;
  var uuid = Uuid().v1();
  bool _imageSelected = false;
  @override
  void initState() {
    eventtimeController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? _image;

    return Scaffold(
      backgroundColor: Color(0xffa0a0a0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 180,
        toolbarHeight: 120,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/logo.png",
            height: 67,
            width: 121,
          ),
        ),
        title: Text(
          "Admin Page",
          style: TextStyle(
              color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 700,
                  width: 375,
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Event List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        leading: Column(
                          children: [
                            Text(
                              "11",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "July",
                              style: TextStyle(
                                  color: Color(0xffFFFF00), fontSize: 10),
                            )
                          ],
                        ),
                        title: Text(
                          "Snow Hike",
                          style: TextStyle(
                              color: Color(0xffFFFF00),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          "Laklouk, Mount lebanon",
                          style:
                              TextStyle(color: Color(0xffFFFF00), fontSize: 10),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color(0xffFFFF00)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 120, bottom: 20),
                  color: Colors.black,
                  width: 600,
                  height: 800,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Event List",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Title",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: eventNameController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Select Title",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        _imageSelected
                            ? CircleAvatar(
                                radius: 59,
                                backgroundImage: MemoryImage(_eventPhoto!),
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Photo",
                                    style: TextStyle(
                                      color: Color(0xffFFFF00),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(176, 31),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  backgroundColor: Color(0xff02D80A)),
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.black,
                              ),
                              label: Text(
                                "Add Photo",
                                style: TextStyle(
                                    color: Color(0xff343434), fontSize: 10),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: eventDescriptionController,
                              maxLines: 6,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Write a Description",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: eventlocationController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Location",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: 292,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2025),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    eventDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                  }
                                });
                              },
                              controller: eventDateController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Select Date",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Distance:",
                                      style: TextStyle(
                                          color: Color(0xffFFFF00),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  margin: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: eventDistanceController,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "KM",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Elevation:",
                                      style: TextStyle(
                                          color: Color(0xffFFFF00),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  margin: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: eventElevationControler,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "M",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Time:",
                                      style: TextStyle(
                                          color: Color(0xffFFFF00),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  margin: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: eventtimeController,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "hr",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Event Page Link",
                              style: TextStyle(
                                  color: Color(0xffFFFF00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: eventPageController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Event Page Link",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(300, 66),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        backgroundColor: Color(0xff02D80A)),
                                    onPressed: createEvent,
                                    child: _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text(
                                            "Approve/ Publish",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(200, 66),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Go Back",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //Functions
  void selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _eventPhoto = ui;
      _imageSelected = true;
    });
  }

  void createEvent() async {
    String clubPhoto = await StorageMethods()
        .uploadImageToStorage("clubCoverPhoto", _eventPhoto!, true);

    await FirebaseFirestore.instance.collection("events").doc(uuid).set({
      "eventDate": eventDateController.text,
      "eventDescription": eventDescriptionController.text,
      "eventDistance": eventDistanceController.text,
      "eventElevation": eventElevationControler.text,
      "eventLink": eventPageController.text,
      "eventLocation": eventlocationController.text,
      "eventTime": eventtimeController.text,
      "eventPhoto": clubPhoto,
      "eventName": eventNameController.text,
      "uuid": uuid
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Event is added")));

    eventDateController.clear();
    eventDescriptionController.clear();
    eventDateController.clear();
    eventElevationControler.clear();
    eventNameController.clear();
    eventtimeController.clear();
    eventlocationController.clear();
    eventPageController.clear();
  }
}
