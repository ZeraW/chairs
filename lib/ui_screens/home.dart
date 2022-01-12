import 'package:chairs/utils/colors.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_service.dart';
import '../provider/add_provider.dart';
import 'chairs_management/add_edit_notes/add_visual_note.dart';
import 'chairs_management/preview/inspection_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: Responsive.isPortrait(context)
            ? new AppBar(
                centerTitle: false,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Inspection',
                ))
            : null,
        body: ChairInspection(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'addChair',
          onPressed: () => _addItem(),
          tooltip: 'Add',
          child: Icon(
            Icons.add,
            color: xColors.white,
          ),
        ),
      ),
    );
  }

  void _addItem() {
    NavigationService.instance
      .navigateToRoute(ChangeNotifierProvider(
          create: (context) => AddVisualNoteProvider(),
          child: AddVisualNoteScreen()));
  }
}

