import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'layout/todo_layout.dart';


void main()
{
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();

          DioHelper.init();
          await CacheHelper.init();
          
          bool? isDark = CacheHelper.getData(key: 'isDark');

          runApp(MyApp(
            isDark: isDark,
            startWidget: ToDoLayout(),
          ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget? startWidget;

  MyApp({Key? key,
    this.isDark,
    this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}