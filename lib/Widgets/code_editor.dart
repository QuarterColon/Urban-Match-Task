import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeView extends StatelessWidget {
  final Map data;
  const CodeView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> lineList = data["patch"].split("\n");
    return Container(
      margin: EdgeInsets.only(left: 50, right: 10, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ExpansionTile(
        backgroundColor: Color(0xff212121),
        collapsedBackgroundColor: Color(0xff212121),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        title: Text(
          data["filename"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "+${data["additions"]}",
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
              Text(
                "-${data["deletions"]}",
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              Text(
                "changes: ${data["additions"]}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xff121212),
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: lineList.length,
              itemBuilder: (context, index) {
                return Text(
                  lineList[index],
                  style: GoogleFonts.getFont(
                    'Courier Prime',
                    backgroundColor: (lineList[index].startsWith('+'))
                        ? Colors.green.withOpacity(0.3)
                        : (lineList[index].startsWith('-'))
                            ? Colors.red.withOpacity(0.3)
                            : Colors.transparent,
                  ),


                );
              },
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
