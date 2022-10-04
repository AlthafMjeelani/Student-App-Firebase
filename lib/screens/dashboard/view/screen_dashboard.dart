import 'dart:developer';
import 'package:firebaseaut/screens/adduser/controller/add_newuser_provider.dart';
import 'package:firebaseaut/screens/dashboard/controller/dashboeard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDashBoard extends StatelessWidget {
  const ScreenDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final newUser = Provider.of<AddNewUserProvider>(context, listen: false);
    final dash = Provider.of<DashBoardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dash.getData();
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
      body: dash.isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                color: Colors.cyan,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: newUser.fetchAllStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.cyan,
                            ),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No students"),
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            final student = snapshot.data![index];
                            return ListTile(
                              leading: const CircleAvatar(
                                radius: 30,
                              ),
                              title: Text(student.name.toString()),
                            );
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
