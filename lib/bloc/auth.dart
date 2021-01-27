
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/services/repository/auth.dart';
import 'package:random_user/storage/user_data.dart';

class AuthBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  AuthBloc() : super(InitAuthScreenState());
  AuthRepository _repository = AuthRepository(UserDataStorageHive());

  @override
  Stream<AuthScreenState> mapEventToState(AuthScreenEvent event) async* {

    if (event is InitAuthScreenEvent) {
      if (_repository.isUserLoggedIn()) {
        yield LoggedInAuthScreenState();
      } else {
        yield InitAuthScreenState();
      }
    } else if (event is ValidateAuthScreenEvent) {
      if (_repository.validate(event.data)) {
        _repository.signIn(event.data);
        yield LoggedInAuthScreenState();
      } else {
        yield ValidationErrorAuthScreenState('Incorrect login!');
      }
    } else if (event is LoggedInAuthScreenEvent) {
      yield LoggedInAuthScreenState();
    }
  }

}
