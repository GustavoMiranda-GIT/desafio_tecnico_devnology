# desafio_tecnico_devnology

Dependências:

dependencies:
    http: ^1.3.0
    get: ^4.7.2
    get_storage: ^2.1.1
    flutter_localizations:
        sdk: flutter
    intl: ^0.19.0

-----------------------------------------------------------------

O aplicativo foi desenvolvido em um Medium Phone tamanho 6,4 Android 15.0("VanillaIceCream").

Brevemente testado em:

Android 10.0("Q")
Android 12.0("S")
Android 13.0("Tiramisu")
Android 14.0("UpsideDownCake")


Dispositivos:
Small Phone(4,65)
Pixel Fold(7,58)
Pixel Pro XL(6,8)
Samsung S20FE
Pixel Tablet


-----------------------------------------------------------------

* Caso get_storage apresente o seguinte erro, ative o modo desenvolvedor do windows:
    Building with plugins requires symlink support.
    Please enable Developer Mode in your system settings. Run
    start ms-settings:developers
    to open settings.

* Caso seja necessário  alterar a ndkVersion:

    ndkVersion = "27.0.12077973"

* Caso seja necessário adicione no pubspec.yaml:

    flutter:

    generate: true

---------------------------------------------------------------------

Funcionalidades extras:

* Tema escuro (Na tela inicial na Appbar tem um Drawer com um botão para mudar o tema);
* Tradução para inglês (Muda de acordo com o idioma do dispositivo);
