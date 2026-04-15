import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:week8/ui/common/ui_helpers.dart';
import 'package:week8/ui/views/login/login_view.form.dart';
import 'login_viewmodel.dart';
import 'package:week8/core/utils/validators.dart';

@FormView(fields: [
  FormTextField(
    name: 'username',
    validator: Validator.name,
  ),
  FormTextField(
    name: 'password',
    validator: Validator.password,
  ),
  FormTextField(
    name: 'email',
    validator: Validator.email,
  ),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.login,
        child: const Icon(Icons.login),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceLarge,

              const Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              verticalSpaceMedium,

              // Username
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              if (viewModel.hasUsernameValidationMessage)
                Text(
                  viewModel.usernameValidationMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              verticalSpaceMedium,

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              if (viewModel.hasPasswordValidationMessage)
                Text(
                  viewModel.passwordValidationMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              verticalSpaceMedium,

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              if (viewModel.hasEmailValidationMessage)
                Text(
                  viewModel.emailValidationMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onDispose(LoginViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
