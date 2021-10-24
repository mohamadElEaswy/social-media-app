import 'package:flutter/material.dart';
import 'package:untitled/ui/widgets/default_text_form_field.dart';
final TextEditingController nameController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName= '/login';


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(key: formKey,
            child: Column(
              children: [
                DefaultTextFormField(
                  onFieldSubmitted: (String? value){},
                  validator: (String? value){},
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.person,
                  hintText: 'user email',
                ),
                const SizedBox(height: 10.0,),
                DefaultTextFormField(
                  onFieldSubmitted: (String? value){},
                  validator: (String? value){},
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.mail,
                  suffixIcon: Icons.password,
                  hintText: 'email address',suffixOnPressed: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
