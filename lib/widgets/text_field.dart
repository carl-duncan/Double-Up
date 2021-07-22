import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final int lines;
  final TextInputType type;
  final dynamic onChanged;
  final bool enabled;
  final IconData suffix;
  Field({
    @required this.hint,
    @required this.controller,
    @required this.obscure,
    @required this.suffix,
    this.lines = 1,
    @required this.label,
    @required this.enabled,
    this.type,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "$label:",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
            TextField(
              controller: controller,
              keyboardType: type,
              maxLines: lines,
              onChanged: onChanged,
              textInputAction: TextInputAction.done,
              enabled: enabled,
              obscureText: obscure,
              decoration: InputDecoration(
                isDense: true,

                filled: true,
                // fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelText: hint,
                floatingLabelBehavior: FloatingLabelBehavior.never,

                // helperText: 'help',
                // counterText: 'counter',
                // icon: Icon(Icons.star),
                prefixIcon: Icon(suffix),
                // suffixIcon: Icon(AntDesign.car),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
