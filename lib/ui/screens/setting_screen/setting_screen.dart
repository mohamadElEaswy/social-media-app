import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SingleChildScrollView(
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
                      child: Container(
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
                    ),
                    CircleAvatar(
                      radius: 63.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(cubit.model.image),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(cubit.model.name, style: Theme.of(context).textTheme.headline6,),
              Text(cubit.model.bio,  style: Theme.of(context).textTheme.caption,),
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: const [
                          Text('150'),
                          Text('posts'),
                        ],
                      ),
                    ),
                  ),Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: const [
                          Text('170'),
                          Text('photo'),
                        ],
                      ),
                    ),
                  ),Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: const [
                          Text('101k'),
                          Text('follower'),
                        ],
                      ),
                    ),
                  ),Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: const [
                          Text('0'),
                          Text('follow'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: (){},child: const Text('add photo'),),),
                  const SizedBox(width: 5),
                  SizedBox(child: OutlinedButton(onPressed: (){},child: const Icon(Icons.edit),),),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
