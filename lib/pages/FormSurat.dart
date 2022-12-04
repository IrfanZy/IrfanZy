// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_letter_1/services/constants.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';

class FormSurat extends StatefulWidget {
  const FormSurat({super.key});

  @override
  State<FormSurat> createState() => _FormSuratState();
}

class _FormSuratState extends State<FormSurat> {
  final Map<String, TextEditingController> controllers = {
    'nama_lengkap': TextEditingController(),
    'no_ktp': TextEditingController(),
    'jenis_kelamin': TextEditingController(),
    'pekerjaan': TextEditingController(),
    'agama': TextEditingController(),
    'status_nikah': TextEditingController(),
    'status_rumah': TextEditingController(),
    'alamat_blok': TextEditingController(),
    'alamat_blok_no': TextEditingController(),
    'keperluan_input': TextEditingController(),
  };

  void generatePdf() async {
    if (controllers.values.any((element) => element.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Silahkan lengkapi formulir dengan benar'),
      ));
    } else if ((await Permission.storage.request()).isGranted) {
      String resultPdfLetter = templatePdfLetter;

      for (String key in controllers.keys) {
        resultPdfLetter =
            resultPdfLetter.replaceAll('{{$key}}', controllers[key]!.text);
      }

      resultPdfLetter = resultPdfLetter.replaceAll(
        '{{current_time}}',
        DateFormat('d MMMM y').format(DateTime.now()),
      );

      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        await FlutterHtmlToPdf.convertFromHtmlContent(
          resultPdfLetter,
          dir.path,
          "Surat Keterangan",
        ).then((value) =>
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Surat Keterangan berhasil di download'),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage("images/circleatas.png"),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AssetImage("images/circle.png"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['nama_lengkap']!,
                      icon: Icons.person,
                      hint: 'Nama Lengkap',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['no_ktp']!,
                      icon: Icons.numbers,
                      hint: 'No.KTP',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['jenis_kelamin']!,
                      icon: Icons.wc,
                      hint: 'Jenis Kelamin',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['pekerjaan']!,
                      icon: Icons.work,
                      hint: 'Pekerjaan',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['agama']!,
                      icon: Icons.mosque,
                      hint: 'Agama',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['status_nikah']!,
                      icon: Icons.group,
                      hint: 'Status Nikah',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['status_rumah']!,
                      icon: Icons.home,
                      hint: 'Status Rumah',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['alamat_blok']!,
                      icon: Icons.streetview,
                      hint: 'Nama Blok',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['alamat_blok_no']!,
                      icon: Icons.map,
                      hint: 'No. Blok',
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      filled: true,
                      controller: controllers['keperluan_input']!,
                      icon: Icons.description,
                      hint: 'Keperluan',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: generatePdf,
                      child: const Text("Cetak Surat Keterangan"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
