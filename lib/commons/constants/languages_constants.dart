import '../../features/movies/domain/entity/language_entity.dart';

enum SupportedLanguage { es, en, pt }

class Languages {
  const Languages._();

  static const languages = [
    LanguageEntity(code: 'es', value: 'Spanish', key: SupportedLanguage.es),
    LanguageEntity(code: 'en', value: 'English', key: SupportedLanguage.en),
    LanguageEntity(code: 'pt', value: 'Portuguese', key: SupportedLanguage.pt),
  ];

  static languageFromKey(SupportedLanguage supportedLanguage) =>
      languages.firstWhere((element) => element.key == supportedLanguage);

  static languageFromCode(String code) =>
      languages.firstWhere((element) => element.code == code);


}
