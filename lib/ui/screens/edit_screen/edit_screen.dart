import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/config/theme/icon_broken.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/ui/widgets/default_text_form_field.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        final TextEditingController nameController = TextEditingController();
        // TextEditingController emailController = TextEditingController();
        final TextEditingController phoneController = TextEditingController();
        final TextEditingController bioController = TextEditingController();

        nameController.text = cubit.userModel.name;
        bioController.text = cubit.userModel.bio;
        phoneController.text = cubit.userModel.phone;
        // emailController.text = cubit.model.email;
        return Scaffold(
          appBar: AppBar(
            title: const Text('edit your profile information'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (cubit.cover) {
                      cubit.uploadCoverImage(
                        name: nameController.text,
                        // email: cubit.model.email,
                        phone: phoneController.text,
                        bio: bioController.text,
                        // uId: cubit.model.uId.toString(),
                        // coverImageUrl: cubit.model.cover,
                        // profileImageUrl: cubit.model.cover,
                      );
                    }
                    if (cubit.image) {
                      cubit.uploadPhotoImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    }
                  },
                  child: const Text('UPDATE')),
              const SizedBox(width: 10.0)
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is UploadLodingState) const LinearProgressIndicator(),
                SizedBox(
                  height: 220.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            (!cubit.cover)
                                ? Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: 180,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                cubit.userModel.cover),
                                            fit: BoxFit.cover),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0))),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: 180,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(cubit.coverImage),
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
                                        cubit.getCoverImage();
                                      },
                                      icon: const Icon(IconBroken.Camera))),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 63.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: !cubit.image
                                ? CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage:
                                        NetworkImage(cubit.userModel.image),
                                  )
                                : CircleAvatar(
                                    radius: 55.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Image(
                                      image: FileImage(cubit.profileImage),
                                    ),
                                  ),
                          ),
                          CircleAvatar(
                              child: IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const Icon(IconBroken.Camera))),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                DefaultTextFormField(
                  obscureText: false,
                  onFieldSubmitted: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '*your name is required please enter your name';
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  prefixIcon: IconBroken.User,
                  hintText: 'user name',
                ),
                const SizedBox(height: 10.0),
                DefaultTextFormField(
                  obscureText: false,
                  onFieldSubmitted: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '*bio is required please enter your bio';
                    }
                  },
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  prefixIcon: IconBroken.Info_Circle,
                  hintText: 'bio',
                ),
                const SizedBox(height: 10.0),
                DefaultTextFormField(
                  obscureText: false,
                  onFieldSubmitted: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '*phone is required please enter your phone';
                    }
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: IconBroken.Call,
                  hintText: 'phone',
                ),
                const SizedBox(height: 10.0),
                // DefaultTextFormField(
                //   obscureText: false,
                //   onFieldSubmitted: (String? value) {},
                //   validator: (String? value) {
                //     if (value!.isEmpty) {
                //       return '*phone is required please enter your phone';
                //     }
                //   },
                //   controller: emailController,
                //   keyboardType: TextInputType.emailAddress,
                //   prefixIcon: IconBroken.Bag_2,
                //   hintText: 'email',
                // ),
                // const SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
