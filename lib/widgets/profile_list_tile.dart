import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  ProfileListTile({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 15.0),
          Text(
            "$text",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
