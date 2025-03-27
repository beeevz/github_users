import 'package:equatable/equatable.dart';

sealed class Result<D, E extends RootError> {
  bool isError() {
    return this is Error;
  }
}

class Success<D, E extends RootError> extends Result<D, E> {
  final D data;
  Success(this.data);
}

class Error<D, E extends RootError> extends Result<D, E> {
  final E error;
  Error(this.error);
}

abstract class RootError extends Equatable {
  @override
  List<Object?> get props => [];
}