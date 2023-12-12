import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget loadingWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      FaIcon(
        FontAwesomeIcons.cloud,
        size: 50,
      ),
      const Padding(padding: EdgeInsets.all(8.0), child: Text("Loading..")),
    ],
  );
}

Widget errorWidget(
    {required BuildContext context, required String errorMessage}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.bolt,
          size: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Error: ${errorMessage.toString()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}
