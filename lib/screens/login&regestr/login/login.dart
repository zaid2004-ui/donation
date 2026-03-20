import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/generalWidgetForME/password_field.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/login&regestr/reset_passowrd/provider.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // final TextEditingController emailControler = TextEditingController();
    final GlobalKey<FormState> globalKey = GlobalKey();
    final TextEditingController emailControler = TextEditingController();

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
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          //container for text fields and buttons
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

              //text fields from general widget
              child: Form(
                key: globalKey,
                child: ListView(
                  children: [
                    //email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                      child: Generalwidget().getTextFormField(
                        context,
                        AppLocalizations.of(context)!.email,
                        controller: emailControler,
                      ),
                    ),
                    //password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 1),
                      child: PasswordField(
                        label: AppLocalizations.of(context)!.password,
                      ),
                    ),
                    // forgot passowerd
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.forgotpassword),
                        TextButton(
                          onPressed: () {
                            if (emailControler.text == '') {
                              Fluttertoast.showToast(
                                msg: "pleas Enter your email",
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
                    //button login
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(10, 0, 10, 0),
                      child: Generalwidget().getElevatedButton(
                        context,
                        'login',
                        () {
                          // getBiometric();
                          AppRouter.pushNamed(Routes.home);

                          // if (globalKey.currentState!.validate()) {}
                        },
                      ),
                    ),
                    //dont have account
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
