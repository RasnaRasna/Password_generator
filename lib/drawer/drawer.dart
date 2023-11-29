import 'package:flutter/material.dart';
import 'package:password_generator/const/const.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: Center(
              child: Text(
                "Secure Passwords",
                style: textStylee,
              ),
            ),
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "  Developed by Rasna",
                            style: textStyleblack,
                          ),
                        ),
                        title: const Text(
                          'Secure Passwords',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text(
              "Privacy pilicy",
              style: textStyleblack,
            ),
            onTap: () {
              _launchPrivacyPolicyURL();
            },
          )
        ],
      ),
    );
  }

  _launchPrivacyPolicyURL() async {
    const url =
        'https://docs.google.com/document/d/1ubbnOiFpEWbhGPq84o7ooqRUEWfInXA6jNlCulKaE-8/edit';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
