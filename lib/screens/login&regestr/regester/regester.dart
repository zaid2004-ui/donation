import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:plasess/core/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/core/router/app_route.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/core/theme/app_icons.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  //controllers for text fields
  TextEditingController emailControler = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController confermPasswordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  bool isLoding = false;

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

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user!;

      await saveUserDataToFirestore(
        user: user,
        name: user.displayName,
        phone: null,
      );

      return userCredential;
    } catch (e) {
      log("Error during Google Sign-In: $e");
      return null;
    }
  }

  //save user data to firestore
  Future<void> saveUserDataToFirestore({
    required User user,
    String? phone,
    String? name,
  }) async {
    await FirebaseFirestore.instance
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('User')
        .doc(user.uid)
        .set({
          'phoneNumber': phone ?? '',
          'User_ID': user.uid,
          'Name': name ?? (user.displayName ?? ''),
          'Email': user.email ?? '',
          'Photo_URL': user.photoURL ?? '',
          'Role': 'User',
          'Favorites': [],
          'Preferred_Categories': [],
        });
  }

  //send email verification
  Future<void> sendEmailVerification(User user, BuildContext context) async {
    await user.sendEmailVerification();
    if (!context.mounted) return;
    GeneralWidget().showSucessMessage(
      context,
      AppLocalizations.of(context)!.verification_email_sent,
    );

    Future.delayed(Duration(seconds: 3), () {
      AppRouter.pushNamed(Routes.login);
    });
  }

  //dispose controllers to avoid memory leak
  @override
  void dispose() {
    emailControler.dispose();
    passwordControler.dispose();
    confermPasswordController.dispose();
    nameControler.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //wave and img logo
            Stack(
              children: [
                //wave
                Transform.flip(
                  flipY: true,
                  child: GeneralWidget().getWavesWidget(context),
                ),
                //img
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            //loading indicator
            if (isLoding)
              //loading indicator
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
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
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),

                  //decoration for container
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

                  //text fields from general widget
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //userNmae
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: GeneralWidget().getTextFormFieldUserNmae(
                            context,
                            AppLocalizations.of(context)!.name,
                            controller: nameControler,
                          ),
                        ),
                        const SizedBox(height: 12),

                        //phone number
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: IntlPhoneField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.phone,
                              border: OutlineInputBorder(),
                            ),
                            initialCountryCode: 'JO',
                            onChanged: (phone) {
                              log(phone.completeNumber);
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        //email
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: GeneralWidget().getTextFormField(
                            context,
                            AppLocalizations.of(context)!.email,
                            controller: emailControler,
                          ),
                        ),
                        const SizedBox(height: 12),

                        //password
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: GeneralWidget().getTextFormFieldpassword(
                            context,
                            AppLocalizations.of(context)!.password,
                            controller: passwordControler,
                          ),
                        ),
                        const SizedBox(height: 12),

                        //Confirm password
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: GeneralWidget()
                              .getTextFormFieldpasswordconferm(
                                context,
                                AppLocalizations.of(context)!.confirm,
                                controller: confermPasswordController,
                                passwordController: passwordControler,
                              ),
                        ),
                        const SizedBox(height: 12),

                        //button for regestration and google sign in
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(20, 0, 0, 0),
                              //regestration button
                              child: GeneralWidget().getElevatedButton(
                                context,
                                AppLocalizations.of(context)!.registration,
                                () async {
                                  if (!globalKey.currentState!.validate()) {
                                    return;
                                  }
                                  //check if password and confirm password are the same
                                  if (confermPasswordController.text.trim() !=
                                      passwordControler.text.trim()) {
                                    GeneralWidget().showErrorMessage(
                                      context,
                                      AppLocalizations.of(
                                        context,
                                      )!.password_match,
                                    );
                                    return;
                                  }

                                  //show loading indicator
                                  setState(() {
                                    isLoding = true;
                                  });
                                  //regester user with firebase auth
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                          email: emailControler.text.trim(),
                                          password: passwordControler.text
                                              .trim(),
                                        );
                                    //get current user
                                    final user =
                                        FirebaseAuth.instance.currentUser!;
                                    //save user data to firestore
                                    await saveUserDataToFirestore(
                                      user: user,
                                      name: nameControler.text.trim(),
                                      phone: phoneController.text.trim(),
                                    );
                                    if (!context.mounted) return;

                                    await sendEmailVerification(user, context);
                                    if (!context.mounted) return;
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      GeneralWidget().showErrorMessage(
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.weak_password,
                                      );
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      GeneralWidget().showErrorMessage(
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.email_already_exists,
                                      );
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  } finally {
                                    setState(() {
                                      isLoding = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            Spacer(),
                            //login with google
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
                              child: GeneralWidget().getIconButton(
                                context,
                                Icon(AppIcons.google),
                                () async {
                                  UserCredential? user =
                                      await signInWithGoogle();
                                  if (user != null) {
                                    if (!context.mounted) return;
                                    GeneralWidget().showSucessMessage(
                                      context,
                                      AppLocalizations.of(
                                        context,
                                      )!.signed_in_successfully,
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
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
