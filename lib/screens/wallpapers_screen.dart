import 'package:bit_wall/screens/view_wallpaper.dart';
import 'package:bit_wall/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WallpapersScreen extends StatefulWidget {
  final String? searchText;
  const WallpapersScreen({super.key, this.searchText});

  @override
  State<WallpapersScreen> createState() => _WallpapersScreenState();
}

class _WallpapersScreenState extends State<WallpapersScreen> {
  final FireStoreService fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    print("Screen 2${widget.searchText}");
    return Container(
      height: 1400,
      color: Theme.of(context).colorScheme.background,
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getWallpapers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List wallpapersList = snapshot.data!.docs;
            // Display
            return MasonryGridView.builder(
              itemCount: wallpapersList.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                // get each document
                DocumentSnapshot document = wallpapersList[index];
                // String docID = document.id;
                // get data from each deocument
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String docImage = data['image'];
                if (widget.searchText!.isEmpty) {
                  // display all data
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ViewWallpaperScreen(wallpaperImage: docImage),
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
                if (data['categorys']
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
                            builder: (context) =>
                                ViewWallpaperScreen(wallpaperImage: docImage),
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
