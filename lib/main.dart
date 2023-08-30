import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox.dart';
import 'package:task_managing_application/widgets/custom_item_widget/custom_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository.instance,
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => StorageRepository.instance,
        ),
      ],
      child: MaterialApp(
        title: 'Task Managing Application',
        theme: LightTheme.theme,
        home: BlocProvider(
          create: (context) => NavigationBloc(),
          child: const AppFlow(),
        ),
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
        if (state is TestComponents)
          const MaterialPage(
            child: BaseScreen(
              child: CustomItemWidget(
                firstChild: CheckboxWidget(),
                isFixed: true,
                name: 'Design UI',
                subtext: '10pt',
                secondChild: Icon(Icons.add,
              ),
            ),
          )
          ),
        if (state is Login)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is SignUp)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is ForgotPassword)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is ChangePassword)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Home)
          const MaterialPage(
            child: BaseScreen(
              child: SizedBox(
                height: 700,
                width: double.infinity,
              ),
            ),
          ),
        if (state is ProjectsList)
          const MaterialPage(
            child: BaseScreen(
              child: SizedBox(
                height: 700,
                width: double.infinity,
              ),
            ),
          ),
        if (state is Assistant)
          const MaterialPage(
            child: BaseScreen(
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
        if (state is Dashboard)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
      ];
}
