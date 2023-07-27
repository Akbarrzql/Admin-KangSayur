import 'package:admin_kangsayur/ui/auth/event/logout_event.dart';
import 'package:admin_kangsayur/ui/auth/repository/logout_repository.dart';
import 'package:admin_kangsayur/ui/auth/state/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutPageBloc extends Bloc<LogoutPageEvent, LogoutPageState>{
  final LogoutRepository logoutRepository;

  LogoutPageBloc({required this.logoutRepository}) : super(InitialLogoutPageState()) {
    on<LogoutButtonPressed>((event, emit) async {
      emit(LogoutPageLoading());
      try {
        await logoutRepository.logout();
        emit(LogoutPageLoaded());
      } catch (e) {
        emit(LogoutPageError(e.toString()));
      }
    });
  }
}