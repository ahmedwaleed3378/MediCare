import 'package:flutter/material.dart';

import '../size_config.dart';
import '../theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Container(
          height: 52,
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.only(left: 14),
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(color: Colors.grey)
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    style: subtitleStyle,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      hintText: hint,
                      hintStyle: subtitleStyle,
                      // enabledBorder: const UnderlineInputBorder(
                      //   borderSide: BorderSide(color: darkHeaderClr, width: 0),
                      // ),
                      // focusedBorder: const UnderlineInputBorder(
                      //   borderSide: BorderSide(color: darkHeaderClr, width: 0),
                      // ),
                    )),
              ),
              widget ?? Container()
            ],
          ),
        ),
      ],
    );
  }
}
