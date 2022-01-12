import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          title: const Text(
            'Note Details',
          )),
      body: Responsive.isPortrait(context)
          ?
      //portrait mode
      Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DetailsImage(),
                DetailsInfo(),
              ],
            ),
          ),
          DetailsBtn()
        ],
      ) :
      //landscape mode
      Row(
        children: [
          Expanded(flex: 2, child: DetailsImage()),
          Expanded(
              flex: 3,
              child: ListView(
                children: [DetailsInfo(), DetailsBtn()],
              ))
        ],
      ),
    );
  }
}
