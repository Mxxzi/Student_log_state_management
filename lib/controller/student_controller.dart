import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:newstudentapp/database/studentmodel.dart';
import 'package:newstudentapp/main.dart';

class StudentController extends GetxController {
  Box<Student> allstudentscontroller = Hive.box(hiveboxname);
  int selectedInddex = 0;
  void addnewstudent(String name, String age, String phone, picture) {
    Student details =
        Student(name: name, age: age, phone: phone, imagepath: picture);
    allstudentscontroller.add(details);
    update();
  }
}

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
  }
}
