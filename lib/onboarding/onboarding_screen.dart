import 'package:auto_route/auto_route.dart';
import 'package:biz_invoice/shared/theme/app_colors.dart';
import 'package:biz_invoice/shared/utils/const.dart';
import 'package:biz_invoice/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboarding_item_widget.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;

  int index = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: index,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Color getCurrentDotIndicatorColor(int index) {
    return switch (index) {
      0 => kYellow,
      1 => kPrimary,
      2 => kDarkSecondary,
      _ => kBlack,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.paddingOf(context).top,
            ),
            Expanded(
              flex: 5,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                children: const [
                  OnboardingItemWidget(
                    image: 'assets/images/create.png',
                    title: 'Fini les factures fastidieuses !🎉',
                    description:
                        'Simplifiez et accélérez la création de vos factures avec notre application conviviale',
                  ),
                  OnboardingItemWidget(
                    image: 'assets/images/template.png',
                    title: 'Des factures à votre image !🔥',
                    description:
                        'Personnalisez vos factures avec votre logo, vos couleurs et vos informations.',
                  ),
                  OnboardingItemWidget(
                    image: 'assets/images/send.png',
                    title: 'Factures envoyées, clients satisfaits !💸',
                    description:
                        'Partagez vos factures avec vos clients en quelques clics. pdf, image, etc...',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (i) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              child: Container(
                                width: index == i ? 70 : 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: index == i
                                      ? getCurrentDotIndicatorColor(i)
                                      : kBlack,
                                  shape: index == i
                                      ? BoxShape.rectangle
                                      : BoxShape.circle,
                                  borderRadius: index == i
                                      ? BorderRadius.circular(8)
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    AppButton(
                      onPressed: () {
                        if (index <= 1) {
                          setState(() {
                            pageController.nextPage(
                              duration: appDurationDouble,
                              curve: Curves.ease,
                            );
                          });
                          return;
                        }
                      },
                      bgColor: kBlack,
                      text: index == 2 ? 'Commencer' : 'Continuer',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.paddingOf(context).top,
            ),
          ],
        ),
      ),
    );
  }
}
