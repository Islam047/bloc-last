import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_last_bloc/application/detail/view/detail_view.dart';
import 'package:online_last_bloc/data/model/post_model.dart';

import '../../../domain/post_repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  PostRepository postRepository = PostRepository.instance;
  int id = 0;
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController bodyController = TextEditingController(text: '');

  DetailBloc() : super(const DetailInitialState(false)) {
    on<DetailEvent>((event, emit) {});
    on<DetailSaveEvent>(createPost);
    on<DetailUpdateEvent>(updateEvent);
    on<DetailInitializeEvent>(initDetailEvent);
  }


  Future<void> createPost(DetailSaveEvent event, Emitter<DetailState> emitter)async{
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    if(title.isEmpty || body.isEmpty){
      emitter(const DetailErrorState("Some Error"));
      return;
    }
    emitter(const DetailInitialState(true));
    var result = await postRepository.createPost(title, body, 1);

    if(result) {
      emitter(const DetailSuccessState("Successfully accomplished!!"));

    } else {
      emitter(const DetailErrorState("Post wasn't created!"));
    }

  }
  Future<void> updateEvent(DetailUpdateEvent event, Emitter<DetailState> emitter)async{
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    if(title.isEmpty || body.isEmpty){
      emitter(const DetailErrorState("Some Error"));
      return;
    }
    emitter(const DetailInitialState(true));
    bool? response = await postRepository.updatePost(title, body, id);
    if(response){
      emitter(const DetailSuccessState("Successfully accomplished!"));

    }else{
      emitter(const DetailErrorState("Post wasn't created!"));

    }


  }
  Future<void> initDetailEvent(DetailInitializeEvent event, Emitter<DetailState> emitter)async {
    titleController.clear();
    bodyController.clear();
      titleController = TextEditingController(text: event.post.title);
      bodyController = TextEditingController(text: event.post.title);
      id = event.post.id;

  }
}
