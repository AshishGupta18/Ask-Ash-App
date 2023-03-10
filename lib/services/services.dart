import 'package:ask_ash/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../widgets/text_widget.dart';

class Services{
  static Future<void> showModalSheet({required BuildContext context}) async {
     await showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                        ),
                      ),
                      backgroundColor: scaffoldBackgroundColor,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Flexible(
                                    child: TextWidget(
                                  label: "Choose Model",
                                  fontSize: 16,
                                ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: ModelsDropDownWidget()),
                              ],
                            ),
                          );
                        });
  }}