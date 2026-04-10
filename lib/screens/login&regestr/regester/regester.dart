import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/theme/app_icons.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController confermPasswordController = TextEditingController();
  //google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      log('---------------------------Email: ${userCredential.user?.email}');

      return userCredential;
    } catch (e) {
      log("Error during Google Sign-In: $e");
      return null;
    }
  }

  //dispose controllers to avoid memory leak
  @override
  void dispose() {
    emailControler.dispose();
    passwordControler.dispose();
    confermPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //wave and img logo
          Stack(
            children: [
              //wave
              Transform.flip(
                flipY: true,
                child: Generalwidget().getWavesWidget(context),
              ),
              //img
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: double.infinity,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
          //name for screen
          Center(
            child: Text(
              AppLocalizations.of(context)!.joinUs,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          //container for text fields and buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Container(
              width: double.infinity,
              height: 450,
              //decoration for container
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

              //text fields from general widget
              child: Form(
                key: globalKey,
                child: ListView(
                  children: [
                    //userNmae
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormFieldUserNmae(
                        context,
                        AppLocalizations.of(context)!.name,
                      ),
                    ),

                    //email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormField(
                        context,
                        AppLocalizations.of(context)!.email,
                        controller: emailControler,
                      ),
                    ),
                    //password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormFieldpassword(
                        context,
                        AppLocalizations.of(context)!.password,
                        controller: passwordControler,
                      ),
                    ),

                    //Confirm password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormFieldpasswordconferm(
                        context,
                        AppLocalizations.of(context)!.confirm,
                        controller: confermPasswordController,
                        passwordController: passwordControler,
                      ),
                    ),

                    //button for regestration and google sign in
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(20, 0, 0, 0),
                          //regestration button
                          child: Generalwidget().getElevatedButton(
                            context,
                            AppLocalizations.of(context)!.registration,
                            () async {
                              if (globalKey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                        email: emailControler.text.trim(),
                                        password: passwordControler.text.trim(),
                                      );

                                  await FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                  if (!context.mounted) return;
                                  Generalwidget().showSucessMessage(
                                    context,
                                    "Verification email sent. Please check your email and confirm your account.",
                                  );

                                  Future.delayed(Duration(seconds: 3), () {
                                    AppRouter.pushNamed(Routes.login);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    Generalwidget().showErrorMessage(
                                      context,
                                      "The password provided is too weak",
                                    );
                                  } else if (e.code == 'email-already-in-use') {
                                    Generalwidget().showErrorMessage(
                                      context,
                                      "The account already exists for that email",
                                    );
                                  }
                                } catch (e) {
                                  log(e.toString());
                                }
                              }
                            },
                          ),
                        ),
                        Spacer(),
                        //login with google
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
                          child: Generalwidget().getIconButton(
                            context,
                            Icon(AppIcons.google),
                            () async {
                              UserCredential? user = await signInWithGoogle();
                              if (user != null) {
                                if (!context.mounted) return;
                                Generalwidget().showSucessMessage(
                                  context,
                                  "Signed in successfully",
                                );

                                AppRouter.pushNamed(Routes.home);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.haccount),
                        TextButton(
                          onPressed: () {
                            AppRouter.pushNamed(Routes.login);
                          },
                          child: Text(AppLocalizations.of(context)!.login),
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
