// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const ProjectsList()) {
    on<NavigateToSplash>((event, emit) => emit(const Splash()));
    on<NavigateToTestComponents>(_onNavigateToTestComponents);
    on<NavigateToChangePassword>(_onNavigateToChangePassword);
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToAuthentication>(_navigateToAuthentication);
    on<NavigateToProjectsList>(_onNavigateToProjectsList);
    on<NavigateToAssistant>(_onNavigateToAssistant);
    on<NavigateToProfile>(_onNavigateToProfile);
    on<NavigateToSettings>(_onNavigateToSettings);
  }

  Future<void> _onNavigateToTestComponents(
    NavigateToTestComponents event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const TestComponents());
  }

  Future<void> _onNavigateToChangePassword(
    NavigateToChangePassword event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ChangePassword());
  }

  Future<void> _onNavigateToHome(
    NavigateToHome event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Home());
  }

  Future<void> _onNavigateToProfile(
    NavigateToProfile event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Profile());
  }

  Future<void> _onNavigateToSettings(
    NavigateToSettings event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Settings());
  }

  Future<void> _onNavigateToProjectsList(
    NavigateToProjectsList event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const ProjectsList());
  }

  Future<void> _onNavigateToAssistant(
    NavigateToAssistant event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Assistant());
  }

  Future<void> _navigateToAuthentication(
    NavigateToAuthentication event,
    Emitter<NavigationState> emit,
  ) async {
    emit(const Authentication());
  }
}
