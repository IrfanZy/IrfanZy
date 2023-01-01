import 'package:flutter/material.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
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
              const SizedBox(
                width: 30,
                height: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 20,
                      color: Colors.white,
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
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
