

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/states.dart';

import 'events.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState>
{
  UserProfileBloc() : super(IndexUserProfileState());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    switch (event.runtimeType) {
      case InitUserProfileEvent:
        yield IndexUserProfileState();
        break;
    }
  }
}
