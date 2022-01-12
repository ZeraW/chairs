import 'dart:io';

import 'package:chairs/models/db_model.dart';
import 'package:chairs/navigation_service.dart';
import 'package:chairs/services/database_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class EditVisualNoteProvider extends ChangeNotifier {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  ChairModel currentChairNote;
  File image;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  bool status;
  String imageError = 'Please Take a Picture',
      codeError = 'Please enter Chair Code',
      titleError = 'Please enter Title',
      descriptionError = 'Please enter description',
      statusError = 'Please Choose status';

  //init value
  EditVisualNoteProvider(this.currentChairNote){
    titleController.text = currentChairNote.title;
    descriptionController.text = currentChairNote.description;
    codeController.text = currentChairNote.id;
    status = currentChairNote.status;
  }



  //image picker method
  Future<void> takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 60);

    if (imageFile == null) {
      return;
    } else {
      image = File(imageFile.path);
      notifyListeners();
    }
  }

  //validate and request
  void apiRequest() async {
    String title = titleController.text;
    String description = descriptionController.text;
    String code = codeController.text;

    final form = formKey.currentState;
    if (form.validate()) {
      //this part is unneeded but i overprotect xD
      if (code == null || code.isEmpty) {
        form.invalidateField(name: 'Chair Code', errorText: codeError);
      } else if (title == null || title.isEmpty) {
        form.invalidateField(name: 'Title', errorText: titleError);
      } else if (description == null || description.isEmpty) {
        form.invalidateField(name: 'Description', errorText: descriptionError);
      } else if (status == null) {
        form.invalidateField(name: 'status', errorText: statusError);
      } else {
        ChairModel model = ChairModel(
            id: code,
            docId:  this.currentChairNote.docId,
            title: title,
            description: description,
            picture: this.currentChairNote.picture,
            date: DateTime.now(),
            status: status);
         await DatabaseService().updateChairs(updatedChair: model,image: image);
        NavigationService.instance.key.currentState.pop();

      }
    } else {
      print('Form is invalid');
    }
  }

  //update radio btn UI
  void updateStatus(String status) {
    status == 'Open' ? this.status = true : this.status = false;
    notifyListeners();
  }
}
