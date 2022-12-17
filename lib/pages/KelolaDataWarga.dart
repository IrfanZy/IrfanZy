import 'package:flutter/material.dart';

class ManageDataWarga extends StatefulWidget {
  const ManageDataWarga({super.key});

  @override
  State<ManageDataWarga> createState() => _ManageDataWargaState();
}

class _ManageDataWargaState extends State<ManageDataWarga> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("MyApps"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: ('C21'),
                ),
                Tab(
                  text: ('C22'),
                ),
                Tab(
                  text: ('C23'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color(0xff3FBDF1),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
