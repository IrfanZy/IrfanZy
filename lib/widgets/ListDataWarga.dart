import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/DataWarga.dart';
import 'package:quick_letter_1/services/Firestore.dart';

class ListDataWarga extends StatelessWidget {
  final Function(DataWarga data) actionView;
  final List<DataWarga> data;

  const ListDataWarga(
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
            (_) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "NIK : ${_.nik}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Lihat Detail",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Hapus Data",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                        onSelected: (int value) {
                          switch (value) {
                            case 1:
                              actionView(_);
                              break;

                            case 2:
                              FirestoreService().deleteDataWarga(id: _.id);
                              break;

                            default:
                              break;
                          }
                        },
                        child: const Icon(
                          Icons.more_vert,
                          size: 20,
                        ),
                      ),
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
