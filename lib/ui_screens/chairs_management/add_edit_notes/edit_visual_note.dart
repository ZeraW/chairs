import 'dart:io';

import 'package:chairs/ui_components/textfield_widget.dart';
import 'package:chairs/utils/colors.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import '../../../provider/edit_provider.dart';

class EditVisualNoteScreen extends StatefulWidget {
  @override
  _EditVisualNoteScreenState createState() => _EditVisualNoteScreenState();
}

class _EditVisualNoteScreenState extends State<EditVisualNoteScreen> {

  @override
  Widget build(BuildContext context) {
    var provider = context.read<EditVisualNoteProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageForEditScreen(provider),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  ChairCodeWidget(provider),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  TitleWidget(provider),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  DescriptionWidget(provider),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  StatusWidget(provider,init: provider.currentChairNote.getStatus(),),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  SubmitBtnWidget(
                    provider,
                    text: 'Edit Note',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
