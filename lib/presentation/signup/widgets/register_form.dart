import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/auth/signup_bloc/signupform_bloc.dart';
import 'package:improsso/core/validators/signup_validators.dart';
import 'package:improsso/domain/auth_domain/failures/auth_failures.dart';
import 'package:improsso/presentation/signup/widgets/login_register_button.dart';
import 'package:improsso/routes/router.gr.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final themeData = Theme.of(context);

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case EmailAlreadyInUseFailure:
          return "email already in use ";
        case InvalidEmailAndPasswordCombinationFailure:
          return "invalid email and password combination";
        default:
          return "something went wrong";
      }
    }

    return BlocConsumer<SignupformBloc, SignupformState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    mapFailureMessage(failure),
                    style: themeData.textTheme.bodyText1,
                  )));
            },
            (_) {
              //! DURATION KÖNNTE GANZ GANZ KRITISCH WERDEN FALLS INTERNET NICHT MITMACHT BEI REGISTRIERUNG
              Future.delayed(Duration(seconds: 4)).then((value) {
                AutoRouter.of(context).replace(const RootWidgetRoute());
              });
            },
          ),
        );
      },
      builder: (context, state) {
        // TODO: dependency injection anwenden
        SignUpValidators formValidators = SignUpValidators();
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 80),
              Text(
                "Study Progress App",
                style: themeData.textTheme.bodyText2!.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                    color: themeData.colorScheme.onPrimary),
              ),
              const SizedBox(height: 60),
              Text(
                "Please register if you don't have an existing account",
                style: themeData.textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 3,
                    color: themeData.colorScheme.onPrimary),
              ),
              const SizedBox(height: 40),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined,
                        color: themeData.colorScheme.primary),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 3,
                          color: themeData.colorScheme.primary,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: themeData.colorScheme.primary)),
                    labelText: "E-Mail",
                    labelStyle: TextStyle(color: themeData.colorScheme.primary),
                    fillColor: themeData.colorScheme.onPrimary,
                    filled: true),
                cursorColor: themeData.colorScheme.primary,
                validator: formValidators.validate_email,
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_pin_circle_outlined,
                        color: themeData.colorScheme.primary),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 3,
                          color: themeData.colorScheme.primary,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: themeData.colorScheme.onPrimary)),
                    labelText: "Username",
                    labelStyle: TextStyle(color: themeData.colorScheme.primary),
                    fillColor: themeData.colorScheme.onPrimary,
                    filled: true),
                cursorColor: themeData.colorScheme.primary,
                validator: formValidators.validate_username,
              ),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                style: TextStyle(color: themeData.colorScheme.primary),
                obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.password_outlined,
                      color: themeData.colorScheme.primary,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 3,
                          color: themeData.colorScheme.primary,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 2, color: themeData.colorScheme.primary)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: themeData.colorScheme.primary),
                    fillColor: themeData.colorScheme.onPrimary,
                    filled: true),
                cursorColor: themeData.colorScheme.primary,
                validator: formValidators.validate_password,
              ),
              const SizedBox(height: 20),
              LoginRegisterButton(
                buttonText: "Register",
                callback: () async {
                  if (formKey.currentState!.validate() & !state.isSubmitting) {
                    bool blockRegisterButton = false;
                    state.authFailureOrSuccessOption.fold(
                      () => {},
                      (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                        (failure) {},
                        (_) {
                          blockRegisterButton = true;
                        },
                      ),
                    );
                    if (!blockRegisterButton) {
                      BlocProvider.of<SignupformBloc>(context).add(
                          RegisterWithEmailAndUsernameAndPasswordPressed(
                              email: formValidators.email,
                              username: formValidators.username,
                              password: formValidators.password));
                    }
                  } else {
                    BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndUsernameAndPasswordPressed(
                            email: null, username: null, password: null));
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  TextSpan(
                    text: "Already have an existing account? Just ",
                    style: themeData.textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                        color: themeData.colorScheme.onPrimary),
                  ),
                  TextSpan(
                      text: "log in!",
                      style: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                          color: themeData.colorScheme.onPrimary,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          AutoRouter.of(context)
                              .replace(const LoginPageRoute());
                        }),
                ]),
              ),
              if (state.isSubmitting) ...[
                SizedBox(height: 10),
                LinearProgressIndicator(color: themeData.bottomAppBarColor)
              ],
            ],
          ),
        );
      },
    );
  }
}
