// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:image_picker/image_picker.dart';
import '../../core/Util/permissions.dart';
import '../../UI/ActionSheet/main.dart';
import '../../UI/Dialog/main.dart';

ImageSource? getType(String type) {
  switch (type) {
    case "gallery":
      return ImageSource.gallery;
    case "camera":
      return ImageSource.camera;
    default:
      return null;
  }
}

class PhotoPicker {
  PhotoPicker(BuildContext context);
  static BuildContext? self;

  static PhotoPicker of(context) {
    self = context;
    return PhotoPicker(context);
  }

  void select(Function(List<XFile>? list) fun) {
    ActionSheet.of(self).show(items: [
      "选择照片",
      "拍摄照片"
    ], actions: [
      () => _select("gallery", fun),
      () => _select("camera", fun),
    ]);
  }

  void _select(String source, Function(List<XFile>?) fun,
      [Function(Object?)? err]) async {
    // 选择照片
    if (source == "gallery") {
      bool hasPermission = await Permissions.request("photos");
      if (hasPermission) {
        final ImagePicker _picker = ImagePicker();
        try {
          final pickedFileList = await _picker.pickMultiImage(
            maxWidth: null,
            maxHeight: null,
            imageQuality: null,
          );
          fun(pickedFileList);
        } catch (error) {
          print(" ================== PhotoPicker Error ================== ");
          print(error);
          print(" ================== PhotoPicker Error ================== ");
        }
      }
    }
    // 拍摄照片
    else if (source == "camera") {
      bool hasPermission = await Permissions.request("camera");
      // 如果有权限则可以继续操作
      if (hasPermission) {
        final ImagePicker _picker = ImagePicker();
        try {
          final pickedFile = await _picker.pickImage(
            source: getType(source)!,
            maxWidth: null,
            maxHeight: null,
            imageQuality: null,
          );
          if (pickedFile != null) fun([pickedFile]);
        } catch (error) {
          print(
              " ================== PhotoFromCameraPicker Error ================== ");
          print(error);
          if (err != null) err(error);
          print(
              " ================== PhotoFromCameraPicker Error ================== ");
        }
      }
      // 否则提示用户去开启权限
      else {
        Dialog.of(self).choose("权限请求", "请开启照相机权限以继续操作",
            btns: ["稍后", "去设置"], funs: [null, () => openAppSettings()]);
      }
    }
  }
}
