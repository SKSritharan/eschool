import '../../data/models/student.dart';
import '../employee_dashboard_students_list_screen/widgets/listrectangleone1_item_widget.dart';
import 'controller/employee_dashboard_students_list_controller.dart';

import 'package:eschool/core/app_export.dart';

import 'package:flutter/material.dart';

class EmployeeDashboardStudentsListScreen extends StatelessWidget {
  EmployeeDashboardStudentsListController controller =
      Get.put(EmployeeDashboardStudentsListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<List<Student>>(
            stream: controller.studentsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final students = snapshot.data!;
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Container(
                      padding: EdgeInsets.only(top: 5, bottom: 2),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        shadowColor: Colors.blueGrey.shade700,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(student.image),
                          ),
                          title: Text(
                            student.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            student.phoneNo,
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {},
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching teachers'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
