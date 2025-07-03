import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paymaya/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:paymaya/features/wallet/presentation/screens/wallet_screen.dart';

import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<WalletCubit>()..loadWallet(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pay Maya',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF121712),
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.manropeTextTheme(),
        ),
        home: const WalletScreen(),
      ),
    );
  }
}
