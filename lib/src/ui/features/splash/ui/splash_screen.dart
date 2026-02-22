import 'package:estatehub_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.home_work_rounded,
          size: deviceSize.width * 0.12,
          color: cs.onPrimary,
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(milliseconds: 600));
    if (mounted) context.go(Routes.login);
  }
}
