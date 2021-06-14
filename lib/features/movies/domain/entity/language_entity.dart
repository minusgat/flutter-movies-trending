import 'package:equatable/equatable.dart';

class LanguageEntity  extends Equatable{
  final String code;
  final String value;
  final key;

  const LanguageEntity({required this.code, required this.value,required this.key});

  @override
  List<Object?> get props => [code];
}
