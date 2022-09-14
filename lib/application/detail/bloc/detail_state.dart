part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitialState extends DetailState {
  final bool isLoading;

  @override
  List<Object> get props => [isLoading];

  const DetailInitialState(this.isLoading);
}



class DetailErrorState extends DetailState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const DetailErrorState(this.errorMessage);
}

class DetailSuccessState extends DetailState {
  final String successMessage;
  @override
  List<Object> get props => [successMessage];

  const DetailSuccessState(this.successMessage);
}