import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/Riverpod/localizations.dart';
import 'package:plasess/Riverpod/theme_provider.dart';
import 'package:plasess/generalWidgetForME/general_widget.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/theme/app_icons.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset('assets/images/logo.png')),
          //list tile with swatch
          //theme mood
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: Text(
                AppLocalizations.of(context)!.themeMode,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(''),
              trailing: Switch(
                value: ref.watch(stateTheme).isDark,
                activeThumbColor: Theme.of(context).colorScheme.onSurface,
                onChanged: (bool value) {
                  if (value) {
                    ref.watch(stateTheme).darkk();
                  } else {
                    ref.watch(stateTheme).lighh();
                  }
                },
              ),
            ),
          ),
          //language
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              subtitle: Text(''),
              trailing: Switch(
                value:
                    ref
                        .watch(localeProvider)
                        .localNotefier
                        .value
                        .languageCode ==
                    'ar',
                activeThumbColor: Theme.of(context).colorScheme.onSurface,
                onChanged: (bool value) {
                  if (value) {
                    ref.watch(localeProvider).swtchArb();
                  } else {
                    ref.watch(localeProvider).swatchEn();
                  }
                },
              ),
            ),
          ),
          //policies and controls
          Generalwidget().getListTile(
            AppLocalizations.of(context)!.policiesControls,
            '',
            Icon(AppIcons.arrowForward),
            Theme.of(context).colorScheme.surface,
            context,
            () {},
          ),
          //frequently asked questions
          Generalwidget().getListTile(
            AppLocalizations.of(context)!.faq,
            '',
            Icon(AppIcons.arrowForward),
            Theme.of(context).colorScheme.surface,
            context,
            () {
              AppRouter.pushNamed(Routes.faQuestions);
            },
          ),
        ],
      ),
    );
  }
}
