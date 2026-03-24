// lib/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'language_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;
  late AnimationController _progressController;
  late Animation<double> _progressTween;

  double _targetProgress = 0.0;
  double _currentProgress = 0.0;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _progressTween = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_progressController);

    _progressController.addListener(() {
      setState(() {
        _currentProgress = _progressTween.value;
      });
    });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed && _targetProgress >= 1.0) {
        _maybeNavigate();
      }
    });

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _maybeNavigate();
      }
    });

    _loadAppData();
  }

  void _animateToProgress(double newTarget) {
    _targetProgress = newTarget.clamp(0.0, 1.0);

    _progressTween =
        Tween<double>(begin: _currentProgress, end: _targetProgress).animate(
          CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
        );

    _progressController
      ..reset()
      ..forward();
  }

  Future<void> _maybeNavigate() async {
    if (_targetProgress >= 1.0 &&
        _progressController.isCompleted &&
        _lottieController.isCompleted &&
        !_isNavigating) {
      _isNavigating = true;

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        // Убираем const перед LanguageSelectionScreen
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return const LanguageSelectionScreen(); // const можно оставить, так как конструктор const
            },
          ),
        );
      }
    }
  }

  Future<void> _loadAppData() async {
    await Future.delayed(const Duration(milliseconds: 1300));
    if (mounted) _animateToProgress(0.3);

    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) _animateToProgress(0.6);

    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) _animateToProgress(1.0);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/splash_animation.json',
              controller: _lottieController,
              width: 280,
              height: 280,
              fit: BoxFit.contain,
              repeat: false,
              frameRate: FrameRate.max,
              onLoaded: (composition) {
                _lottieController
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: _currentProgress,
                      backgroundColor: Colors.grey[900],
                      color: Colors.orange,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(_currentProgress * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
