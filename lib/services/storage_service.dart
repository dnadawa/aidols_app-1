import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:aidols_app/utilities/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);

    if (url.isNotEmpty) {
      // Updating user profile image
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
    }

    StorageUploadTask uploadTask = storageRef
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static Future uploadPost(File imageFile) async {
//    String photoId = Uuid().v4();
//    File image = await compressImage(photoId, imageFile);
//    StorageUploadTask uploadTask = storageRef
//        .child('images/posts/post_$photoId.jpg')
//        .putFile(image);
//    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
//    String downloadUrl = await storageSnap.ref.getDownloadURL();
//    return downloadUrl;

    try{
      String photoId = Uuid().v4();
      StorageReference ref = FirebaseStorage.instance.ref().child('images/posts/post_$photoId.jpg');
      StorageUploadTask uploadTask = ref.putFile(imageFile);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      String fileUrl = (await downloadUrl.ref.getDownloadURL());
      print("url is $fileUrl");
      return fileUrl;
    }
    catch(e){
      print(e);
    }





  }

}
