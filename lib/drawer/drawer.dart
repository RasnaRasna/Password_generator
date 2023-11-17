import 'package:flutter/material.dart';
import 'package:password_generator/const/const.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 72, 58),
                borderRadius: BorderRadius.circular(20)),
            width: 280,
            height: 100,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              "Dark Mode",
              style: textStyleblack,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text(
              "Share",
              style: textStyleblack,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              "About",
              style: textStyleblack,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text(
              "Privacy pilicy",
              style: textStyleblack,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
