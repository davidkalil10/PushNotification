import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoNotificacao = "";
  String _corpoNotificacao = "";
  String _urlNotificacao = "";
  String _imgNotificacao = "";


// bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
 // bool _requireConsent = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

   // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

   // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');

    });

    OneSignal.shared
        .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event.notification}');
      /// Display Notification, send null to not display
      print("achei a notificacao");
      String? titulo = event.notification.title;
      String? corpo = event.notification.body;
      String? url = event.notification.launchUrl;
      String? imgUrl = event.notification.bigPicture;

      setState(() {
        _textoNotificacao = titulo!;
        _corpoNotificacao = corpo!;
        _urlNotificacao = url!;
        _imgNotificacao = imgUrl!;
      });
      event.complete;

    });


/*    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });*/


    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .setAppId("09f03d4e-373a-4b43-8eb2-5f0764beebbd");

   // bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
    bool requiresConsent = true;


/*    this.setState(() {
      _enableConsentButton = requiresConsent;
    });*/


    OneSignal.shared.disablePush(false);

   // bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
   // print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  }


  void _handleConsent() {
    print("Setting consent to true");
    OneSignal.shared.consentGranted(true);

    print("Setting state");
/*    this.setState(() {
      _enableConsentButton = false;
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('OneSignal Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                     (_textoNotificacao !=null && _textoNotificacao != "")
                         ?Text("titulo: $_textoNotificacao")
                         :Container(),

                    (_corpoNotificacao !=null && _corpoNotificacao != "")
                        ?Text("Corpo: $_corpoNotificacao")
                        :Container(),

                    (_urlNotificacao !=null && _urlNotificacao != "")
                        ?Text("URL: $_urlNotificacao")
                        :Container(),

                    (_imgNotificacao !=null && _imgNotificacao != "")
                        ?Image.network(_imgNotificacao, fit: BoxFit.contain,)
                        :Container(),

                  ],
                ),
              ),
            ),
          )),
    );
  }
}

