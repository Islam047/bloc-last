part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailSaveEvent extends DetailEvent {
  @override
  List<Object?> get props => [];
}

class DetailUpdateEvent extends DetailEvent {
  @override
  List<Object?> get props => [];
}

class DetailInitializeEvent extends DetailEvent {
  final Post post;

  const DetailInitializeEvent(this.post);

  @override
  List<Object?> get props => [];
}
