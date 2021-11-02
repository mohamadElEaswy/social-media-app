import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:untitled/core/routes/constant_route_functions.dart';
import 'package:untitled/ui/screens/chat_details/chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            builder: (context)=> ListView.separated(
                itemBuilder: (context, index) => BuildUserChatItem(cubit: cubit,index: index,),
                separatorBuilder: (context, index)=>const SizedBox(height: 10.0),
                itemCount: cubit.users.length,
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class BuildUserChatItem extends StatelessWidget {
  const BuildUserChatItem({Key? key, required this.cubit, required this.index}) : super(key: key);
final AuthCubit cubit;
final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          navigate(context: context, namedRoute:
        ChatDetailsScreen.routeName,arguments: cubit.users[index],);},
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(cubit.users[index].image),
            ),
            const SizedBox(width: 15.0),
            Text(
              cubit.users[index].name,
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
