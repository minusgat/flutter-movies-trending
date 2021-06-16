# 🎬 An awesome movies trending gallery

[![License: MIT][license_badge]][license_link]

[![lahaus_logo_link]][lahaus_link] Technical test 

![Preview](/demo.gif)

![App UI](/demo.png)

##Instalation
1.- Get Packages
```sh
flutter pub get 
```
2.- Generate Internazionalization getters
```sh
flutter gen-l10n 
```
3.- Ant there we go!
```sh
flutter run 
```

###IOS case
- [Adding Supported Locales](#adding-supported-locales)



## CLEAN Arquitecture
I'm try to implement a clean arquitecture with this directory tree

```
├── feature
    │   
    ├── data
    │   ├── core
    │   ├── data_source
    │   ├── model
    │   └── repository
    ├── domain
    │   ├── entity
    │   ├── repository
    │   └── use_case
    ├── presentation
    │   ├── bloc
    │   ├── pages
    │   └── widgets
```



## Some interesting packages

To develop this technical test I'm try to use as few packages as possible but to take less time to make some amazing features i need to use more package, and there are some that I discovered during this amazing trip 

#### DartZ
`dartz: ^0.10.0-nullsafety.1`
Although Dart is already a typed and compiled language but with the properties of an interpreted language, Functional programming is an interesting approach and it seems to solve a lot of problems

I didn't know it's full potential and I only used the tuple typing for objects called 'Either', as soon as possible I want to study this approach
#### Equatable
`equatable: ^2.0.2`
A very simply and fast way to do Objects comparations, we can indicate wich properties of an object wil be considered to comapare two objects instead of do the manual implementation and overridings.

### GetIt
`get_it: ^7.1.3`
Even though it's seems dart has an easy way to manage reference an instance we use GetIt as a service locator and implement dependency injection.

### Flutter Bloc
`flutter_bloc: ^7.0.1`
Dart and Flutter let us to implement Staless and Stateful widgets , with the stateful approach we can isolate the state of each instance of a Widget, but over time this allows us to create fat components in a very easy way,and the [bloc library][bloc_library_link] help us to hold the state and share with other components.


## Flutter Internazionalization 🗺️
You can read the complete tutorial [Official internationalization guide for Flutter][l10n_link]

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/app_en.arb`.

```arb
{
    "@@locale": "en",
    "home": "Home",
    "@home": {
        "description": "Home label description"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "home": "Home",
    "@home": {
        "description": "Home label description"
    }
    "profile": "Perfil",
    "@helloWorld": {
        "description": "Profile label description"
    }
}
```

3. Instance the translated String

```dart
import 'package:movies_trending/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```
4. ### ⚠️⚠️⚠️ Important ⚠️⚠️⚠️
You need to run the `gen-l10n` command, after you create your's `.arb` files  because the files at `.dart_tool/flutter_gen/gen_l10n` will not be generated automatically.

```sh
flutter gen-l10n
```

5. ###  Adding Supported Locales 

At the ios Case you need to do some additional confgis

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
 
    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

```

5. ### Localizely
Along of my research for the best way to implement internationalization i found an interesting plugin for VsCode  and Android Studio that named [Flutter Intl][vs_flutter_intl] develop by [Localizely][localizely_link]. It was an easy and automated implementation,but at this time i opt for the official flutter guide.

[An easy way to implement this plugins ][localizely_tutorial]

###Specials greeting to an awesome Movies Database

There was a pleasure to meet this service , thanks LaHaus for sharing this resource with me, it was a technical test but it was so funny to implement this API. 🤓 🚀 🎉 

 [![movie_data_base_logo ] ][movie_data_base_link]



***An apologyse for my bad english ,actually i'm trying to practice as a part of  my software development process.***


Made with <3 by Carlos Hernández



[lahaus_link]:https://www.lahaus.mx/
[lahaus_logo_link]: https://lahaus.imgix.net/static/branding/logo-lahaus-full.svg?auto=compress,format
[license_link]: https://opensource.org/licenses/MIT
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[l10n_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[vs_flutter_intl]: https://plugins.jetbrains.com/plugin/13666-flutter-intl

[movie_data_base_logo]: https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg
[movie_data_base_link]:https://www.themoviedb.org/
[localizely_link]:https://localizely.com/
[localizely_tutorial]:https://localizely.com/flutter-localization-workflow/
[bloc_library_link]:https://bloclibrary.dev/

