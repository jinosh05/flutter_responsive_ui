import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "configs/app.dart";
import "configs/apptheme.dart";
import "domain/cubit/theme/theme_cubit.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(
        create: (context) => ThemeCubit(),
      ),
    ], child: const MainApp(),);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    return MaterialApp(
      navigatorKey: navigatorKey,
      themeMode: themeCubit.themeMode,
      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darktheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ///
        /// Initial Properties of app are initiated
        ///
        App.init(context);
        return child!;
      },
      home: FutureBuilder(
        builder: (context, snapshot) => const Scaffold(),
        future: null,
      ),
    );
  }
}
