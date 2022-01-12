import 'package:flutter/material.dart';

showDeleteDialog({BuildContext context, Function yes}) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  ()=>Navigator.of(context, rootNavigator: true).pop('dialog'),
  );
  Widget continueButton = TextButton(
    child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red),),
    onPressed:  yes,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Item"),
    content: Text("Would you like to continue deleting this item?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}