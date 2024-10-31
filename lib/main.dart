import 'package:azem/features/expert/expertHome/presentation/pages/home_screen.dart';
import 'package:azem/features/user/expert/data/repositories/subscription_repository_imp.dart';
import 'package:azem/features/user/expert/presentation/provider/subscription_provider.dart';
import 'package:azem/features/user/nutrition/domain/useCases/delete_today_food_ration_use_case.dart';
import 'package:azem/features/user/nutrition/presentation/provider/food_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/expert/users/presentation/pages/analysis_workout_screen.dart';
import 'features/expert/users/presentation/pages/users_screen.dart';
import 'features/main_features/presentation/pages/welcom_screen.dart';
import 'features/main_features/presentation/provider/sign_in_provider.dart';
import 'features/main_features/presentation/provider/sign_up_provider.dart';
import 'features/user/expert/data/repositories/expert_repository_imp.dart';
import 'features/user/expert/domain/useCases/get_coaches.dart';
import 'features/user/expert/domain/useCases/get_experts.dart';
import 'features/user/expert/domain/useCases/get_nutritionists.dart';
import 'features/user/expert/presentation/provider/expert_provider.dart';
import 'features/user/home/presentation/pages/home_screen.dart';
import 'features/user/nutrition/data/repositories/daily_food_ration_repository_imp.dart';
import 'features/user/nutrition/data/repositories/food_repository_impl.dart';
import 'features/user/nutrition/domain/useCases/get_food_by_category_use_case.dart';
import 'features/user/nutrition/domain/useCases/get_today_food_ration_use_case.dart';
import 'features/user/nutrition/domain/useCases/set_today_food_ration_use_case.dart';
import 'features/user/nutrition/presentation/provider/daily_food_ration_provider.dart';
import 'features/user/nutrition/presentation/provider/get_current_slider_food.dart';
import 'features/user/programs/presentation/pages/meals_program.dart';
import 'features/user/programs/presentation/pages/workout.dart';
import 'features/user/userManagement/data/dataSources/user_remote_dataSource.dart';
import 'features/user/userManagement/data/repositories/user_repository_imp.dart';
import 'features/user/userManagement/presentation/pages/sing_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'core/connection/networkInfo.dart';
import 'features/user/userManagement/presentation/provider/current_user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('==================User is currently signed out!');
      } else {
        print('===================User is signed in!');

        // Fetch the role from Firestore
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        final role = userDoc.get('role');

        // Navigate based on the role
        if (role == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (role == 'أخصائي تغذية'|| role == 'مدرب') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExpertHomeScreen()),
          );
        } else {
          // Handle any unexpected role, possibly with an error screen or redirect
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Instantiate the repositories
    final expertRepository = ExpertRepositoryImpl(FirebaseFirestore.instance);
    final networkInfo = NetworkInfoImp(InternetConnectionChecker());
    final foodRepository = FoodRepositoryImpl(FirebaseFirestore.instance, networkInfo);
    final dailyFoodRationRepository = DailyFoodRationRepositoryImp(FirebaseFirestore.instance, networkInfo);
    final subscriptionRepository = SubscriptionRepositoryImp(FirebaseFirestore.instance, networkInfo);
    final userRemoteDataSource = UserRemoteDataSourceImpl(FirebaseFirestore.instance);
    final userRepository = UserRepositoryImpl(userRemoteDataSource);
    // Instantiate the use cases
    final getFoodByCategoryUseCase = GetFoodByCategoryUseCase(foodRepository);
    final getExpertsUseCase = GetExpertsUseCase(expertRepository);
    final getCoachesUseCase = GetCoachesUseCase(expertRepository);
    final getNutritionistsUseCase = GetNutritionistsUseCase(expertRepository);
    final getTodayFoodRationUseCase = GetTodayFoodRationUseCase(dailyFoodRationRepository);
    final setTodayFoodRationUseCase = SetTodayFoodRationUseCase(dailyFoodRationRepository);
    final deleteTodayFoodRationUseCase = DeleteTodayFoodRationUseCase(dailyFoodRationRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpertProvider(
            getExpertsUseCase: getExpertsUseCase,
            getCoachesUseCase: getCoachesUseCase,
            getNutritionistsUseCase: getNutritionistsUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodProvider(getFoodByCategoryUseCase),
        ),
        ChangeNotifierProvider(
          create: (context) => GetCurrentSliderFoodProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscriptionProvider(
            subscriptionRepository: subscriptionRepository,
            userRepository: userRepository, // Add the required userRepository
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DailyFoodRationProvider(
            getTodayFoodRationUseCase: getTodayFoodRationUseCase,
            setTodayFoodRationUseCase: setTodayFoodRationUseCase,
            deleteTodayFoodRationUseCase: deleteTodayFoodRationUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
        routes: {
          'AnalysisWorkoutScreen': (context) => AnalysisWorkoutScreen(),
          'singUp': (context) => const CreateAccountScreen(),
          'Home': (context) => const HomeScreen(),
          'UsersScreen': (context) => const UsersScreen(),
          'ExpertHomeScreen' : (context) => const ExpertHomeScreen(),
          'MealProgramScreen' : (context) => const MealProgramScreen(),
          'WorkoutsScreen': (context) => const WorkoutsScreen(),

        },
      ),
    );
  }
}
