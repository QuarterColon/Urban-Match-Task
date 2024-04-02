import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RepoTile extends StatelessWidget {
  final Map repoDetail;
  const RepoTile({super.key, required this.repoDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff212121),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network("${repoDetail["owner"]["avatar_url"]}"),
          ),
        ),
        title: Text(
          repoDetail["name"],
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(repoDetail["owner"]["login"], style: TextStyle(color: Colors.white)),
        trailing: Container(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
              ),
              FaIcon(
                FontAwesomeIcons.codeFork,
                size: 16,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                repoDetail["forks_count"].toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.disc_full,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                repoDetail["open_issues"].toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
