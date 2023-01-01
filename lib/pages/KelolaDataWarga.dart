import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_letter_1/models/DataWarga.dart';
import 'package:quick_letter_1/services/Firestore.dart';
import 'package:quick_letter_1/widgets/DialogAction.dart';
import 'package:quick_letter_1/widgets/ListDataWarga.dart';
import 'package:quick_letter_1/widgets/TextFieldCustom.dart';

class ManageDataWarga extends StatefulWidget {
  const ManageDataWarga({super.key});

  @override
  State<ManageDataWarga> createState() => _ManageDataWargaState();
}

class _ManageDataWargaState extends State<ManageDataWarga> {
  final tabName = ["C21", "C22", "C23"];

  List<DataWarga> listDataWarga = [];
  bool visibleDialogPopupData = false,
      readOnlyDialog = true,
      isDataProcessRunning = false;
  String statusDialogPopupData = "add";
  int tabSelected = 0;
  DataWarga? dataSelected;

  final FirestoreService firestoreService = FirestoreService();
  final FocusNode focusNode = FocusNode();
  final Map<String, TextEditingController> controllers = {
    "name": TextEditingController(),
    "nkk": TextEditingController(),
    "nik": TextEditingController(),
    "gender": TextEditingController(),
    "religion": TextEditingController(),
    "placeAndDateOfBirth": TextEditingController(),
  };

  void closeDialog() {
    for (TextEditingController controller in controllers.values) {
      controller.clear();
    }

    setState(() {
      visibleDialogPopupData = false;
      dataSelected = null;
      readOnlyDialog = true;
    });
  }

