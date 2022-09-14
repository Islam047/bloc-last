
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_last_bloc/data/model/post_model.dart';

import '../../../domain/post_repository.dart';
import '../../detail/view/detail_view.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PostRepository postRepository = PostRepository.instance;

  HomeBloc() : super(const HomeInitialState(true, [])) {
    on<HomeGetAllPostEvent>(getAllPost);
    on<HomeDeletePostEvent>(deleteOnePost);
    on<HomeCreatePostEvent>(createPost);
    on<HomeUpdatePostEvent>(updatePost);
  }

  void getAllPost(HomeGetAllPostEvent event, Emitter<HomeState> emitter) async {
    var result = await postRepository.apiPostList();
    emitter(HomeGetAllState(false, result));
  }

  void deleteOnePost(
      HomeDeletePostEvent event, Emitter<HomeState> emitter) async {
    emitter(HomeInitialState(true, state.list));
    bool response = await postRepository.apiPostDelete(event.id);
    if (response) {
      state.list.removeWhere((element) => element.id == event.id);
      emitter(HomeSuccessState(false, state.list));
    } else {
      emitter(HomeErrorState(false, state.list));
    }
  }

  void createPost(HomeCreatePostEvent event, Emitter<HomeState> emitter) async {
    String? result = await Navigator.push(event.context,
        MaterialPageRoute(builder: (context) => const DetailPage(status: Status.create,)));

    if (result != null) {
      emitter(HomeInitialState(true, state.list));
      var result = await postRepository.apiPostList();
      emitter(HomeGetAllState(false, result));
    }
  }
  void updatePost(HomeUpdatePostEvent event,Emitter<HomeState> emitter)async{
    String? result = await Navigator.push(event.context,
        MaterialPageRoute(builder: (context) => const DetailPage(status: Status.update,)));

    if (result != null) {

      emitter(HomeInitialState(true, state.list));
      var result = await postRepository.apiPostList();
      emitter(HomeGetAllState(false, result));
    }
  }
}
