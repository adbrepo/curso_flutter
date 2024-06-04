import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class BaseScreenState extends Equatable {
  const BaseScreenState._();

  const factory BaseScreenState.loading() = LoadingState;

  const factory BaseScreenState.idle() = IdleState;

  const factory BaseScreenState.error(String error) = ErrorState;

  @override
  List<Object?> get props => [];
}

class LoadingState extends BaseScreenState {
  const LoadingState() : super._();
}

class IdleState extends BaseScreenState {
  const IdleState() : super._();
}

class ErrorState extends BaseScreenState {
  final String error;

  const ErrorState(this.error) : super._();

  @override
  List<Object?> get props => [error];
}

// -----------------------------------------------------------------------------
// Extension on BaseViewState to make it easier to work with

extension BaseViewStateX on BaseScreenState {
  bool get isLoading => this is LoadingState;

  bool get isIdle => this is IdleState;

  bool get isError => this is ErrorState;

  String? get error => (this as ErrorState).error;

  R when<R>({
    required R Function() loading,
    required R Function() idle,
    required R Function(String error) error,
  }) {
    final state = this;
    switch (state) {
      case LoadingState():
        return loading();
      case IdleState():
        return idle();
      case ErrorState():
        return error((state).error);
      default:
        throw AssertionError();
    }
  }
}
