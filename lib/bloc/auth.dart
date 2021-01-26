
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/services/repository/auth.dart';
import 'package:random_user/storage/user_data.dart';

class AuthBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  AuthBloc() : super(InitAuthScreenState());

  @override
  Stream<AuthScreenState> mapEventToState(AuthScreenEvent event) async* {

    if (event is InitAuthScreenEvent) {
      yield InitAuthScreenState();
    } else if (event is ValidateAuthScreenEvent) {
      var repository = AuthRepository(UserDataStorageHive());

      if (repository.validate(event.data)) {
        repository.signIn(event.data);
        yield LoggedInAuthScreenState();
      } else {
        yield ValidationErrorAuthScreenState('Incorrect login!');
      }

      yield ValidateAuthScreenState();
    } else if (event is LoggedInAuthScreenEvent) {
      yield LoggedInAuthScreenState();
    }
  }

}
