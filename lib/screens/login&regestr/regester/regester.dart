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
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController confermPasswordController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey();
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. تشغيل تدفق تسجيل الدخول من جوجل
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null; // المستخدم أغلق النافذة

      // 2. جلب تفاصيل المصادقة
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. إنشاء التوثيق لـ Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. تسجيل الدخول الفعلي في Firebase (هنا يتم الحفظ في Firebase Auth)
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // الآن يمكنك جلب بيانات المستخدم بنجاح
      log('---------------------------Email: ${userCredential.user?.email}');

      return userCredential;
    } catch (e) {
      log("Error during Google Sign-In: $e");
      return null;
    }
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
                      ),
                    ),

                    //button login
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(20, 0, 0, 0),
                          child: Generalwidget().getElevatedButton(
                            context,
                            AppLocalizations.of(context)!.registration,
                            () async {
                              if (globalKey.currentState!.validate()) {
                                if (passwordControler.text !=
                                    confermPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("password not match"),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                        email: emailControler.text.trim(),
                                        password: passwordControler.text.trim(),
                                      );
                                  if (!mounted) return;
                                  Generalwidget().showSucessMessage(
                                    context,
                                    "account created successfully",
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    if (!mounted) return;
                                    AppRouter.pushNamed(Routes.login);
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    log('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "The account already exists for that email.",
                                        ),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                    log(
                                      'The account already exists for that email.',
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
                                // نجاح التسجيل! الآن انتقل للصفحة الرئيسية
                                if (!mounted) return;
                                Generalwidget().showSucessMessage(
                                  context,
                                  "Signed in successfully",
                                );

                                // استبدل Routes.home بمسار الصفحة الرئيسية عندك
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
