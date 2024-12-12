import '../../src/pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _navigateAfterDelay();
    super.initState();
  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go(Constants.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                AppAsset.logo,
              )
                  .animate()
                  .scaleXY(
                    begin: 0.5,
                    end: 1.0,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scaleXY(
                    begin: 1.0,
                    end: 0.5,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  ), // Repeat the animation
            ),
          ),
        ],
      ),
    );
  }
}
