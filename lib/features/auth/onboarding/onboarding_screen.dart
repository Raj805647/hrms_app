import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/utils.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/help_widget.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          body: Column(
            children: [

              /// Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: provider.skip,
                  child: const Text("Skip"),
                ),
              ),

              SizedBox(
                height: 700,
                child: PageView.builder(
                  controller: provider.pageController,
                  onPageChanged: provider.onPageChanged,
                  itemCount: onboardingItems.length,
                  itemBuilder: (_, index) {
                    final item = onboardingItems[index];

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        key: ValueKey(index),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          children: [

                            const Spacer(),

                            Stack(
                              alignment: Alignment.center,
                              children: [

                                Container(
                                  height: 260,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary.withOpacity(.15),
                                        AppColors.secondary.withOpacity(.15),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 30,
                                  left: 20,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(.4),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 40,
                                  right: 30,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary.withOpacity(.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),

                                TweenAnimationBuilder<double>(
                                  tween: Tween(
                                    begin: .8,
                                    end: 1,
                                  ),
                                  duration: const Duration(
                                    milliseconds: 700,
                                  ),
                                  curve: Curves.elasticOut,
                                  builder: (_, value, child) {
                                    return Transform.scale(
                                      scale: value,
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(40),

                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.secondary,
                                        ],
                                      ),

                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          AppColors.primary.withOpacity(.3),
                                          blurRadius: 30,
                                          offset: const Offset(0, 15),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      item['icon'],
                                      size: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            spaceHeight(60),

                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            spaceHeight(16),

                            Text(
                              item['description'],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.7),
                                height: 1.7,
                              ),
                            ),

                            spaceHeight(30),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                _featureChip("Smart"),
                                _featureChip("Fast"),
                                _featureChip("Secure"),
                              ],
                            ),

                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingItems.length,
                      (index) {
                    final selected =
                        provider.currentIndex == index;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      height: 8,
                      width: selected ? 32 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: selected
                            ? const LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.secondary,
                          ],
                        )
                            : null,
                        color: selected
                            ? null
                            : Colors.grey.withOpacity(.25),
                      ),
                    );
                  },
                ),
              ),

              spaceHeight(30),

              SizedBox(
                width: 250,
                child: AppButton(
                  title: provider.currentIndex == 4
                      ? "Get Started"
                      : "Continue",
                  icon: Icons.arrow_forward_rounded,
                  onPressed: ()=>provider.nextPage(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _featureChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.primary,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
    );
  }


}