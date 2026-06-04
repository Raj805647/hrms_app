import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils.dart';
import '../../../widget/custom_button.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
   OnboardingScreen({super.key});
   final ThemeManager themeManager = ThemeManager();
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Consumer<OnboardingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Column(
            children: [
              /// Skip Button - Top Right
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => provider.skip(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      backgroundColor: isDarkMode
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: themeManager.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

              /// PageView
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView.builder(
                  controller: provider.pageController,
                  onPageChanged: provider.onPageChanged,
                  itemCount: onboardingItems.length,
                  itemBuilder: (context, index) {
                    final item = onboardingItems[index];

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        key: ValueKey(index),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const Spacer(),

                            /// Animated Icon Container
                            _buildAnimatedIcon(item, index),

                            const SizedBox(height: 60),

                            /// Title
                            Text(
                              item['title'] as String,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: themeManager.text,
                                fontSize: 28,
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Description
                            Text(
                              item['description'] as String,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: themeManager.textSecondary,
                                height: 1.7,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 30),

                            /// Feature Chips
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                _buildFeatureChip("Smart"),
                                _buildFeatureChip("Fast"),
                                _buildFeatureChip("Secure"),
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

              /// Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingItems.length,
                      (index) {
                    final selected = provider.currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: selected ? 32 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: selected
                            ? LinearGradient(
                          colors: [
                            themeManager.primary,
                            themeManager.secondary,
                          ],
                        )
                            : null,
                        color: selected
                            ? null
                            : isDarkMode
                            ? Colors.white.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.3),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              /// Continue Button
              SizedBox(
                width: 250,
                child: AppButton(
                  title: provider.currentIndex == onboardingItems.length - 1
                      ? "Get Started"
                      : "Continue",
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => provider.nextPage(context),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedIcon(Map<String, dynamic> item, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow circle
          Container(
            height: 260,
            width: 260,
            decoration: BoxDecoration(
              color: themeManager.primary,
              shape: BoxShape.circle,
            ),
          ),

          // Decorative circle 1
          Positioned(
            top: 30,
            left: 20,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: themeManager.primary.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),

          // Decorative circle 2
          Positioned(
            bottom: 40,
            right: 30,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: themeManager.secondary.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),

          // Main icon container
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: themeManager.primary,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: themeManager.primary.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Icon(
              item['icon'] as IconData,
              size: 90,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String title, ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: themeManager.primary,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: themeManager.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}