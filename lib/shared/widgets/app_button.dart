import 'package:biz_invoice/shared/extensions/context_extensions.dart';
import 'package:biz_invoice/shared/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? borderColor;
  final bool enable;
  final bool haveTop;
  final bool loading;
  final Color? loadingColor;
  final double height;
  final String? text;

  const AppButton({
    Key? key,
    this.child,
    this.onPressed,
    this.enable = true,
    this.bgColor,
    this.borderColor,
    this.loading = false,
    this.haveTop = true,
    this.height = 50.0,
    this.loadingColor,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: enable ? bgColor : bgColor?.withOpacity(.6),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: 1.5,
                  )
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  (!loading && enable && onPressed != null) ? onPressed : null,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Opacity(
                  opacity: loading ? 0 : 1,
                  child: text != null
                      ? Text(
                          text!,
                          style: context.textTheme.titleLarge?.copyWith(
                            color: kLightPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : child,
                ),
              ),
            ),
          ),
        ),
        loading == false
            ? Container()
            : Positioned.fill(
                child: Center(
                  child: CupertinoTheme(
                    data: CupertinoTheme.of(context).copyWith(
                      brightness: bgColor == kPrimary
                          ? Brightness.dark
                          : Brightness.light,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: 16,
                      color: loadingColor,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
