part of 'add_bugs_bloc.dart';

@immutable
sealed class AddBugsState {}

final class AddBugsInitial extends AddBugsState {}


class LoadingAddBug extends AddBugsState{}

class SuccessAddBug extends AddBugsState{}

class ErrorAddBug extends AddBugsState{}

class OfflineAddBug extends AddBugsState{}
