import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/config/theme/icon_broken.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/ui/widgets/default_text_form_field.dart';

TextEditingController nameController = TextEditingController();
TextEditingController bioController = TextEditingController();

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        // var imageCubit = AuthCubit.get(context).profileImage;
        nameController.text = cubit.model.name;
        bioController.text = cubit.model.bio;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              height: 180,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(cubit.model.cover),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0))),
                            ),
                            CircleAvatar(
                                child: IconButton(
                                    onPressed: () {

                                    },
                                    icon: const Icon(IconBroken.Camera))),
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
                            child:


                            !cubit.image ? CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(cubit.model.image),
                            )
                            : CircleAvatar(
                              child: Image(image: FileImage(cubit.profileImage!),),
                            )


                            ,
                          ),
                          CircleAvatar(
                              child: IconButton(
                                  onPressed: () {cubit.getProfileImage();},
                                  icon: const Icon(IconBroken.Camera))),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                  prefixIcon: Icons.person,
                  hintText: 'user name',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DefaultTextFormField(
                  obscureText: false,
                  onFieldSubmitted: (String? value) {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '*bio name is required please enter your bio';
                    }
                  },
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.remove_from_queue_sharp,
                  hintText: 'bio',
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
