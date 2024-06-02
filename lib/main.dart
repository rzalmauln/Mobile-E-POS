import 'package:e_pos/core/app_theme_data.dart';
import 'package:e_pos/cubits/login/login_cubit.dart';
import 'package:e_pos/cubits/register/register_cubit.dart';
import 'package:e_pos/cubits/store/cubit_store.dart';
import 'package:e_pos/injection_container.dart';
import 'package:e_pos/views/login_register/login_screen.dart';
import 'package:e_pos/views/pin/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await initializeDependecies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<StoreCubit>()),
            BlocProvider(create: (context) => sl<LoginCubit>()),
            BlocProvider(create: (context) => sl<RegisterCubit>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.getTheme(context),
            home: FutureBuilder<bool>(
              future: _checkUserStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else {
                  if (snapshot.data == true) {
                    // User has already logged in and created PIN
                    return const PinScreen(isCreatingPin: false);
                  } else {
                    // User has not logged in or created PIN
                    return const LoginScreen();
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLoggedIn = prefs.getBool('userLogin') ?? false;
    final hasCreatedPin = prefs.getString('userPinCreated') ?? "";

    return hasLoggedIn && hasCreatedPin != "";
  }
}
