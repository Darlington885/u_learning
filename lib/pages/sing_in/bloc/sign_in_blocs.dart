
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sing_in/bloc/signin_events.dart';
import 'package:ulearning_app/pages/sing_in/bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc():super(SignInState()){
    on<EmailEvent>(_emailEvent); //on<> Method has a type of class
    on<PasswordEvent>(_passwordEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit){
    print("My email is ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit){
    print("My password is ${event.password}");
    emit(state.copyWith(password: event.password));
  }

}