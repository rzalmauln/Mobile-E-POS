import 'package:e_pos/core/app_theme_data.dart';
import 'package:e_pos/cubit/store/cubit_store.dart';
import 'package:e_pos/data/faker/store_factory.dart';
import 'package:e_pos/data/services/store_service.dart';
import 'package:e_pos/injection_container.dart';
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
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemeData.getTheme(context),
              home: FutureBuilder<bool>(
                future: _checkFirstTimeUser(),
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
                    return PinScreen(isCreatingPin: snapshot.data!);
                  }
                },
              )),
        );
      },
    );
  }

  Future<bool> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userpin') == null;
  }
}
