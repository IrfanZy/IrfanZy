// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/feature_model.dart';
import 'package:quick_letter_1/pages/FormSurat.dart';
import 'package:quick_letter_1/pages/KelolaDataWarga.dart';

class Features {
  static final List<FeatureModel> Warga = [
    FeatureModel(
      title: "Cetak Surat",
      icon: Icons.sticky_note_2,
      directPage: const FormSurat(),
    ),
  ];

  static final List<FeatureModel> Pengurus = [
    FeatureModel(
      title: "Kelola Data",
      icon: Icons.manage_accounts,
      directPage: const ManageDataWarga(),
    ),
  ];
}
