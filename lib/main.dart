import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/fitness_repository.dart';
import 'cubit/fitness_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FitnessRepository(),
      child: BlocProvider(
        create: (context) => FitnessCubit(
          context.read<FitnessRepository>(),
        )..fetchFitnessData(),
        child: MaterialApp(
          title: 'Laborator nr3 - Fitness App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF101115),
            primaryColor: const Color(0xFF20C766),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF20C766),
              secondary: Color(0xFF1E222B),
              surface: Color(0xFF1E222B),
            ),
            fontFamily: 'Roboto',
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
