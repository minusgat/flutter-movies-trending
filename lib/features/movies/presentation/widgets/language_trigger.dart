import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notification_bloc/notification_cubit.dart';
import '../../../../commons/constants/languages_constants.dart';
import '../../domain/entity/language_entity.dart';
import '../bloc/language_bloc/language_cubit.dart';

class LanguageTrigger extends StatelessWidget {
  final l10n;

  const LanguageTrigger({Key? key, this.l10n}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageManagerCubit = BlocProvider.of<LanguageManagerCubit>(context);
    final notificationCubit = BlocProvider.of<NotificationCubit>(context);

    void handleLanguagePick(LanguageEntity language) {
      if (languageManagerCubit.state.language.key != language.key)
        languageManagerCubit.setLanguage(language.key);
    }

    List<Widget> buildLanguages(List<LanguageEntity> languagesList) {
      return languagesList
          .map(
            (language) => Expanded(
              child: Column(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(language.value),
                    ),
                    onTap: () {
                      handleLanguagePick(language);
                    },
                  ),
                  if (language.key == languageManagerCubit.state.language.key)
                    ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: SizedBox(
                          width: 4,
                          height: 4,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
          .toList();
    }

    return BlocBuilder<LanguageManagerCubit, LanguageManagerState>(
      builder: (context, state) {
        List<LanguageEntity> languagesList = Languages.languages;
        Timer(Duration(seconds: 2), () {
          notificationCubit.show(l10n.languageChanged);
        });
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildLanguages(languagesList),
        );
      },
    );
  }
}
