import 'package:flutter/material.dart';
import 'package:movies_app/features/splash/presentation/views/widgets/slidinglogo.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    navigateToOnBoarding();
    initSlidingAnimation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071E3A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SlidingLogo(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 3), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToOnBoarding() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamed(context, '/login');
      },
    );
  }
}
