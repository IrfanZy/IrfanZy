// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/feature_model.dart';
import 'package:quick_letter_1/services/firestore.dart';

class HomeBerandaFragment extends StatefulWidget {
  final String illustrationPath, title, description;
  final List<FeatureModel> features;

  const HomeBerandaFragment({
    super.key,
    required this.illustrationPath,
    required this.title,
    required this.description,
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
          const SizedBox(height: 20),
          Column(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
                        color: const Color(0xff3FBDF1),
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
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                feature.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
