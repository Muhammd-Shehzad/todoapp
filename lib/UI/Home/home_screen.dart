import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';
import 'package:todoapp/UI/Home/edit_screen.dart';
import 'package:todoapp/UI/SignUp/sign_up.dart';
import 'package:todoapp/Utils/toast_poppup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isdataLoaded = false;

  DatabaseReference db = FirebaseDatabase.instance.ref('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIST OF TODO',
          style: TextStyle(
              color: Colors.pink, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEBEE), // Light pastel pink
              Color(0xFFF8BBD0), // Medium pink tone
              Color(0xFFF48FB1), // Slightly darker pink
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(
            //   child: FirebaseAnimatedList(
            //       query: db,
            //       itemBuilder: (context, snapshot, _, Index) {
            //         return ListTile(
            //           title: Text(snapshot.child('title').value.toString()),
            //           subtitle:
            //               Text(snapshot.child('description').value.toString()),
            //           trailing: InkWell(
            //               onTap: () {
            //                 db
            //                     .child(snapshot.child('id').value.toString())
            //                     .remove()
            //                     .then((v) {
            //                   ToastPoppup().toast(
            //                       'Data Deleted', Colors.green, Colors.white);
            //                 }).onError((Error, index) {
            //                   ToastPoppup().toast(
            //                       Error.toString(), Colors.red, Colors.white);
            //                 });
            //               },
            //               child: Icon(Icons.delete)),
            //         );
            //       }),
            // ),

            Expanded(
              child: FirebaseAnimatedList(
                query: db,
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.pinkAccent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.child('title').value.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditScreen(
                                                title: snapshot
                                                    .child('title')
                                                    .value
                                                    .toString(),
                                                description: snapshot
                                                    .child('description')
                                                    .value
                                                    .toString(),
                                                id: snapshot
                                                    .child('id')
                                                    .value
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20.sp),
                                      InkWell(
                                        onTap: () {
                                          // Logic for delete
                                          db
                                              .child(snapshot
                                                  .child('id')
                                                  .value
                                                  .toString())
                                              .remove()
                                              .then((_) {
                                            ToastPoppup().toast('Data Deleted',
                                                Colors.green, Colors.white);
                                          }).onError((error, stackTrace) {
                                            ToastPoppup().toast(
                                                error.toString(),
                                                Colors.red,
                                                Colors.white);
                                          });
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                snapshot.child('description').value.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            CustomButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 600.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFEBEE), // Light pastel pink
                              Color(0xFFF8BBD0), // Medium pink tone
                              Color(0xFFF48FB1), // Slightly darker pink
                            ],
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close)),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  label: Text('title'),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextFormField(
                                controller: desController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  label: Text('description'),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButton(
                              onPressed: () {
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                if (titleController.text.isEmpty &&
                                    desController.text.isEmpty) {
                                  ToastPoppup().toast('Pleas add data',
                                      Colors.green, Colors.white);
                                  setState(() {
                                    isdataLoaded = false;
                                  });
                                  return;
                                } else {
                                  print('this is current time ${id}');

                                  db.child(id).set({
                                    'title': titleController.text.trim(),
                                    'description': desController.text.trim(),
                                    'id': id
                                  }).then((v) {
                                    ToastPoppup().toast('Data Added',
                                        Colors.green, Colors.white);
                                    titleController.clear();
                                    desController.clear();
                                    setState(() {
                                      isdataLoaded = false;
                                    });
                                  }).onError((Error, v) {
                                    ToastPoppup().toast(Error.toString(),
                                        Colors.red, Colors.white);
                                    setState(() {
                                      isdataLoaded = false;
                                    });
                                  });

                                  // db
                                  //     .child('1233')
                                  //     .set({
                                  //       'title': titleController.text,
                                  //       'description': desController.text,
                                  //     })
                                  //     .then((v) {})
                                  //     .onError((Error, v) {
                                  //       print(Error);
                                  //     });
                                }
                              },
                              text: 'ADD TO-DO',
                              height: 50.h,
                              weight: 340.w,
                              color: [
                                Colors.pink.withOpacity(.9),
                                Colors.pinkAccent.withOpacity(.6)
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              text: 'Add Project',
              color: [
                Colors.pink.withOpacity(.9),
                Colors.pinkAccent.withOpacity(.6)
              ],
              height: 50.h,
              weight: 345.w,
            ),
          ],
        ),
      ),
    );
  }
}
