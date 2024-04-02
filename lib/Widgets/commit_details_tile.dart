import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommitDetails extends StatelessWidget {
  final Map data;
  final String commitCount;
  const CommitDetails({super.key, required this.data, required this.commitCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 16,
              width: 1,
              color: Colors.white,
            ),
            FaIcon(
              FontAwesomeIcons.codeCommit,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              data["sha"].toString().substring(0, 7),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        title: Text(
          data["commit"]["message"],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: (data["author"] != null)
                      ? Image.network(
                    data["author"]["avatar_url"],
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person);
                    },
                  )
                      : Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                radius: 12,
              ),
            ),
            Text(
              data["commit"]["author"]["name"],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 40,
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.clockRotateLeft,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                commitCount,
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
