import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/login&regestr/reset_passowrd/provider.dart';

class Reset extends ConsumerWidget {
  const Reset({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final emailFromPrivider = ref.watch(emailProvider);
    final TextEditingController emailControler = TextEditingController(
      text: emailFromPrivider,
    );
    return Scaffold(
      appBar: AppBar(title: Text('reset password')),
      body: ListView(
        children: [
          //image
          Image.asset(
            'assets/images/reset.png',
            width: double.infinity,
            height: 250,
          ),
          //text and
          Center(child: Text(AppLocalizations.of(context)!.enteryouremail)),
          SizedBox(height: 30),

          //text filed
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Generalwidget().getTextFormField(
              context,
              AppLocalizations.of(context)!.email,
              controller: emailControler,
            ),
          ),
          //button reset
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Generalwidget().getElevatedButton(
              context,
              AppLocalizations.of(context)!.reset,
              () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: emailControler.text.trim(),
                  );

                  if (!context.mounted) return;

                  Generalwidget().showSucessMessage(
                    context,
                    'Check your email to reset your password',
                  );
                } on FirebaseAuthException catch (e) {
                  if (!context.mounted) return;

                  Generalwidget().showErrorMessage(
                    context,
                    e.message ?? 'Something went wrong',
                  );
                }
              },
            ),
          ),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.remember),
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
    );
  }
}
