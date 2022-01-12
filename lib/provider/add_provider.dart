import 'dart:io';
import 'package:chairs/models/db_model.dart';
import 'package:chairs/navigation_service.dart';
import 'package:chairs/services/database_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

class AddVisualNoteProvider extends ChangeNotifier {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  File image;
  ChairModel currentChairNote;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  bool status;
  String imageError = 'Please Take a Picture',
      codeError = 'Please enter Chair Code',
      titleError = 'Please enter Title',
      descriptionError = 'Please enter description',
      statusError = 'Please Choose status';

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
      if (image == null) {
        form.invalidateField(name: 'image', errorText: imageError);
      } else if (code == null || code.isEmpty) {
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
            title: title,
            description: description,
            date: DateTime.now(),
            status: status);
         await DatabaseService().addChairs(newChair: model,image: image);
         NavigationService.instance.key.currentState.pop();
      }
    } else {
      print('Form is invalid');
    }
  }

  //init value
  void updateStatus(String status) {
    status == 'Open' ? this.status = true : this.status = false;
    notifyListeners();
  }
}
