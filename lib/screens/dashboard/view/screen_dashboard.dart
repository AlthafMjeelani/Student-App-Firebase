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
      newUser.getAllUsers();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<DashBoardProvider>(
            builder:
                (BuildContext context, DashBoardProvider value, Widget? child) {
              return value.userModel == null
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.cyan,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(value.userModel?.name ?? "no name"),
                        Text(
                          (value.userModel?.email ?? ""),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Consumer<AddNewUserProvider>(
                          builder: (BuildContext context,
                              AddNewUserProvider value, Widget? child) {
                            return value.detailsModel == null
                                ? const Center(
                                    child: Text('No Data'),
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: const CircleAvatar(
                                          radius: 30,
                                        ),
                                        title: Text(value.detailsModel!.name
                                            .toString()),
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red,
                                        ),
                                        onTap: () {},
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemCount: value.detailsModel!.name!.length,
                                  );
                          },
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
