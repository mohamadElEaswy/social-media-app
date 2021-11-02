// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/config/theme/icon_broken.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/data/end_points.dart';
import 'package:untitled/core/data/local/cache_helper.dart';
import 'package:untitled/core/data/local/constant_uid.dart';
import 'package:untitled/core/models/message_model.dart';
import 'package:untitled/core/models/post_model.dart';
import 'package:untitled/core/models/user_model.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
import 'package:untitled/ui/screens/add_post/add_post.dart';
import 'package:untitled/ui/screens/chat_screen/chat_screen.dart';
import 'package:untitled/ui/screens/home_screen/home_screen.dart';
import 'package:untitled/ui/screens/setting_screen/setting_screen.dart';
import 'package:untitled/ui/screens/users_screen/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// management to login and register
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitState());
  static AuthCubit get(context) => BlocProvider.of(context);

  //change password visibility
  // Login & register
  bool obscureText = true;
  void obscurePassword() {
    obscureText = !obscureText;
    emit(ChangePasswordVisibility());
  }

  // get user data in the app start if token exists inside sharedPreferences
  void checkData() {
    if (userId!.isNotEmpty) {
      getUserData();
    }
  }

  //register method in fire base
  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone,
      String? image,
      String? bio,
      required BuildContext context,
      required String namedRoute}) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        email: email,
        phone: phone,
        name: name,
      );
      navigateAndRemove(context: context, namedRoute: namedRoute);
      emit(SuccessRegisterState());
    }).catchError((e) {
      emit(ErrorRegisterState(error: e.toString()));
    });
  }

  late UserModel userModel;
  // register new user data in the fire cloud
  void userCreate(
      {required String name,
      required String phone,
      required String email,
      required String uId}) {
    emit(LoadingCreateUser());
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image: imgUrl,
        bio: 'bio');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) async {
      userId = await CacheHelper.saveData(key: 'uId', value: uId);
      getUserData();
      emit(SuccessCreateUser(userModel: model));
    }).catchError((e) {
      emit(ErrorCreateUser(error: e.toString()));
    });
  }

// login method
  void userLogin(
      {required String email,
      required String password,
      required BuildContext context,
      required String namedRoute}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      userId = value.user!.uid;
      getUserData();
      navigateAndRemove(context: context, namedRoute: namedRoute);
      emit(LoginSuccessState(userName: value.user!.displayName));
    }).catchError((e) {
      print(e.toString());
      emit(LoginErrorState(error: e.toString()));
    });
  }

  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());

      emit(GetUserSuccessState(model: userModel));
    }).catchError((e) {
      emit(GetUserErrorState(error: e.toString()));
    });
  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Location,
      ),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = const [
    HomeContent(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNav());
    }
  }

//choose the profile image from your phone
  bool image = false;
  bool cover = false;
  late File profileImage;
  late File coverImage;
  final ImagePicker picker = ImagePicker();
  Future<void> getProfileImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      image = true;
      emit(ProfileImagePickedSuccessState());
    } else {
      image = false;
      print('error no image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

//choose the cover image from your phone
  Future<void> getCoverImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      cover = true;
      emit(CoverImagePickedSuccessState());
    } else {
      cover = false;
      print('error no image selected');
      emit(CoverImagePickedErrorState());
    }
  }

//upload profile photo into firebase storage
  void uploadPhotoImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
            phone: phone,
            name: name,
            bio: bio,
            profileImage: value,
            cover: userModel.cover);
        emit(ProfileImageUploadedSuccessState());
      }).catchError((e) {
        emit(ProfileImageUploadedErrorState());
      });
    }).catchError((e) {
      emit(ProfileImageUploadedErrorState());
    });
  }
//upload cover photo into firebase storage

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
            phone: phone,
            name: name,
            bio: bio,
            cover: value,
            profileImage: userModel.image);
        emit(CoverImageUploadedSuccessState());
      }).catchError((e) {
        emit(CoverImageUploadedErrorState());
      });
    }).catchError((e) {
      emit(CoverImageUploadedErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profileImage,
  }) {
    emit(UploadLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel.email,
      phone: phone,
      bio: bio,
      cover: cover ?? userModel.cover,
      image: profileImage ?? userModel.image,
      uId: userModel.uId,
    );
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      print(e.toString());
      emit(UploadErrorState());
    });
  }

  void removeImage() {
    postImage = null;
    postImageExist = false;
    emit(RemovePostImageState());
  }

  bool postImageExist = false;
  late File? postImage;
  Future<void> getPostImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      postImageExist = true;
      emit(PostImagePickedSuccessState());
    } else {
      postImageExist = false;
      print('error no image selected');
      emit(PostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        emit(CreatePostSuccess());
      }).catchError((e) {
        emit(CreatePostError());
      });
    }).catchError((e) {
      emit(CreatePostError());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
        name: userModel.name,
        uId: userModel.uId,
        image: userModel.image,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '');
    FirebaseFirestore.instance.collection('posts').add(model.toMap())
        // .doc('1')
        // .set(model.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((e) {
      emit(CreatePostError());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  void getPosts() {
    emit(GetPostLoading());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
        }).catchError((e) {});
      });
      emit(GetPostSuccess());
    }).catchError((e) {
      emit(GetPostError());
    });
  }

  void postsLike({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(LikeAdded());
    }).catchError((e) {});
  }

  void postLikeRemove({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': false}).then((value) {
      emit(LikeRemoved());
    }).catchError((e) {});
  }

  List<UserModel> users = [];
  void getUsers() {
    emit(GetUserLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetUsersSuccess());
    }).catchError((e) {
      emit(GetUsersError());
    });
  }

  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      senderId: userId!,
      dateTime: dateTime,
    );

    //sender chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((e) {
      emit(SendMessageError());
    });
    //receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((e) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }
}

