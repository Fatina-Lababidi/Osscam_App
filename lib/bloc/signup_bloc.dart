import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osscam/model/register_model.dart';
import 'package:osscam/service/register_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<Signup>((event, emit) async{
      emit(Loading());
      bool result= await SignUpService(event.user);
      if (result) {
        emit(Success());
        
      }else{
        emit(Failed());
      }
       });
  }
}
