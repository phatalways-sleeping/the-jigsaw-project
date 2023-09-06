import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/screens/authentication/authentication_screen.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/screens/project_invitation/project_invitation_screen.dart';
import 'package:task_managing_application/screens/subtask_view/subtask_create_screen.dart';
import 'package:task_managing_application/screens/subtask_view/subtask_view_screen.dart';
import 'package:task_managing_application/screens/tasklist/tasklist_screen.dart';
import 'package:task_managing_application/screens/project/project_screen.dart';
import 'package:task_managing_application/screens/splash/splash_screen.dart';
import 'package:task_managing_application/states/authentication_bloc/authentication_bloc.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/splash_cubit/splash_cubit.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart';
import 'package:task_managing_application/states/tasklist_bloc/tasklist_bloc.dart';
import 'package:task_managing_application/states/user_project_invitation/user_project_invitation_bloc.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ApplicationRepository.repository.userId =
  //     "20230831-0517-8230-a202-0089f860b83a";

  // ApplicationRepository.repository.userImageUrl = "avatars/avatar_1.jpg";

  // ApplicationRepository.repository.userEmailAddress = "matwil@gmail.com";

  // ApplicationRepository.repository.username = "Mathew Wilson";

  ApplicationRepository.repository.userId =
      "20230831-0517-8130-8211-a9c1dfa3e677";

  ApplicationRepository.repository.userImageUrl = "avatars/avatar_2.jpg";

  ApplicationRepository.repository.userEmailAddress = "jane@example.com";

  ApplicationRepository.repository.username = "Jane Smith";

  runApp(
    RepositoryProvider(
      create: (context) => ApplicationRepository.repository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      title: 'Task Managing Application',
      theme: LightTheme.theme,
      home: BlocProvider(
        create: (context) =>
            NavigationBloc(context.read<ApplicationRepository>()),
        child: const AppFlow(),
      ),
    );
  }
}

class AppFlow extends StatelessWidget {
  const AppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: context.watch<NavigationBloc>().state,
      onGeneratePages: onGeneratePages,
    );
  }

  List<Page<dynamic>> onGeneratePages(
          NavigationState state, List<Page> pages) =>
      [
        if (state is Splash)
          MaterialPage(
            child: BlocProvider(
              create: (context) => SplashCubit(),
              child: const SplashScreen(),
            ),
          ),
        if (state is TestComponents)
          const MaterialPage(
            child: BaseScreen(
              hideFloatingActionButton: true,
              child: CustomScrollView(
                slivers: [
                  Center(
                    child: TaskTag(
                      color: PINK,
                      name: "2",
                    ),
                  )
                ],
              ),
            ),
          ),
        if (state is Authentication)
          MaterialPage(
            child: BlocProvider(
              create: (context) =>
                  AuthenticationBloc(context.read<ApplicationRepository>()),
              child: const AuthenticationScreen(),
            ),
          ),
        if (state is ProjectsList)
          MaterialPage(
            child: BlocProvider(
              create: (context) =>
                  ProjectBloc(context.read<ApplicationRepository>()),
              child: const ProjectScreen(),
            ),
          ),
        if (state is UserProjectInvitation)
          MaterialPage(
            child: BlocProvider(
              create: (context) => UserProjectInvitationBloc(
                  context.read<ApplicationRepository>()),
              child: const ProjectInvitationScreen(),
            ),
          ),
        if (state is TaskList)
          MaterialPage(
            child: BlocProvider(
              create: (context) => TasklistBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const TaskListScreen(),
            ),
          ),
        if (state is SubTaskCreate)
          MaterialPage(
            child: BlocProvider(
              create: (context) => SubtaskCreateBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const SubTaskCreateScreen(),
            ),
          ),
        if (state is SubTaskDetail)
          MaterialPage(
            child: BlocProvider(
              create: (context) => SubtaskViewBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const SubTaskScreen(),
            ),
          ),
        if (state is ChangePassword)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Home)
          MaterialPage(
            child: BaseScreen(
              hideFloatingActionButton: true,
              child: Container(
                height: 700,
                color: Colors.pink,
                width: double.infinity,
              ),
            ),
          ),
        if (state is Assistant)
          const MaterialPage(
            child: BaseScreen(
              hideFloatingActionButton: true,
              child: SizedBox(
                height: 700,
                width: double.infinity,
              ),
            ),
          ),
        if (state is Profile)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Settings)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
      ];
}
