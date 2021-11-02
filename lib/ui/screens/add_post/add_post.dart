import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);
  static const String routeName = '/addPost';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        final TextEditingController textController = TextEditingController();
        var now = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (!cubit.postImageExist) {
                      cubit.createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      cubit.uploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  child: const Text('POST')),
              const SizedBox(width: 5.0)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoading) const LinearProgressIndicator(),
                const SizedBox(width: 15.0),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'),
                    ),
                    SizedBox(width: 15.0),
                    Text('Abdullah Mansour'),
                  ],
                ),
                const SizedBox(height: 15.0),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind',
                        border: InputBorder.none),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {cubit.getPostImage();},
                            child: const Text('UPLOAD PHOTO'))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('# tags'))),
                  ],
                ),
                const SizedBox(height: 20.0),
                if (cubit.postImageExist)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  cubit.removeImage();
                                },
                                icon: const Icon(Icons.close))),
                      ),
                    ],
                  ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
