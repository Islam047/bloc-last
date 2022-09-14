import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_last_bloc/application/detail/bloc/detail_bloc.dart';
import 'package:online_last_bloc/application/detail/view/detail_view.dart';
import 'package:online_last_bloc/application/home/bloc/home_bloc.dart';
import '../../../domain/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccessState) {
            Utils.fireSnackBar("Post successfully deleted!", context);
          }
          if (state is HomeErrorState) {
            Utils.fireSnackBar("Something error, please try again!", context);
          }
        },
        builder: (context, state) {
          var bloc = context.read<HomeBloc>();
    bloc.add(HomeGetAllPostEvent());
          return Stack(
            children: [
              ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                context.read<DetailBloc>().add(DetailInitializeEvent(state.list[index]));
                                context.read<HomeBloc>().add(HomeUpdatePostEvent(context));

                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.update,
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                context.read<HomeBloc>().add(HomeDeletePostEvent(state.list[index].id));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_outline,
                            ),
                          ],
                        ),

                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            state.list[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            state.list[index].body,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
              ),

              if(state.isLoading) const Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeBloc>().add(HomeCreatePostEvent(context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
