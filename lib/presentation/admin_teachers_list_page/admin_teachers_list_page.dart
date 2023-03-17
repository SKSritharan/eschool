import 'dart:io';

import 'package:eschool/widgets/custom_imagepicker.dart';

import '../../data/models/teacher.dart';
import '../admin_teachers_list_page/widgets/listrectangleone4_item_widget.dart';
import 'controller/admin_teachers_list_controller.dart';
import 'models/admin_teachers_list_model.dart';
import 'models/listrectangleone4_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

class AdminTeachersListPage extends StatelessWidget {
  final AdminTeachersListController controller =
      Get.put(AdminTeachersListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<List<Teacher>>(
            stream: controller.teachersStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final teachers = snapshot.data!;
                return ListView.builder(
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];
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
                          controller.deleteTeacher(teacher.id);
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
                                backgroundImage: NetworkImage(teacher.image),
                              ),
                              title: Text(
                                teacher.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                teacher.subject,
                                textAlign: TextAlign.left,
                              ),
                              onTap: () => _showTeacherModalBottomSheet(
                                  context, teacher.id),
                            ),
                          ),
                        ));
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

  void _showTeacherModalBottomSheet(BuildContext context, userId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Teacher',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CustomImagePicker(
                    size: 50,
                    onImageSelected: (File file) {},
                    currentImage:
                        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80",
                  ),
                  TextFormField(
                    controller: null,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: null,
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: false,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: null,
                    decoration: InputDecoration(labelText: 'Subject'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          );
        });
  }
}
