import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F172A),

      body: SafeArea(

        child: Center(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              //------------------------------------------------
              // Logo temporal
              //------------------------------------------------

              Container(

                width: 150,

                height: 150,

                decoration: BoxDecoration(

                  color: Colors.blue.shade700,

                  shape: BoxShape.circle,

                  boxShadow: [

                    BoxShadow(

                      color: Colors.black.withOpacity(.30),

                      blurRadius: 18,

                      offset: const Offset(0,8),

                    )

                  ],

                ),

                child: const Center(

                  child: Text(

                    "EC",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 60,

                      fontWeight: FontWeight.bold,

                      letterSpacing: 2,

                    ),

                  ),

                ),

              ),

              const SizedBox(height: 35),

              //------------------------------------------------
              // Nombre
              //------------------------------------------------

              const Text(

                "ELECTROCHILE",

                style: TextStyle(

                  color: Colors.white,

                  fontSize: 34,

                  fontWeight: FontWeight.bold,

                  letterSpacing: 2,

                ),

              ),

              const SizedBox(height: 6),

              Text(

                "PRO",

                style: TextStyle(

                  color: Colors.amber.shade600,

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                  letterSpacing: 3,

                ),

              ),

              const SizedBox(height: 18),

              const Text(

                "Instaladores Eléctricos de Chile",

                style: TextStyle(

                  color: Colors.white70,

                  fontSize: 16,

                ),

              ),

              const SizedBox(height: 70),

              const SizedBox(

                width: 45,

                height: 45,

                child: CircularProgressIndicator(

                  strokeWidth: 4,

                  color: Colors.amber,

                ),

              ),

              const SizedBox(height: 18),

              const Text(

                "Cargando...",

                style: TextStyle(

                  color: Colors.white70,

                  fontSize: 15,

                ),

              ),

              const SizedBox(height: 60),

              const Text(

                "Versión 1.0",

                style: TextStyle(

                  color: Colors.white38,

                  fontSize: 13,

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}