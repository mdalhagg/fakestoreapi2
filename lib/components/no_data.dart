import 'package:flutter/material.dart';
// import 'package:matajer_app/app_theme.dart';

class NoData extends StatelessWidget {
  final String message;
  final String actionName;
  final Future<void> Function()? action;

  const NoData({
    super.key,
    required this.message,
    this.action,
    this.actionName = "تحديث",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            // image: const DecorationImage(
            //   fit: BoxFit.contain,
            //   image: AssetImage(
            //     "assets/images/leaf.webp",
            //   ),
            // ),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 200.0,
          height: 220.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.0,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      action != null
                          ? TextButton(
                              onPressed: action,
                              child: Text(
                                actionName,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 10.0,
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
