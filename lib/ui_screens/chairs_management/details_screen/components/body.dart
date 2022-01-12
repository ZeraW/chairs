import 'package:chairs/navigation_service.dart';
import 'package:chairs/provider/home_provider.dart';
import 'package:chairs/services/database_api.dart';
import 'package:chairs/utils/colors.dart';
import 'package:chairs/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class DetailsImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chair = context.read<HomeProvider>();
    return Image.network(
      '${chair.details.picture}',
      fit: BoxFit.cover,
      height: Responsive.isPortrait(context)
          ? Responsive.width(60, context)
          : Responsive.height(100, context),
      width: Responsive.isPortrait(context)
          ? Responsive.width(100, context)
          : Responsive.dWidth(60, context),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chair = context.read<HomeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Title'),
          subtitle: Text('${chair.details.title}',
              style: const TextStyle(fontSize: 18)),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Chair Code'),
                subtitle: Text('${chair.details.id}',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('Date'),
                subtitle: Text('${chair.getDate()}',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
        ListTile(
          title: const Text('Description'),
          subtitle: Text('${chair.details.description}',
              style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}

class DetailsBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chair = context.watch<HomeProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: xColors.materialColor(xColors.mainColor)),
            onPressed: () async {
              await DatabaseService()
                  .updateChairStatus(
                  docId: chair.details.docId, status: !chair.details.status)
                  .then((value) {
                NavigationService.instance.key.currentState.pop();
              });
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Status : ",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${chair.details.getStatus()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: chair.details.status
                                  ? Colors.red
                                  : Colors.green)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('${chair.getBtnText()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }
}
