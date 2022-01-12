import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../provider/add_provider.dart';
import 'components/body.dart';

class AddVisualNoteScreen extends StatefulWidget {
  @override
  _AddVisualNoteScreenState createState() => _AddVisualNoteScreenState();
}

class _AddVisualNoteScreenState extends State<AddVisualNoteScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = context.read<AddVisualNoteProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Note'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageForAddScreen(provider),
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
                  StatusWidget(provider),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  SubmitBtnWidget(
                    provider,
                    text: 'Add Note',
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
