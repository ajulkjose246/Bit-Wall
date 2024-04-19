import 'package:bit_wall/providers/favorite_provider.dart';
import 'package:bit_wall/screens/view_wallpaper.dart';
import 'package:bit_wall/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  final String? searchText;
  const FavoriteScreen({super.key, this.searchText});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FireStoreService fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = Provider.of<FavoriteNotifier>(context);
    List<String> favoriteItems = favoriteNotifier.favoriteItems;
    return Container(
      height: 1400,
      color: Theme.of(context).colorScheme.background,
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getWallpapers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List wallpapersList = snapshot.data!.docs;

            // Filter wallpapersList to only include favorite items
            wallpapersList
                .retainWhere((document) => favoriteItems.contains(document.id));

            // Display
            return MasonryGridView.builder(
              itemCount: wallpapersList.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                // get each document
                DocumentSnapshot document = wallpapersList[index];
                String docImage = document['image'];
                String docID = document.id;
                if (widget.searchText!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewWallpaperScreen(
                              wallpaperImage: docImage,
                              wallpaperId: docID,
                            ),
                          ));
                        },
                        child: Image.network(
                          docImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                  );
                }
                if (document['categorys']
                    .toString()
                    .toLowerCase()
                    .contains(widget.searchText!.toLowerCase())) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewWallpaperScreen(
                              wallpaperImage: docImage,
                              wallpaperId: docID,
                            ),
                          ));
                        },
                        child: Image.network(
                          docImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          } else {
            //no data
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
