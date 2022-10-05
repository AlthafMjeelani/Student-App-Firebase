import 'dart:developer';
import 'package:firebaseaut/screens/adduser/controller/add_newuser_provider.dart';
import 'package:firebaseaut/screens/dashboard/controller/dashboeard_provider.dart';
import 'package:firebaseaut/screens/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDashBoard extends StatelessWidget {
  const ScreenDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashBoardProvider>(context, listen: false);
    final newUser = Provider.of<AddNewUserProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      dash.getData();
      await newUser.getAllStudents(context);
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dash.navigationToAdd(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                log("nav to dash called");
                dash.navigationToProfile(context);
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 42,
              )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Consumer<AddNewUserProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (value.studentList.isEmpty) {
              return const Center(
                child: Text("No students"),
              );
            }
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: value.studentList.length,
              itemBuilder: (context, index) {
                final student = value.studentList[index];
                return ListTile(
                  onTap: () {
                    newUser.navigationToEdit(context, student);
                  },
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/111-1114675_user-login-person-man-enter-person-login-icon.png'),
                  ),
                  title: Text(student.name.toString()),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          },
        ),
      ),
    );
  }
}
