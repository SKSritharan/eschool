import 'package:eschool/data/models/employee.dart';

import '../admin_employee_list_page/widgets/listrectangleone6_item_widget.dart';
import 'controller/admin_employee_list_controller.dart';
import 'models/admin_employee_list_model.dart';
import 'models/listrectangleone6_item_model.dart';
import 'package:eschool/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AdminEmployeeListPage extends StatelessWidget {
  AdminEmployeeListController controller =
      Get.put(AdminEmployeeListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<List<Employee>>(
            stream: controller.employeeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final employees = snapshot.data!;
                return ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
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
                        controller.deleteEmployee(employee.id);
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
                              backgroundImage: NetworkImage(employee.image),
                            ),
                            title: Text(
                              employee.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              employee.phoneNo,
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
