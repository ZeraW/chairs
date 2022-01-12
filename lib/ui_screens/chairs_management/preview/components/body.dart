import 'package:chairs/navigation_service.dart';
import 'package:chairs/services/database_api.dart';
import 'package:chairs/ui_components/dialogs.dart';
import 'package:chairs/provider/edit_provider.dart';
import 'package:chairs/ui_screens/chairs_management/add_edit_notes/edit_visual_note.dart';
import 'package:flutter/material.dart';
import 'package:chairs/models/db_model.dart';
import 'package:chairs/provider/home_provider.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ChairNoteCard extends StatelessWidget {
  final ChairModel chair;

  ChairNoteCard({this.chair});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeProvider>().addDetails(chair: chair);
        NavigationService.instance.key.currentState.pushNamed(
          'DetailsScreen',
        );
      },
      child: SizedBox.fromSize(
        size: Size(
          Responsive.isPortrait(context)
              ? Responsive.width(95, context)
              : Responsive.height(84, context),
          Responsive.dWidth(30, context),
        ),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Row(
              children: [
                SizedBox(
                  width: Responsive.dWidth(1.5, context),
                ),
                Image.network(
                  '${chair.picture}',
                  fit: BoxFit.cover,
                  width: Responsive.dWidth(25, context),
                  height: Responsive.dWidth(25, context),
                ),
                SizedBox(
                  width: Responsive.dWidth(2, context),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${chair.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${chair.id}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text('${chair.getStatus()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: chair.status ? Colors.red : Colors.green)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: () {
                      NavigationService.instance
                          .navigateToRoute(ChangeNotifierProvider(
                          create: (context) => EditVisualNoteProvider(chair),
                          child: EditVisualNoteScreen()));
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.green,
                      size: Responsive.dWidth(6, context),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: () {
                      showDeleteDialog(
                          context: context,
                          yes: () async {
                            await DatabaseService()
                                .deleteChairs(deleteChair: chair);
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: Responsive.dWidth(6, context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
