import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_x/random_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map config = {};

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);
    setState(() => config = data);
    debugPrint(config.toString());
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //// Tabs
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i == 0 ? 10 : 0),
                      child: Container(
                        height: 40,
                        width: 225,
                        decoration: BoxDecoration(
                            // color: Theme.of(context).colorScheme.primary,
                            color: i == 0 ? Theme.of(context).highlightColor : Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              i == 0 ? "Home" : "Folder $i",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            i == 0 ? const Icon(Icons.cancel_rounded) : SizedBox()
                          ]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            //// Bar
            Container(
              height: 50,
              // color: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).highlightColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(Icons.chevron_left_rounded)),
                    IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(Icons.chevron_right_rounded)),
                    IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(Icons.refresh_rounded)),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  //// Left Menu
                  Container(
                      width: config['sidebarSize'],
                      color: Theme.of(context).cardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    for (int i = 0; i < 30; i++)
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 3,
                                            color: i == 0 ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            child: Icon(Icons.home),
                                          ),
                                          Text(
                                            "Home",
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            // thickness: 2,
                            height: 2,
                            // color: Colors.white70,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 3,
                                  color: Colors.transparent,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Icon(Icons.settings),
                                ),
                                Text(
                                  "Settings",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  // const VerticalDivider(
                  //   thickness: 2,
                  //   width: 2,
                  //   color: Colors.grey,
                  // ),
                  //// Body
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Expanded(
                              child: Row(children: [
                                InkWell(
                                  onTap: () {},
                                  child: Tooltip(
                                    message: "New",
                                    child: Center(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.add_circle_outline_rounded),
                                          SizedBox(width: 10),
                                          Text("New"),
                                          SizedBox(width: 5),
                                          Icon(Icons.arrow_drop_down_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: () {}, tooltip: "Copy", icon: const Icon(Icons.copy_rounded)),
                                IconButton(onPressed: () {}, tooltip: "Cut", icon: const Icon(Icons.cut_rounded)),
                                IconButton(onPressed: () {}, tooltip: "Paste", icon: const Icon(Icons.paste_rounded)),
                                IconButton(onPressed: () {}, tooltip: "Properties", icon: const Icon(Icons.topic_outlined)),
                                IconButton(onPressed: () {}, tooltip: "Share", icon: const Icon(Icons.share_rounded)),
                                IconButton(onPressed: () {}, tooltip: "Delete", icon: const Icon(Icons.delete)),
                                IconButton(onPressed: () {}, tooltip: "More", icon: const Icon(Icons.window_rounded))
                              ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(child: Text("File Name")),
                                  SizedBox(width: 150, child: Text("Date Created")),
                                  SizedBox(width: 150, child: Text("Type")),
                                  SizedBox(width: 150, child: Text("Size"))
                                ]),
                                Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        for (int i = 0; i < 100; i++)
                                          Row(children: [
                                            Expanded(child: Text("Folder Number ${i + 1}")),
                                            SizedBox(
                                                width: 150,
                                                child: Text(
                                                  DateFormat('MMMM dd, yyyy').format(
                                                      RndX.generateRandomDateBetween(start: DateTime(2010), end: DateTime(2022))),
                                                )),
                                            SizedBox(width: 150, child: Text("Folder")),
                                            SizedBox(width: 150, child: Text("${(i + 1) * 2} MB"))
                                          ]),
                                        const Text("end data")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          // thickness: 2,
                          height: 2,
                          // color: Colors.white70,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 3,
                                color: Colors.transparent,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Icon(Icons.settings),
                              ),
                              Text(
                                "Settings",
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
