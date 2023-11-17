import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/const/const.dart';
import 'package:password_generator/drawer/drawer.dart';
import 'package:password_generator/password_generating.dart';
import 'package:password_generator/save_favorite/favorite.dart';
import 'package:password_generator/save_favorite/save.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'check_box.dart';

class MyHomePage extends StatefulWidget {
  final String password;
  const MyHomePage({
    super.key,
    required this.password,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TextEditingController passwordController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Password Generator",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: const Settings(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 155, 155, 155))),
                    child: SizedBox(
                      width: 400,
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 270,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "lib/assets/passwordimage1.jpg"))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              splashColor: Colors.black,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        const PasswordGenerating()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: GreenColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                height: 60,
                                child: const Center(
                                    child: Text(
                                  " Generate Password",
                                  style: textStylee,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const FavoritePassword()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          width: 130,
                          height: 120,
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 11),
                                child: Icon(
                                  Icons.favorite_border_sharp,
                                  size: 40,
                                  color: GreenColor,
                                ),
                              ),
                              Text(
                                " Favorite\nPassword",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: GreenColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SavedPassword(
                                      password: widget.password,
                                    )),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          width: 130,
                          height: 120,
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 11),
                                child: Icon(
                                  Icons.save,
                                  size: 40,
                                  color: GreenColor,
                                ),
                              ),
                              Text(
                                "   Saved\nPassword",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: GreenColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
