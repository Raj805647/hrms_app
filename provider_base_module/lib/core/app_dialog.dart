import 'package:base_module/core/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDialogs {
  static Future showExitDialog(
      BuildContext context,
      ) async {
    final result = await showGeneralDialog(
      context: context,

      barrierDismissible: true,

      barrierLabel: "Exit",

      barrierColor: Colors.black.withOpacity(0.7),

      transitionDuration: const Duration(
        milliseconds: 350,
      ),

      pageBuilder: (_, __, ___) {
        return const SizedBox();
      },

      transitionBuilder:
          (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(
            animation.value,
          ),

          child: Opacity(
            opacity: animation.value,

            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 26,
                ),

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xff112240),

                  borderRadius:
                  BorderRadius.circular(30),

                  border: Border.all(
                    color: const Color(
                      0xffEF4444,
                    ).withOpacity(0.18),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xffEF4444,
                      ).withOpacity(0.15),

                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Material(
                  color: Colors.transparent,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      TweenAnimationBuilder(
                        tween: Tween(
                          begin: 0.95,
                          end: 1.08,
                        ),

                        duration: const Duration(
                          seconds: 2,
                        ),

                        curve: Curves.easeInOut,

                        builder:
                            (context, value, child) {
                          return Transform.scale(
                            scale: value,

                            child: Container(
                              width: 82,
                              height: 82,

                              decoration:
                              BoxDecoration(
                                shape:
                                BoxShape.circle,

                                gradient:
                                const LinearGradient(
                                  colors: [
                                    Color(
                                      0xffEF4444,
                                    ),
                                    Color(
                                      0xffF97316,
                                    ),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xffEF4444,
                                    ).withOpacity(
                                      0.28,
                                    ),

                                    blurRadius: 25,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),

                              child: const Icon(
                                Icons
                                    .exit_to_app_rounded,

                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Exit App",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Are you sure you want to close the application?",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(
                            0.7,
                          ),

                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },

                              child: Container(
                                height: 56,

                                decoration:
                                BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(
                                    0.06,
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),

                                  border: Border.all(
                                    color: const Color(
                                      0xff334155,
                                    ),
                                  ),
                                ),

                                child: const Center(
                                  child: Text(
                                    "Cancel",

                                    style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  true,
                                );

                                SystemNavigator.pop();
                              },

                              child: Container(
                                height: 56,

                                decoration:
                                BoxDecoration(
                                  gradient:
                                  const LinearGradient(
                                    colors: [
                                      Color(
                                        0xffEF4444,
                                      ),
                                      Color(
                                        0xffF97316,
                                      ),
                                    ],
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xffEF4444,
                                      ).withOpacity(
                                        0.25,
                                      ),

                                      blurRadius: 18,
                                    ),
                                  ],
                                ),

                                child: const Center(
                                  child: Text(
                                    "Exit",

                                    style: TextStyle(
                                      color:
                                      Colors.white,

                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return result ?? false;
  }
  static Future<Object> showLogoutDialog(
      BuildContext context,
      String routesName,
      ) async {
    final result = await showGeneralDialog(
      context: context,

      barrierDismissible: true,

      barrierLabel: "Logout",

      barrierColor: Colors.black.withOpacity(0.7),

      transitionDuration: const Duration(
        milliseconds: 350,
      ),

      pageBuilder: (_, __, ___) {
        return const SizedBox();
      },

      transitionBuilder:
          (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(
            animation.value,
          ),

          child: Opacity(
            opacity: animation.value,

            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 26,
                ),

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xff112240),

                  borderRadius:
                  BorderRadius.circular(30),

                  border: Border.all(
                    color: const Color(
                      0xff64FFDA,
                    ).withOpacity(0.18),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xff64FFDA,
                      ).withOpacity(0.12),

                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Material(
                  color: Colors.transparent,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Container(
                        width: 82,
                        height: 82,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient:
                          const LinearGradient(
                            colors: [
                              Color(0xff64FFDA),
                              Color(0xff9D4EDD),
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xff64FFDA,
                              ).withOpacity(0.25),

                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.logout_rounded,
                          color: Color(0xff0A192F),
                          size: 38,
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Logout",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Are you sure you want to logout from your account?",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.white.withOpacity(
                            0.7,
                          ),

                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },

                              child: Container(
                                height: 56,

                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.06),

                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),

                                  border: Border.all(
                                    color: const Color(
                                      0xff334155,
                                    ),
                                  ),
                                ),

                                child: const Center(
                                  child: Text(
                                    "Cancel",

                                    style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await StorageService
                                    .clearAllData();

                                Navigator.pop(
                                  context,
                                  true,
                                );

                                Navigator
                                    .pushNamedAndRemoveUntil(
                                  context,
                                  routesName,
                                      (route) => false,
                                );
                              },

                              child: Container(
                                height: 56,

                                decoration: BoxDecoration(
                                  gradient:
                                  const LinearGradient(
                                    colors: [
                                      Color(
                                        0xff64FFDA,
                                      ),
                                      Color(
                                        0xff9D4EDD,
                                      ),
                                    ],
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xff64FFDA,
                                      ).withOpacity(
                                        0.25,
                                      ),

                                      blurRadius: 18,
                                    ),
                                  ],
                                ),

                                child: const Center(
                                  child: Text(
                                    "Logout",

                                    style: TextStyle(
                                      color:
                                      Color(0xff0A192F),

                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return result ?? false;
  }
  static Future<bool?> _showAnimatedDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required IconData icon,
    required Color confirmColor,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(
            animation.value,
          ),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(icon, color: confirmColor),
                  const SizedBox(width: 10),
                  Text(title),
                ],
              ),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
