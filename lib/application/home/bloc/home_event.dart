part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}
class HomeGetAllPostEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}
class HomeDeletePostEvent extends HomeEvent{
  final int id;
  const HomeDeletePostEvent(this.id);
  @override
  List<Object?> get props => [];

}
class HomeCreatePostEvent extends HomeEvent{
 final BuildContext context;
 const HomeCreatePostEvent(this.context);
  @override
  List<Object?> get props => [];

}
class HomeUpdatePostEvent extends HomeEvent{
  final BuildContext context;
  const HomeUpdatePostEvent(this.context);
  @override
  List<Object?> get props => [];

}
