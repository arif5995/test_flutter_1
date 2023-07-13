import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final List<Item> _data = generateItems(20);
    double width = (MediaQuery.of(context).size.width / 3) - 20;
    double hight = width * 1.25;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 50,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 1)),
        title: Transform(
          transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Main Page",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print("Add");
            },
            child: const Text(
              "Add",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
            elevation: 3,
            backgroundColor: Colors.green,
            onPressed: (){},
            child: const Icon(Icons.add, color: Colors.white,)
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width,
                    height: hight,
                    color: Colors.red,
                    child: const Center(
                        child: Text(
                      "C1",
                      style: TextStyle(fontSize: 30),
                    )),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: width,
                    height: hight,
                    color: Colors.yellow,
                    child: const Center(
                        child: Text(
                      "C2",
                      style: TextStyle(fontSize: 30),
                    )),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: width,
                    height: hight,
                    color: Colors.green,
                    child: const Center(
                        child: Text(
                      "C3",
                      style: TextStyle(fontSize: 30),
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              ListView.builder(
                key: Key('builder ${selected.toString()}'),
                shrinkWrap: true,
                // attention
                itemCount: _data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  final child = _data[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: ExpansionTile(
                          key: Key(i.toString()),
                          initiallyExpanded: i == selected,
                          title: Text("Menu $i"),
                          onExpansionChanged: ((newState) {
                            if (newState) {
                              setState(() {
                                selected = i;
                              });
                            } else {
                              setState(() {
                                selected = -1;
                              });
                            }
                          }),
                          children: [
                            Column(
                              children: [
                                const Divider(color: Colors.black),
                                ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Information",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(onPressed: (){
                                            print("Menu $i");
                                          }, child: const Text("Ok"))
                                        ],
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(child.nameValue),
                                        Text(child.addressValue),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _data.removeWhere(
                                            (Item currentItem) => child == currentItem);
                                      });
                                    }),
                              ],
                            ),
                          ]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Item {
  Item({
    required this.nameValue,
    required this.addressValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String nameValue;
  String addressValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        headerValue: 'Menu $index',
        nameValue: 'Name $index',
        addressValue: "Address $index");
  });
}
