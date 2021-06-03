# Flutter movies trending

[![License: MIT][license_badge]][license_link]

A technical test for [![lahaus_logo_link]]([lahaus_logo_link])

## Translations 🗺️
You can read the complete tutorial 
[Official internationalization guide for Flutter][l10n_link]

###Important ⚠️⚠️⚠️
You need to run the gen-l10n command, after you create your's `.arb` files  because the files at `.dart_tool/flutter_gen/gen_l10n` doesn't generated automatically.

```sh
flutter gen-l10n
```

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

### Adding Supported Locales

At the ios Case you need to do some additional confgis

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── app_en.arb
│   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "home": "Home",
    "@home": {
        "description": "Home label description"
    },
    "profile": "Perfil",
    "@helloWorld": {
        "description": "Profile label description"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "home": "Inicio",
    "@home": {
        "description": "Descripcion de la etiqueta Inicio"
    },
    "profile": "Perfil",
    "@helloWorld":  {
        "description": "Descripcion de la etiqueta Perfil"
    } 
}
```

Made with <3



[lahaus_logo_link]: https://lahaus.imgix.net/static/branding/logo-lahaus-full.svg?auto=compress,format
[license_link]: https://opensource.org/licenses/MIT
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[l10n_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
