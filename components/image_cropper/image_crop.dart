// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'data/crop_controller.dart';
import 'data/crop_image.dart';

class ProfileCrop extends StatefulWidget {
  final File file;
  final String title;
  final double aspectRatio;

  const ProfileCrop(
      {Key? key,
      required this.file,
      this.title = 'Image Cropper',
      this.aspectRatio = 1})
      : super(key: key);

  @override
  _ProfileCropState createState() => _ProfileCropState();
}

class _ProfileCropState extends State<ProfileCrop> {
  late CropController controller;
  bool isProgress = false;

  @override
  void initState() {
    controller = CropController(
      defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          useMaterial3: true,
        ),
        child: Scaffold(
          backgroundColor: Colors.grey.shade700,
          appBar: AppBar(
            centerTitle: true,
            // ignore: prefer_const_constructors
            leading: BackButton(
              onPressed: isProgress ? null : (() => Navigator.pop(context)),
            ),

            title: Text(widget.title),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: CropImage(
                  controller: controller,
                  image: kIsWeb
                      ? Image.network(widget.file.path)
                      : Image.file(widget.file)),
            ),
          ),
          bottomNavigationBar: _buildButtons(),
        ),
      );

  Widget _buildButtons() => Container(
        height: MediaQuery.of(context).size.height / 13,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(null);
                },
                child: const Text('Cancel',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              OutlinedButton(
                onPressed: isProgress
                    ? null
                    : () async {
                        finalImageConvert().then((value) {
                          Get.back(result: value);
                        });
                      },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      isProgress ? Colors.grey : const Color(0xff7F5B8E),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );

  Future<dynamic> finalImageConvert() async {
    isProgress = true;
    print("entry1");

    setState(() {});
    final image = await controller.croppedImage();
    print("entry2");

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    var resultByte = await FlutterImageCompress.compressWithList(
      pngBytes,
      quality: 30,
    );
    print("entry4");

    File file;

    if (kIsWeb) {
      return resultByte;
    } else {
      final directory = (await getApplicationDocumentsDirectory());

      File imgFile = File(
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      final result = await imgFile.writeAsBytes(resultByte);
      file = result;
      return file;
    }
  }
}
