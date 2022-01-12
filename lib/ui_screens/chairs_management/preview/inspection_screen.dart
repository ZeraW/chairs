import 'package:chairs/models/db_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';

class ChairInspection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<ChairModel> mList = Provider.of<List<ChairModel>>(context);

    return mList != null
        ? SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Wrap(
              children: mList
                  .map((item) => Padding(
                //to add padding to last item to prevent the floatingActionButton from hiding the last item buttons
                padding: EdgeInsets.only(
                    bottom: mList.length - 1 ==
                        mList.indexOf(item)
                        ? 40
                        : 0),
                child: ChairNoteCard(chair: item),
              ))
                  .toList()
                  .cast<Widget>(),
            ),
          ],
        ),
      ),
    )
        : SizedBox();
  }


}