import 'package:flutter/material.dart';
import 'package:chairs/models/db_model.dart';

class HomeProvider extends ChangeNotifier {
  ChairModel details;

  void addDetails({ChairModel chair}) {
    this.details = chair;
    notifyListeners();
  }

  String getBtnText(){
    return details.status ? 'Do you want to Close it ?' :  'Do you want to Reopen it ?';
  }


  String getDate(){
    return '${details.date.day}/${details.date.month}/${details.date.year}, ${details.date.hour}:${details.date.minute}';
  }


}
