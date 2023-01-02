import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/services/Constant.dart';
import 'package:quick_letter_1/services/Firestore.dart';

class CardDataPengurus extends StatelessWidget {
  final UserPengurus userPengurus;

  const CardDataPengurus(this.userPengurus, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10000),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.zero,
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: getNetworkImage(
                    url: userPengurus.photoUrl,
                    progressIndicatorSize: 20,
                    emptyWidget: const Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userPengurus.name} (${userPengurus.position})",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "PIN : ${userPengurus.pin}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              IconButton(
                splashRadius: 40,
                onPressed: () =>
                    FirestoreService().deleteUserPengurus(id: userPengurus.id),
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Color.fromARGB(255, 250, 73, 73),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
