import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final Icon icon;

  const IconButtonWidget({
    @required this.buttonText,
    @required this.buttonColor,
    this.textColor = Colors.white,
    @required this.onPressed,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool cond = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 45,
          color: cond ? Colors.white : buttonColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cond
                    ? Icon(
                        icon.icon,
                        color: buttonColor,
                      )
                    : icon,
                buttonText != null ? SizedBox(width: 10) : Container(),
                buttonText != null
                    ? Text(
                        buttonText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: cond ? buttonColor : Colors.white),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
