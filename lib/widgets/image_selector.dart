import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proto/constants.dart';
import 'package:proto/main.dart';

Future<File?> pickImg() async {
  String txt = "";
  try {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        return croppedFile;
      }
    } else {
      txt = "You didn't pick an image please try again";
      imageErrorSnack(txt);
      return null;
    }
  } catch (err) {
    txt = "Seems you denied us some permissions";
    imageErrorSnack(txt);
    return null;
  }
}

Future<String?> uploadProductImage(File img) async {
  String txt = "";
  try {
    var url = Uri.parse(Constants.IMAGES_UPLOAD_SERVER);
    var request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile(
      'file',
      img.readAsBytes().asStream(),
      img.lengthSync(),
      filename: img.path.split("/").last,
    ));
    request.fields["productID"] = "1";

    var res = await request.send();
    final hresponse = await http.Response.fromStream(res);
    final myjson = await json.decode(hresponse.body);

    if (myjson["url"] != null) {
      return myjson["url"];
    }
  } catch (err) {
    if (err == SocketException) {
      txt = "They was issue connectiong to the internet.";
      imageErrorSnack(txt);
    } else {
      txt = err.toString();
      imageErrorSnack(txt);
    }
    return null;
  }
}

imageErrorSnack(String message) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
