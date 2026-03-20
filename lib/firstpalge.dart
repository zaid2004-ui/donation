import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/Riverpod/theme_provider.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';

class Firstpalge extends ConsumerStatefulWidget {
  const Firstpalge({super.key});

  @override
  ConsumerState<Firstpalge> createState() => _FirstpalgeState();
}

class _FirstpalgeState extends ConsumerState<Firstpalge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.login,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final resultTheme = ref.watch(stateTheme);
              if (resultTheme.isDark == true) {
                ref.read(stateTheme).lighh();
              } else {
                ref.read(stateTheme).darkk();
              }

              // final localstate = ref.read(localeProvider);

              // if (localstate.localNotefier.value == Locale("ar")) {
              //   localstate.localNotefier.value = Locale('en');
              // } else {
              //   localstate.localNotefier.value = Locale('ar');
              // }
            },
            child: Text('enter'),
          ),
        ],
      ),
    );
  }
}
