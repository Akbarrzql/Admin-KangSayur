import 'package:admin_kangsayur/ui/sidebar/item/dashboard/event/dashboard_event.dart';
import 'package:admin_kangsayur/ui/sidebar/item/dashboard/state/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/dashboard_model.dart';
import '../repository/dashboard_repository.dart';

class DashboardPageBloc extends Bloc<DashboardEvent, DashboardState>{
  late DashboardModel dashboardModel;
  final DashboardRepository dashboardRepository;

  DashboardPageBloc({required this.dashboardRepository}) : super(InitialDashboardState()){
    on<GetDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        dashboardModel = await dashboardRepository.getDashboard();
        emit(DashboardLoaded(dashboardModel));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }

}