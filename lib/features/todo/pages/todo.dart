import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: const [
          Card(
            child: SizedBox(
              width: 300,
              height: 50,
              child: Center(child: Text('Task 1')),
            ),
          ),
          Card(
            child: SizedBox(
              width: 300,
              height: 50,
              child: Center(child: Text('Task 2')),
            ),
          ),
          Card(
            child: SizedBox(
              width: 300,
              height: 50,
              child: Center(child: Text('Task 3')),
            ),
          )
        ],
      )),
    );
  }
}
