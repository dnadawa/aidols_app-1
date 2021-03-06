import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aidols_app/models/post_model.dart';
import 'package:aidols_app/models/user_model.dart';
import 'package:aidols_app/utilities/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static void createPost(Post post) {
    postsRef.add({
      'imageUrl': post.imageUrl,
      'videoUrl':post.videoUrl,
      'caption': post.caption,
      'likes_count': post.likes_count,
      'liked_users': post.liked_users,
      'authorID': post.authorId,
      'author': post.authorName,
      'com_count': post.com_count,
      'timestamp': post.timestamp,
    });
  }
}
