// Base screen state to be used in all screens to handle loading, idle and error states
enum BaseScreenState { loading, idle, error }

// Extension on BaseViewState to make it easier to work with

extension BaseViewStateX on BaseScreenState {
  bool get isLoading => this == BaseScreenState.loading;

  bool get isIdle => this == BaseScreenState.idle;

  bool get isError => this == BaseScreenState.error;

  R when<R>({
    required R Function() loading,
    required R Function() idle,
    required R Function() error,
  }) => switch (this) {
      BaseScreenState.loading => loading(),
      BaseScreenState.idle => idle(),
      BaseScreenState.error => error(),
    };
}
