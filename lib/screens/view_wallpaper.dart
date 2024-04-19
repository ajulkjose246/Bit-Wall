import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';

class ViewWallpaperScreen extends StatefulWidget {
  final String wallpaperImage;
  const ViewWallpaperScreen({super.key, required this.wallpaperImage});

  @override
  State<ViewWallpaperScreen> createState() => _ViewWallpaperScreenState();
}

class _ViewWallpaperScreenState extends State<ViewWallpaperScreen> {
  static const platform = MethodChannel("com.flutter.epic/epic");

  bool isWallpapersetting = false;

  _save() async {
    bool status;

    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      var permissionStatus = await Permission.photos.request();
      status = permissionStatus.isGranted;
    } else {
      var permissionStatus = await Permission.storage.request();
      status = permissionStatus.isGranted;
    }

    if (status) {
      var response = await Dio().get(widget.wallpaperImage,
          options: Options(responseType: ResponseType.bytes));

      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      return result;
    } else {
      // Handle denied or restricted status
      if (status == false) {
        // Inform the user to grant the permission
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Storage Permission Required'),
            content: const Text(
                'Please grant storage permission to save the wallpaper.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
        // ignore: unnecessary_null_comparison
      } else if (status == null) {
        openAppSettings();
      }
    }
  }

  // function to save the image in local/ temp memory
  Future _download(var type) async {
    isWallpapersetting = true;
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();
      await dio.download(widget.wallpaperImage, "${dir.path}/wallpix.jpeg",
          onReceiveProgress: (rec, total) {
        // ignore: prefer_typing_uninitialized_variables
        var progress;
        setState(() {
          progress = (rec / total) * 100;
          if (progress < 0) {
            Fluttertoast.showToast(
                    msg:
                        "It seems like there was an issue. Please use the download option and set the wallpaper from the gallery")
                .then((value) => Future.delayed(const Duration(seconds: 5), () {
                      Restart.restartApp(webOrigin: '/');
                    }));
          }
          // ignore: avoid_print
          print(progress);
        });
        if (progress == 100) _setWallpaper(type);
      });
    } catch (_) {}
  }

  Future _setWallpaper(var type) async {
    try {
      await platform.invokeMethod("setWall", "wallpix.jpeg $type");
      setState(() {
        // ignore: avoid_print
        isWallpapersetting = false;
        print("Wallpaper Set Sucessfully");
        Fluttertoast.showToast(
          msg: "Applying",
        );
      });
    } on PlatformException catch (_) {
      setState(() {
        // ignore: avoid_print
        print("Failed to Set Wallpaper");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              widget.wallpaperImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            // width: width,
            left: 20,
            right: 20,
            bottom: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            isWallpapersetting = true;
                            // ignore: avoid_print
                            print("object");
                            var datas = await _save();
                            if (datas['isSuccess']) {
                              isWallpapersetting = false;
                              Fluttertoast.showToast(
                                  msg: "Wallpaper Saved Successfully");
                            }
                            // ignore: avoid_print
                            print(datas);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.download_sharp,
                                color: Colors.white,
                                size: width * 0.04,
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "Download",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.03),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            final result = await showConfirmationDialog<int>(
                              context: context,
                              title: 'Apply',
                              actions: [
                                AlertDialogAction(
                                  label: 'Set Home Screen',
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  key: 1,
                                ),
                                AlertDialogAction(
                                  label: 'Set Lock Screen',
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  key: 2,
                                ),
                                AlertDialogAction(
                                  label: 'Set Both',
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  key: 3,
                                ),
                              ],
                              builder: (context, child) => Theme(
                                data: ThemeData(
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        disabledForegroundColor:
                                            Theme.of(context)
                                                .colorScheme
                                                .inversePrimary),
                                  ),
                                  cupertinoOverrideTheme:
                                      const CupertinoThemeData(
                                    primaryColor: Colors.purple,
                                  ),
                                  dialogBackgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  textTheme: TextTheme(
                                    titleLarge: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ),
                                ),
                                child: child,
                              ),
                            );
                            if (result == 1) {
                              _download("home");
                            } else if (result == 2) {
                              _download("lock");
                            } else if (result == 3) {
                              _download("both");
                            }
                            // ignore: avoid_print
                            print(result);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.download_done_outlined,
                                color: Colors.white,
                                size: width * 0.04,
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.03),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: width * 0.04,
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                "Favorite",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.03),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          isWallpapersetting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
