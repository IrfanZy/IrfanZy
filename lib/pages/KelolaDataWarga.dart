// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:quick_letter_1/widgets/DialogAction.dart';
import 'package:quick_letter_1/widgets/ListDataWargaWidget.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';

class ManageDataWarga extends StatefulWidget {
  const ManageDataWarga({super.key});

  @override
  State<ManageDataWarga> createState() => _ManageDataWargaState();
}

class _ManageDataWargaState extends State<ManageDataWarga> {
  bool visibleDialogPopupData = false;
  String statusDialogPopupData = "add";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            statusDialogPopupData = "add";
            visibleDialogPopupData = true;
          });
        },
        backgroundColor: const Color(0xff3FBDF1),
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 3,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: const TabBar(
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
                      indicatorColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListDataWargaWidget(const ["Dimas Rahmat"], () {
                          setState(() {
                            statusDialogPopupData = "view";
                            visibleDialogPopupData = true;
                          });
                        }),
                        ListDataWargaWidget(const ["Dimas Rahmat"], () {
                          setState(() {
                            statusDialogPopupData = "view";
                            visibleDialogPopupData = true;
                          });
                        }),
                        ListDataWargaWidget(const ["Dimas Rahmat"], () {
                          setState(() {
                            statusDialogPopupData = "view";
                            visibleDialogPopupData = true;
                          });
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          DialogAction(
            context: context,
            isActive: visibleDialogPopupData,
            title: "Tambah Data Warga",
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
                  hint: "No. KK",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controller,
                  hint: "NIK",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controller,
                  hint: "Jenis Kelamin",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controller,
                  hint: "Agama ",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controller,
                  hint: "Tempat Tanggal Lahir",
                ),
                const SizedBox(height: 20),
                statusDialogPopupData == "add"
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          minimumSize: const Size(80, 45),
                          backgroundColor: const Color(0xff3FBDF1),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Save"),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              minimumSize: const Size(80, 45),
                              backgroundColor: const Color(0xff3FBDF1),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Edit"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              minimumSize: const Size(80, 45),
                              backgroundColor: const Color(0xff3FBDF1),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Save"),
                          )
                        ],
                      ),
              ],
            ),
            closeAction: () {
              setState(() {
                visibleDialogPopupData = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
