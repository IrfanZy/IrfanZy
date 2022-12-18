// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ListDataWargaWidget extends StatelessWidget {
  final Function() actionView;
  final List<String> data;

  const ListDataWargaWidget(
    this.data,
    this.actionView, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 100,
      ),
      children: data
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: actionView,
                        child: const Text("View"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
