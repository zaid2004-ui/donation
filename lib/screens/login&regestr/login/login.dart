import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/core/generalWidgetForME/password_field.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/core/router/app_route.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/screens/login&regestr/login/biometric.dart';
import 'package:plasess/screens/login&regestr/reset_passowrd/provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  // controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  bool isLoading = false;
  //dispose controllers
  @override
  void dispose() {
    passwordController.dispose();
    emailControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // wave and logo
            Stack(
              children: [
                // wave
                Transform.flip(
                  flipY: true,
                  child: GeneralWidget().getWavesWidget(context),
                ),
                //logo
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
              ],
            ),

            if (isLoading)
              //CircularProgressIndicator
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 4.0,
                ),
              )
            else
              SizedBox.shrink(),
            //login text
            Center(
              child: Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // form
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),

                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: Form(
                    key: globalKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          // email
                          GeneralWidget().getTextFormField(
                            context,
                            AppLocalizations.of(context)!.email,
                            controller: emailControler,
                          ),
                          const SizedBox(height: 20),

                          // password
                          PasswordField(
                            controller: passwordController,
                            label: AppLocalizations.of(context)!.password,
                          ),

                          // forgot password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.forgotpassword,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (emailControler.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: AppLocalizations.of(
                                        context,
                                      )!.enter_email,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.error,
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
                          SizedBox(
                            width: double.infinity,
                            child: GeneralWidget().getElevatedButton(
                              context,
                              AppLocalizations.of(context)!.login,
                              () async {
                                if (globalKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                          email: emailControler.text.trim(),
                                          password: passwordController.text
                                              .trim(),
                                        );
                                    //reload user to get the latest email verification status
                                    await FirebaseAuth.instance.currentUser!
                                        .reload();
                                    // get the current user
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (!context.mounted) return;
                                    // check if the email is verified
                                    if (!user!.emailVerified) {
                                      GeneralWidget().showErrorMessage(
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.verify_email_before_login,
                                      );
                                      return;
                                    }
                                    getBiometric();
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      GeneralWidget().showErrorMessage(
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.no_user_found_email,
                                      );
                                    } else if (e.code == 'wrong-password') {
                                      GeneralWidget().showErrorMessage(
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.wrong_password,
                                      );
                                    }
                                    // show error message

                                    Fluttertoast.showToast(
                                      msg:
                                          e.message ??
                                          AppLocalizations.of(
                                            context,
                                          )!.login_failed,
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.error,
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

                          //login without passowrd
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.daccount),
                              TextButton(
                                onPressed: () {
                                  AppRouter.pushNamed(Routes.addCategoryPage);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
