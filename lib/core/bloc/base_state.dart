import 'package:equatable/equatable.dart';

sealed class BlocState {}

class Initialize extends BlocState {}

class Loading extends BlocState {}

class Success<T> extends BlocState with EquatableMixin {
  final T? data;
  final String? message;

  Success({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [data, message];
}

class Error extends BlocState {
  final String message;
  Error({required this.message});
}
