import 'package:flutter/cupertino.dart';
import '../model/dashboard_model.dart';

@immutable
abstract class DashboardState {}

class InitialDashboardState extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardModel dashboardModel;

  DashboardLoaded(this.dashboardModel);
}

class DashboardError extends DashboardState {
  final String errorMessage;

  DashboardError(this.errorMessage);
}