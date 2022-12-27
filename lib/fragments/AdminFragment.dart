import 'package:flutter/material.dart';
import 'package:quick_letter_1/widgets/DialogAction.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';

class KelolaAdmin extends StatefulWidget {
  const KelolaAdmin({super.key});

  @override
  State<KelolaAdmin> createState() => _KelolaAdminState();
}

class _KelolaAdminState extends State<KelolaAdmin> {
  bool visibleDialogAddData = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(),
            ),
            Positioned(
              bottom: 150,
              right: 50,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    visibleDialogAddData = true;
                  });
                },
                backgroundColor: const Color(0xff3FBDF1),
                child: const Icon(Icons.add),
              ),
            ),
            DialogAction(
              context: context,
              isActive: visibleDialogAddData,
              title: "Tambah Data Pengurus",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldCustom(
                    controller: controller,
                    hint: "Nama",
                  ),
                  const SizedBox(height: 20),
                  TextFieldCustom(
                    controller: controller,
                    hint: "Jabatan",
                  ),
                  const SizedBox(height: 20),
                  TextFieldCustom(
                    controller: controller,
                    hint: "Pin",
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(80, 45),
                      backgroundColor: const Color(0xff3FBDF1),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
              closeAction: () {
                setState(() {
                  visibleDialogAddData = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
