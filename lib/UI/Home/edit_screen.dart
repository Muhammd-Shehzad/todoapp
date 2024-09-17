import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Page',
          style: TextStyle(
              color: Colors.pink, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Edit Now',
            style: TextStyle(
                color: Colors.pink,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: editTitleController,
              decoration: InputDecoration(
                label: Text('Title'),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)),
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
              controller: editDescController,
              maxLines: 5,
              decoration: InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomButton(
            onPressed: () {},
            text: 'Save',
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
  }
}
