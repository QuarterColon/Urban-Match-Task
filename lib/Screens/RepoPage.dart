import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:urban_match_task/Services/fetch_services.dart';
import 'package:urban_match_task/Widgets/code_editor.dart';
import 'package:urban_match_task/Widgets/commit_details_tile.dart';
import 'package:urban_match_task/Widgets/repo_tile.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  late FetchServices fetchServices;

  @override
  void initState() {
    fetchServices = FetchServices(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xff121212),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Repos",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchServices.fetchRepos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RepoTile(repoDetail: data[index]),
                          FutureBuilder(
                              future: fetchServices.fetchCommits(data[index]["full_name"]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data![0];

                                  return Column(
                                    children: [
                                      CommitDetails(
                                        data: data,
                                        commitCount: snapshot.data![1].toString(),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 20),
                                      //   child: ListTile(
                                      //     leading: Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.center,
                                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //
                                      //         Container(
                                      //           height: 16,
                                      //           width: 1,
                                      //           color: Colors.white,
                                      //         ),
                                      //         FaIcon(
                                      //           FontAwesomeIcons.codeCommit,
                                      //           color: Colors.white,
                                      //           size: 18,
                                      //         ),
                                      //         SizedBox(
                                      //           height: 4,
                                      //         ),
                                      //         Text(
                                      //           data["sha"].toString().substring(0, 7),
                                      //           style: TextStyle(
                                      //             color: Colors.white,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     title: Text(
                                      //       data["commit"]["message"],
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //     subtitle: Row(
                                      //       children: [
                                      //         Padding(
                                      //           padding: const EdgeInsets.all(8.0),
                                      //           child: CircleAvatar(
                                      //             backgroundColor: Colors.white,
                                      //             child: ClipOval(
                                      //               child: (data["author"] != null)
                                      //                   ? Image.network(
                                      //                       data["author"]["avatar_url"],
                                      //                       errorBuilder: (context, error, stackTrace) {
                                      //                         return Icon(Icons.person);
                                      //                       },
                                      //                     )
                                      //                   : Icon(
                                      //                       Icons.person,
                                      //                       color: Colors.grey,
                                      //                     ),
                                      //             ),
                                      //             radius: 12,
                                      //           ),
                                      //         ),
                                      //         Text(
                                      //           data["commit"]["author"]["name"],
                                      //           style: TextStyle(
                                      //             color: Colors.white,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     trailing: Container(
                                      //       width: 40,
                                      //       child: Row(
                                      //         children: [
                                      //           Icon(
                                      //             FontAwesomeIcons.clockRotateLeft,
                                      //             color: Colors.white,
                                      //             size: 20,
                                      //           ),
                                      //           SizedBox(
                                      //             width: 4,
                                      //           ),
                                      //           Text(
                                      //             snapshot.data![1].toString(),
                                      //             style: TextStyle(
                                      //               color: Colors.white,
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      FutureBuilder(
                                          future: fetchServices.fetchCodeChanges(data["url"]),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var data = snapshot.data!;
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data.length,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    return CodeView(data: data[index]);
                                                  });
                                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(snapshot.error.toString());
                                            } else {
                                              return const Text("Something went wrong");
                                            }
                                          }),
                                    ],
                                  );
                                } else if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  return const Text("Something went wrong!");
                                }
                              }),
                        ],
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Text("Something went wrong!");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
