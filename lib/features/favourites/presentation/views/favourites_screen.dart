import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/favourites/presentation/views_model/cubit/favourite_cubit.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constbackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: constbackground,
        title: const Text(
          'My Favourite list',
          style: TextStyle(color: Color(0xffF83758)),
        ),
      ),
      body: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {
        if (state is FavouriteRemoved) {
          showToast(message: '${state.item.Title} removed successfully');
        }
      }, builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavouriteLoaded) {
          final favouritelist = state.favouritelist;
          if (favouritelist.isEmpty) {
            return const Center(
              child: Text(
                'No Favourite Movies Yet',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favouritelist.length,
              itemBuilder: (context, index) {
                final favitem = favouritelist[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: MoviesListItem(favitem: favitem));
              },
            );
          }
        } else if (state is FavouriteFailure) {
          return Center(
            child: Text(
              state.errormessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        return Container();
      }),
    );
  }
}

class DeleteIconButton extends StatelessWidget {
  final FavItemModel favItem;

  const DeleteIconButton({super.key, required this.favItem});

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();

    return IconButton(
      icon: const Icon(
        Icons.delete,
        size: 28,
        color: Colors.white,
      ),
      onPressed: () {
        favouriteCubit.removeFavorite(favItem);
      },
    );
  }
}

class MoviesListItem extends StatelessWidget {
  const MoviesListItem({
    super.key,
    required this.favitem,
  });
  final FavItemModel favitem;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 5, left: 5, bottom: 5, top: 5),
        width: double.infinity,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey.withOpacity(0.2), width: 0.45)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage('$baseimageurl${favitem.ImageUrl}'),
                fit: BoxFit.cover,
              ),
            ),
            height: 122,
            width: 89,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              favitem.Title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DeleteIconButton(favItem: favitem)
        ]));
  }
}
