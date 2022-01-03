import 'package:flutter/material.dart';
import 'package:lost_and_found/src/utils/app_colors.dart';

class AppButton extends StatelessWidget {
  Color bgColor;
  Color textColor;
  String text;
  Widget? leading;
  VoidCallback? onTap;
  bool disabled;
  AppButton({
    Key? key,
    required this.text,
    this.bgColor = AppColors.primary,
    this.textColor = Colors.white,
    this.onTap,
    this.leading,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: disabled ? bgColor.withOpacity(.5) : bgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: leading!,
                ),
              Text(
                "$text",
                style: TextStyle(
                  color: disabled ? textColor.withOpacity(.5) : textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