  void validateForm({required Function() whenValid}) {
    if (controllers["nik"]!.text.length < 16) {
      setState(() => isDataProcessRunning = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "NIK yang dimasukkan tidak valid",
          ),
        ),
      );
    } else if (listDataWarga.any((_) => controllers["nik"]!.text == _.nik)) {
      setState(() => isDataProcessRunning = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "NIK yang dimasukkan telah terdaftar pada data lain",
          ),
        ),
      );
    } else {
      whenValid();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      listDataWarga = Provider.of<List<DataWarga>>(context);
    });

    if (dataSelected != null && readOnlyDialog) {
      controllers["name"]!.text = dataSelected!.name;
      controllers["name"]!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers["name"]!.text.length));
      controllers["nkk"]!.text = dataSelected!.nkk;
      controllers["nkk"]!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers["nkk"]!.text.length));
      controllers["nik"]!.text = dataSelected!.nik;
      controllers["nik"]!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers["nik"]!.text.length));
      controllers["gender"]!.text = dataSelected!.gender;
      controllers["gender"]!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers["gender"]!.text.length));
      controllers["religion"]!.text = dataSelected!.religion;
      controllers["religion"]!.selection = TextSelection.fromPosition(
          TextPosition(offset: controllers["religion"]!.text.length));
      controllers["placeAndDateOfBirth"]!.text =
          dataSelected!.placeAndDateOfBirth;
      controllers["placeAndDateOfBirth"]!.selection =
          TextSelection.fromPosition(TextPosition(
              offset: controllers["placeAndDateOfBirth"]!.text.length));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            statusDialogPopupData = "add";
            visibleDialogPopupData = true;
            readOnlyDialog = false;
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
                    child: TabBar(
                      tabs: [
                        Tab(text: tabName[0]),
                        Tab(text: tabName[1]),
                        Tab(text: tabName[2]),
                      ],
                      indicatorColor: Colors.white,
                      onTap: (value) => setState(() => tabSelected = value),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListDataWarga(
                          listDataWarga.where((_) => _.block == "C21").toList(),
                          (DataWarga data) {
                            setState(() {
                              statusDialogPopupData = "view";
                              visibleDialogPopupData = true;
                              dataSelected = data;
                            });
                          },
                        ),
                        ListDataWarga(
                          listDataWarga.where((_) => _.block == "C22").toList(),
                          (DataWarga data) {
                            setState(() {
                              statusDialogPopupData = "view";
                              visibleDialogPopupData = true;
                              dataSelected = data;
                            });
                          },
                        ),
                        ListDataWarga(
                          listDataWarga.where((_) => _.block == "C23").toList(),
                          (DataWarga data) {
                            setState(() {
                              statusDialogPopupData = "view";
                              visibleDialogPopupData = true;
                              dataSelected = data;
                            });
                          },
                        ),
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
            title: statusDialogPopupData == "add"
                ? "Tambah Data Warga"
                : "Detail Data Warga",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFieldCustom(
                  controller: controllers["name"]!,
                  readOnly: readOnlyDialog,
                  focusNode: focusNode,
                  hint: "Nama",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controllers["nkk"]!,
                  readOnly: readOnlyDialog,
                  hint: "No. KK",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controllers["nik"]!,
                  readOnly: readOnlyDialog,
                  hint: "NIK",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controllers["gender"]!,
                  readOnly: readOnlyDialog,
                  hint: "Jenis Kelamin",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controllers["religion"]!,
                  readOnly: readOnlyDialog,
                  hint: "Agama ",
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  controller: controllers["placeAndDateOfBirth"]!,
                  readOnly: readOnlyDialog,
                  hint: "Tempat Tanggal Lahir",
                ),
                const SizedBox(height: 20),
                statusDialogPopupData == "add"
                    ? ElevatedButton(
                        onPressed: () {
                          if (!isDataProcessRunning &&
                              controllers["name"]!.text.isNotEmpty &&
                              controllers["nkk"]!.text.isNotEmpty &&
                              controllers["nik"]!.text.isNotEmpty &&
                              controllers["gender"]!.text.isNotEmpty &&
                              controllers["religion"]!.text.isNotEmpty &&
                              controllers["placeAndDateOfBirth"]!
                                  .text
                                  .isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() => isDataProcessRunning = true);
                            validateForm(
                              whenValid: () {
                                firestoreService.addDataWarga(
                                  data: DataWarga.createNew(
                                    name: controllers["name"]!.text,
                                    block: tabName[tabSelected],
                                    nkk: controllers["nkk"]!.text,
                                    nik: controllers["nik"]!.text,
                                    gender: controllers["gender"]!.text,
                                    religion: controllers["religion"]!.text,
                                    placeAndDateOfBirth:
                                        controllers["placeAndDateOfBirth"]!
                                            .text,
                                  ),
                                  onSuccess: () {
                                    setState(
                                        () => isDataProcessRunning = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Berhasil")));
                                    closeDialog();
                                  },
                                  onError: () {
                                    setState(
                                        () => isDataProcessRunning = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Gagal")));
                                  },
                                );
                              },
                            );
                          }
                        },
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
                            onPressed: readOnlyDialog
                                ? () {
                                    if (!isDataProcessRunning) {
                                      setState(() => readOnlyDialog = false);
                                      focusNode.requestFocus();
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              minimumSize: const Size(80, 45),
                              backgroundColor: const Color(0xff3FBDF1),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Edit"),
                          ),
                          ElevatedButton(
                            onPressed: !readOnlyDialog
                                ? () {
                                    if (!isDataProcessRunning &&
                                        (controllers["name"]!.text !=
                                                dataSelected!.name ||
                                            controllers["nkk"]!.text !=
                                                dataSelected!.nkk ||
                                            controllers["nik"]!.text !=
                                                dataSelected!.nik ||
                                            controllers["gender"]!.text !=
                                                dataSelected!.gender ||
                                            controllers["religion"]!.text !=
                                                dataSelected!.religion ||
                                            controllers["placeAndDateOfBirth"]!
                                                    .text !=
                                                dataSelected!
                                                    .placeAndDateOfBirth)) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(
                                        () => isDataProcessRunning = true,
                                      );
                                      validateForm(
                                        whenValid: () {
                                          firestoreService.updateDataWarga(
                                            id: dataSelected!.id,
                                            data: {
                                              "name": controllers["name"]!.text,
                                              "nkk": controllers["nkk"]!.text,
                                              "nik": controllers["nik"]!.text,
                                              "gender":
                                                  controllers["gender"]!.text,
                                              "religion":
                                                  controllers["religion"]!.text,
                                              "placeAndDateOfBirth": controllers[
                                                      "placeAndDateOfBirth"]!
                                                  .text,
                                            },
                                            onSuccess: () {
                                              setState(
                                                () {
                                                  isDataProcessRunning = false;
                                                },
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content:
                                                          Text("Berhasil")));
                                              closeDialog();
                                            },
                                            onError: () {
                                              setState(() {
                                                isDataProcessRunning = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text("Gagal")));
                                            },
                                          );
                                        },
                                      );
                                    }
                                  }
                                : null,
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
            closeAction: () => !isDataProcessRunning ? closeDialog() : () {},
          ),
        ],
      ),
    );
  }
}
