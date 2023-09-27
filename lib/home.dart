import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newstudentapp/controller/student_controller.dart';
import 'package:newstudentapp/ui/add_student.dart';
import 'package:newstudentapp/ui/home_screen.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  List _pages = [HomeScreen(), AddNewStudent()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
      id: "2",
      builder: (_controller) {
        return Scaffold(
          body: _pages[_controller.selectedInddex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.black,
            currentIndex: _controller.selectedInddex,
            onTap: (newIndex) {
              _controller.selectedInddex = newIndex;
              _controller.update(["2"]);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_add), label: "Add"),
            ],
          ),
        );
      },
    );
  }
}
