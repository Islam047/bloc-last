part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState(this.isLoading, this.list);

  final bool isLoading;

  final List<Post> list;
}

class HomeInitialState extends HomeState {
  const HomeInitialState(super.isLoading, super.list);

  @override
  List<Object?> get props => [isLoading];
}

class HomeGetAllState extends HomeState {
  const HomeGetAllState(super.isLoading, super.list);

  @override
  List<Object?> get props => [];
}

class HomeDeletePost extends HomeState {

  const HomeDeletePost(super.isLoading, super.list);

  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  const HomeErrorState(super.isLoading, super.list);

  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState(super.isLoading, super.list);

  @override
  List<Object?> get props => [];
}
