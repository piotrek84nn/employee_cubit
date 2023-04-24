import 'package:employ_info/extension/string_extensions.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static Widget getProgress({required String txt}) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
            strokeWidth: 5, color: Colors.blueAccent),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(txt),
        ),
      ],
    ));
  }

  static Widget getListItem({
    required final BuildContext context,
    final String? title,
    final String? subtitle,
    GestureTapCallback? callBack,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      minVerticalPadding: 6,
      onTap: callBack,
      title: title != null
          ? Text(
              title!.toTitleCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            )
          : null,
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          : null,
    );
  }
}
