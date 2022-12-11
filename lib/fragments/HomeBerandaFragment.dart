// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/pages/FormSurat.dart';

class HomeBerandaFragment extends StatefulWidget {
  const HomeBerandaFragment({super.key});

  @override
  State<HomeBerandaFragment> createState() => _HomeBerandaFragmentState();
}

class _HomeBerandaFragmentState extends State<HomeBerandaFragment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FormSurat(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.inbox,
                      size: 30,
                    ),
                    SizedBox(width: 20),
                    Text('Cetak Surat'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
