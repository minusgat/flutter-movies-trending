import 'package:bloc/bloc.dart';
import '../loader_bloc/loader_cubit.dart';
import '../../../../../commons/constants/languages_constants.dart';
import '../../../domain/entity/language_entity.dart';

part 'language_state.dart';

class LanguageManagerCubit extends Cubit<LanguageManagerState> {
  final LoaderCubit loaderCubit;

  LanguageManagerCubit({
    required this.loaderCubit,
  }) : super(
          LanguageManagerState(
            Languages.languageFromKey(SupportedLanguage.es),
          ),
        );

  setLanguage(SupportedLanguage supportedLanguage) {
    loaderCubit.toggleLoader(true);
    emit(
      LanguageManagerState(
        Languages.languageFromKey(supportedLanguage),
      ),
    );
    loaderCubit.toggleLoader(false);
  }
}
