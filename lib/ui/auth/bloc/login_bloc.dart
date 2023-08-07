import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/login_model.dart';
import '../event/login_event.dart';
import '../repository/login_repository.dart';
import '../state/login_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState>{
  late LoginModel loginModel;
  final LoginRepository loginRepository;

  LoginPageBloc({required this.loginRepository}) : super(InitialLoginPageState()){
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginPageLoading());
      try {
        loginModel = await loginRepository.login(event.email, event.password);
        emit(LoginPageLoaded(loginModel));
      } catch (e) {
        emit(LoginPageError(e.toString()));
      }
    });
  }

}