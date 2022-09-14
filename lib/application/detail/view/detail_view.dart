import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_last_bloc/application/detail/bloc/detail_bloc.dart';

import '../../../domain/utils.dart';

enum Status { update, create }

class DetailPage extends StatefulWidget {
  final Status status;
  const DetailPage({Key? key, required this.status}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
 @override
  void didChangeDependencies() {
if(widget.status == Status.create){
  context.read<DetailBloc>().bodyController.clear();
  context.read<DetailBloc>().titleController.clear();
}
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DetailBloc>();

    return BlocListener<DetailBloc, DetailState>(
        listener: (context, state) {
          if (state is DetailSuccessState) {
            Utils.fireSnackBar(state.successMessage, context);
            Navigator.pop(context, "refresh");
          }

          if (state is DetailErrorState) {
            Utils.fireSnackBar(state.errorMessage, context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Detail Page"),
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.status == Status.create) {
                    bloc.add(DetailSaveEvent());
                  } else {
                    bloc.add(DetailUpdateEvent());
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: bloc.titleController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(hintText: "Title"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: bloc.bodyController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(hintText: "Body"),
                    ),
                  ],
                ),
              ),
              BlocBuilder<DetailBloc, DetailState>(
                builder: (context, state) {
                  if(state is DetailInitialState && state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ));
  }
}
