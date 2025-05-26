import 'package:flutter/material.dart';

class SlidingLogo extends StatelessWidget {
  const SlidingLogo({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/popcorn.png', // Replace with the path to your logo image
                height: 100, // Adjust the height as needed
                width: 100, // Adjust the width as needed
              ),
              const Text(
                'watch and find movie\n that bring your mood back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.0,
                    fontFamily: 'Staatliches'),
                textAlign: TextAlign.center,
                // Center-align the text
              ),
            ],
          ),
        );
      },
    );
  }
}
