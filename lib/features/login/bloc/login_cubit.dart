import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:qit_test/features/login/service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginApiService _service = LoginApiService();
  String emailToSend = "";
  String password = "";

  login() async {
    if (emailToSend.isNotEmpty && password.isNotEmpty && emailValidator()) {
      try {
        emit(LoginLoading());
        var response = await _service.sendData(emailToSend, password);
        var data = response.data;
        var pref = GetIt.I.get<SharedPreferences>();
        pref.setString("token", data["data"]["Token"]);
        emit(LoginLoaded(data["data"]["Name"], data["data"]["Email"], data["data"]["Token"]));
      } on DioError catch (e) {
        if (e.response != null) {
          print(e.response?.data);
          var data = e.response?.data;
          emit(LoginError(data["Message"]));
        } else {
          print(e.message);
          emit(LoginError(e.message));
        }
      }
    }else {
      emit(LoginError("Check Fields"));
    }
  }

  emailValidator() {
    EmailValidator.validate(emailToSend)
        ? emit(LoginEmailCorrect())
        : emit(LoginEmailIncorrect());
    return EmailValidator.validate(emailToSend);
  }
}
