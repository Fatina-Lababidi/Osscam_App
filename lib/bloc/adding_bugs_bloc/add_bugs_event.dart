// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_bugs_bloc.dart';

@immutable
sealed class AddBugsEvent {}

class AddBug extends AddBugsEvent {
  AddingBugsModel bug;
  AddBug({
    required this.bug,
  });
}
