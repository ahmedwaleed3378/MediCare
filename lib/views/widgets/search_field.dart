
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key, required this.width, required this.height,
  }) : super(key: key);
    final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child:const TextField(
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search By Patient ID',
              border:  OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Padding(
                padding:  EdgeInsets.all(14),
                child: Icon(Icons.search)
              )),
        ),
      ),
    );
  }
}
