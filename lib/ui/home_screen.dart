import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newstudentapp/controller/student_controller.dart';
import 'package:newstudentapp/database/studentmodel.dart';
import 'package:newstudentapp/ui/student_detail_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  String searchtext = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[100],
          title: Text("Students List",
              style: TextStyle(
                  color: Colors.teal[700], fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            GetBuilder<StudentController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.8,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          searchtext = value;
                          controller.update(["1"]);
                        },
                        decoration: InputDecoration(
                            label: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.teal[700], fontSize: 20),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
              child: Divider(
                thickness: 2,
                color: Colors.teal[700],
              ),
            ),
            Expanded(
              child: GetBuilder<StudentController>(
                id: "1",
                builder: (_controller) {
                  List<Student> results = searchtext.isEmpty
                      ? _controller.allstudentscontroller.values.toList()
                      : _controller.allstudentscontroller.values
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(searchtext.toLowerCase()))
                          .toList();
                  if (results.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "No data available",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      dynamic avatar;
                      if (results[index].imagepath != null) {
                        avatar = base64Decode(results[index].imagepath);
                      }
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 15, right: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.teal[200]
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 83, 192, 159),
                              ],
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => StudentsDetailsPage(results[index]));
                            },
                            title: Text(
                              results[index].name!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            leading: results[index].imagepath == null
                                ? ClipOval(
                                    child: Image.asset(
                                    "assets/images/avatar.png",
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ))
                                : CircleAvatar(
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                            child: Image.memory(
                                          avatar,
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )))),
                            trailing: IconButton(
                                onPressed: () async {
                                  await _controller.allstudentscontroller
                                      .delete(results[index].key);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Deleted Successfully")));
                                  _controller.update(["1"]);
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
