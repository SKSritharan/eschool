import '../../data/models/student.dart';
import '../admin_students_list_page/widgets/listrectangleone5_item_widget.dart';
import 'controller/admin_students_list_controller.dart';
import 'models/admin_students_list_model.dart';
import 'models/listrectangleone5_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminStudentsListPage extends StatelessWidget {
  AdminStudentsListController controller =
      Get.put(AdminStudentsListController());

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
                    return Dismissible(
                      background: Container(
                        alignment: AlignmentDirectional.centerStart,
                        color: Colors.red.shade100,
                        child: Icon(
                          Icons.delete,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) async {
                        controller.deleteStudent(student.id);
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this teacher?"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("DELETE")),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
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
