import 'package:flutter/material.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/theme/app_icons.dart';

class Regester extends StatelessWidget {
  const Regester({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> globalKey = GlobalKey();
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
                      ),
                    ),
                    //password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormField(
                        context,
                        AppLocalizations.of(context)!.password,
                      ),
                    ),

                    //Confirm password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Generalwidget().getTextFormField(
                        context,
                        AppLocalizations.of(context)!.confirm,
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
                            () {
                              if (globalKey.currentState!.validate()) {
                                AppRouter.pushNamed(Routes.login);
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
                            () {},
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
