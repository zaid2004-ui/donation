import 'package:flutter/material.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';

class FaQuestions extends StatefulWidget {
  const FaQuestions({super.key});

  @override
  State<FaQuestions> createState() => _FaQuestionsState();
}

class _FaQuestionsState extends State<FaQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.faq)),
      //qastion
      body: ListView(
        padding: EdgeInsets.all(10),

        children: [
          Generalwidget().getExpnsionTile(
            context,
            AppLocalizations.of(context)!.faq_q1,
            AppLocalizations.of(context)!.faq_a1,
          ),
          Generalwidget().getExpnsionTile(
            context,
            AppLocalizations.of(context)!.faq_q2,
            AppLocalizations.of(context)!.faq_a2,
          ),
          Generalwidget().getExpnsionTile(
            context,
            AppLocalizations.of(context)!.faq_q3,
            AppLocalizations.of(context)!.faq_a3,
          ),
          Generalwidget().getExpnsionTile(
            context,
            AppLocalizations.of(context)!.faq_q4,
            AppLocalizations.of(context)!.faq_a4,
          ),
          Generalwidget().getExpnsionTile(
            context,
            AppLocalizations.of(context)!.faq_q5,
            AppLocalizations.of(context)!.faq_a5,
          ),
        ],
      ),
    );
  }
}
