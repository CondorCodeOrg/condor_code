import 'dart:io';

import 'package:condor_code/di/provider_manager.dart';
import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  String? _avatarFilePath;

  //TODO Get from cubit -> repository -> sharedPreferencesManager
  SharedPreferencesManager sharedPreferencesManager =
      di<SharedPreferencesManager>();

  @override
  void initState() {
    sharedPreferencesManager.getUserAvatarFilePath().then((path) {
      if (path != null) {
        File(path).exists().then((isFileExist) {
          if (isFileExist) {
            setState(() {
              _avatarFilePath = path;
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              child: _avatarFilePath != null
                  ? CircleAvatar(
                      radius: 55,
                      backgroundImage: FileImage(File(_avatarFilePath!)),
                    )
                  : const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(
                        'assets/images/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                      ),
                    ),
              onTap: () async {
                final XFile? file = await _uploadImage();
                if (file != null) {
                  _cropImage(file);
                }
              },
            ),
          ),
          const SizedBox(height: 10.0),
          const Text('Change picture', style: AppTextStyles.body2),
        ],
      ),
    ),
  );

  Future<void> _cropImage(XFile pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        WebUiSettings(context: context, presentStyle: WebPresentStyle.dialog),
      ],
    );
    if (croppedFile != null) {
      await sharedPreferencesManager.saveUserAvatarFilePath(croppedFile.path);
      _deleteOldAvatar();
      setState(() {
        _avatarFilePath = croppedFile.path;
      });
    }
  }

  Future<XFile?> _uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }

  void _deleteOldAvatar() {
    if (_avatarFilePath != null) {
      final File oldFile = File(_avatarFilePath!);
      oldFile.delete();
    }
  }
}
