import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/generalWidgetForME/password_field.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/login&regestr/login/biometric.dart';
import 'package:plasess/screens/login&regestr/reset_passowrd/provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // wave and logo
          Stack(
            children: [
              Transform.flip(
                flipY: true,
                child: Generalwidget().getWavesWidget(context),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: double.infinity,
                    height: 100,
                  ),
                ),
              ),
              //CircularProgressIndicator
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.black45,
                    strokeWidth: 4.0,
                  ),
                )
              else
                SizedBox.shrink(),
            ],
          ),

          Center(
            child: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.onSurface,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Form(
                key: globalKey,
                child: ListView(
                  children: [
                    // email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                      child: Generalwidget().getTextFormField(
                        context,
                        AppLocalizations.of(context)!.email,
                        controller: emailControler,
                      ),
                    ),

                    // password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 1),
                      child: PasswordField(
                        controller: passwordController,
                        label: AppLocalizations.of(context)!.password,
                      ),
                    ),

                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.forgotpassword),
                        TextButton(
                          onPressed: () {
                            if (emailControler.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter your email",
                                backgroundColor: Colors.red,
                              );
                            } else {
                              ref.read(emailProvider.notifier).state =
                                  emailControler.text;

                              AppRouter.pushNamed(Routes.reset);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.clickhere_en,
                          ),
                        ),
                      ],
                    ),

                    // login button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Generalwidget().getElevatedButton(
                        context,
                        'login',
                        () async {
                          if (globalKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: emailControler.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                              Future.delayed(const Duration(seconds: 2), () {
                                // getBiometric();
                                AppRouter.pushNamed(Routes.home);
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                log('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                log('Wrong password provided for that user.');
                              }

                              Fluttertoast.showToast(
                                msg: e.message ?? "Login failed",
                                backgroundColor: Colors.red,
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),

                    // register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.daccount),
                        TextButton(
                          onPressed: () {
                            AppRouter.pushNamed(Routes.regester);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.registration,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
