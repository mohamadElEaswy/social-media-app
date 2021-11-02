import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/config/theme/constant_colors.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_cubit.dart';
import 'package:untitled/core/blocs/auth_bloc/auth_states.dart';
import 'package:untitled/core/models/message_model.dart';

final TextEditingController messagesController = TextEditingController();

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.userModel})
      : super(key: key);
  static const String routeName = '/chatDetails';
  final dynamic userModel;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AuthCubit.get(context).getMessages(receiverId: userModel.uId!);
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            DateTime dateTime = DateTime.now();
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    const SizedBox(width: 15.0),
                    Text(userModel.name)
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10.0),
                          itemBuilder: (context, index) {
                            if (cubit.userModel.uId ==
                                cubit.messages[index].senderId) {
                              return ReceivedMessages(
                                message: cubit.messages[index],
                              );
                            }
                            // (cubit.userModel.uId !=
                            //     cubit.messages[index].receiverId)
                            {
                              return MyMessage(
                                message: cubit.messages[index],
                              );
                            }
                          },
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messagesController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here....'),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.sendMessage(
                                  text: messagesController.text,
                                  receiverId: userModel.uId,
                                  dateTime: dateTime.toString(),
                                );
                                messagesController.text = '';
                              },
                              child: const Text('SEND'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ReceivedMessages extends StatelessWidget {
  const ReceivedMessages({Key? key, required this.message}) : super(key: key);
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            )),
        child: Text(message.text),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({Key? key, required this.message}) : super(key: key);
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            )),
        child: Text(message.text),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
      ),
    );
  }
}
