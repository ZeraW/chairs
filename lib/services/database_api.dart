import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import '../models/db_model.dart';

class DatabaseService {
  // Chairs collection reference
  final CollectionReference chairCollection =
      FirebaseFirestore.instance.collection('Chairs');

  //upload Image method
  Future uploadImageToStorage({File file, String id}) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('images/$id.png');

    firebase_storage.UploadTask task = ref.putFile(file);

    // We can still optionally use the Future alongside the stream.
    try {
      //update image
      await task;
      String url =
          await FirebaseStorage.instance.ref('images/$id.png').getDownloadURL();

      return url;
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }

  /// --------------------- Chairs --------------------- ///
  //add new Note
  Future addChairs({ChairModel newChair,File image}) async {
    var ref = chairCollection.doc();
    newChair.docId = ref.id;
    await uploadImageToStorage(id: ref.id,file: image).then((value) async {
      newChair.picture = value;
      return await ref.set(newChair.toMap());

    });
  }

  //update existing Note
  Future updateChairs({ChairModel updatedChair,File image}) async {
        if(image!=null){
          await uploadImageToStorage(id: updatedChair.docId,file: image).then((value) async {
            updatedChair.picture = value;
            return await chairCollection
                .doc(updatedChair.docId.toString())
                .update(updatedChair.toMap());

          });
        }else {
          return await chairCollection
              .doc(updatedChair.docId.toString())
              .update(updatedChair.toMap());
        }

  }


  //update existing Note
  Future updateChairStatus({String docId,bool status}) async {
    return await chairCollection
        .doc(docId)
        .update({'status':status});
  }

  //delete existing Note
  Future deleteChairs({ChairModel deleteChair}) async {
    return await chairCollection.doc(deleteChair.docId.toString()).delete();
  }

  // stream for live Note
  Stream<List<ChairModel>> get getLiveChairs {
    return chairCollection
        .orderBy('date')
        .snapshots()
        .map(ChairModel().fromQuery);
  }

  /// --------------------- Chairs --------------------- ///
}
