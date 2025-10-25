# Autojídelna

Aplikace pro objednávání ze systému Icanteen. Cíl této aplikace je zjednodušit a zrychlit (případně i zautomatizovat) objednávání obědů.

## Kód pro přistup do Icanteen

Aplikace používá package [icanteenlib][icanteenlib] ve které se nachází všechen kód ohledně interakcí s instancí Icanteen.

## Podporované platformy

Aktuálně je podporován pouze Android, ale je v plánu podporovat i IOS. Ostatní platformy není v plánu podporovat.

## Kompilování

Stáhněte [Flutter][flutter-install] a poté spusťte `flutter build apk -PuseDebugSigningConfig=true`

> [!IMPORTANT]
> APK kompilováno tímto způsobem je podepsáno **výchozím Android debug klíčem**. Je plně instalovatelné na zařízeních pro testování a používání, ale **nelze jej nahrát na Google Play** ani použít jako oficiální release klíč.
>
> Pro více informací si přečtěte oficiální Flutter dokumentaci o [podepisování aplikace pro vydání][flutter-app-signing]

[icanteenlib]: https://github.com/Autojidelna/icanteenlib
[flutter-install]: https://github.com/Autojidelna/autojidelna/blob/main/android/app/build.gradle.kts#L65-L78
[flutter-app-signing]: https://docs.flutter.dev/deployment/android#sign-the-app
