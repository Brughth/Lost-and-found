import 'package:biz_invoice/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const OnboardingItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
        ),
        SizedBox(height: 20.h),
        Text(
          title,
          style: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              //fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
          ),
        )
      ],
    );
  }
}
