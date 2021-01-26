

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/states.dart';

import 'events.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState>
{
  UserProfileBloc() : super(IndexUserProfileState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async*
  {
    switch (event) {

      case UserProfileEvent.Index:
        yield IndexUserProfileState();
        break;

        /// Выбрасываешь ошибку, но не ловишь. Это приведет к крашу
      default:
        throw Exception('Unknown user profile screen event.');
    }
  }

}
