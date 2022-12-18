// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/feature_model.dart';
import 'package:quick_letter_1/services/firestore.dart';

class HomeBerandaFragment extends StatefulWidget {
  final String illustrationPath;
  final List<FeatureModel> features;

  const HomeBerandaFragment({
    super.key,
    required this.illustrationPath,
    required this.features,
  });

  @override
  State<HomeBerandaFragment> createState() => _HomeBerandaFragmentState();
}

class _HomeBerandaFragmentState extends State<HomeBerandaFragment> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Image.asset(widget.illustrationPath),
          ),
          const SizedBox(height: 40),
          Container(
            color: Colors.red,
            height: 100,
          ),
          const SizedBox(height: 40),
          ...widget.features
              .map(
                (feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => feature.directPage,
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(
                                feature.icon,
                                size: 30,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                feature.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
