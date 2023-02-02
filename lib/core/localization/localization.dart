import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';

class AppLocalizations {
  final Locale locale;
  static AppRouterDelegate? appRouter;

  AppLocalizations(this.locale);

  static const String englishCode = 'en';
  static const Locale supportedEnglishLocale = Locale(englishCode, '');
  static const List<String> supportedLanguageCodes = <String>[englishCode];
  static const List<Locale> supportedLocales = <Locale>[supportedEnglishLocale];

  static const AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Locale resolveLocale(
    Locale deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    return supportedEnglishLocale;
  }

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    englishCode: <String, String>{
      // Common
      'Done': 'Fatto ✅',
      'Back': 'Back',
      "Your info have been updated!": "Le tue informazioni sono state aggiornate!",
      "You are now verified!": "Sei stato verificato!",
      "You are already verified!": "Sei già stato verificato!",
      "Your account has been deleted succesfully!":
          "Il tuo account è stato eliminato con successo!",
      "Profile": "Profilo",
      "Security & Privacy": "Sicurezza & Privacy",
      "App": "App",
      "Update Profile": "Aggiorna Profilo",
      "Verify account": "Verifica account",
      "Change password": "Cambia password",
      "Privacy Policy": "Privacy Policy",
      "Terms & Conditions": "Termini e Condizioni",
      "Invite NOTYFER": "Invita NOTYFER",
      "Leave a review": "Lascia una recensione",
      "Contact support": "Contatta il supporto",
      "Support our project": "Supporta il progetto",
      "Logout": "Logout",
      "Delete account": "Elimina account",
      "Do you really want to delete your account?":
          "Vuoi veramente eliminare il tuo account?",
      "Yes": "Si",
      "Thanks we received your message 👍🏻": "Grazie abbiamo ricevuto il tuo messaggio",
      "Scanning not supported": "Scan non supportato",
      "Your device does not support scanning a code from an item. Please use a device with a camera.":
          "Il tuo dispositivo non supporta la scansione di codici. Usa un dispositivo con camera.",
      "Email is a mandatory field.": "Email è un campo obbligatorio.",
      "The email address is malformed": "L'indirizzo email non è nel formato corretto",
      "Invalid recipient email sent.": "Destinatario non valido.",
      "Invalid sender email sent.": "Mittente non valido.",
      "Sent 📧": "Inviata 📧",
      "An email has been sent to you with the instructions for reset your password.":
          "Un email ti è stata inviata con le istruzioni per reimpostare la password.",
      "Something went wrong while creating the account.":
          "Qualcosa è andato storto mentre provavi a creare un nuovo account.",
      "Email and Password are mandatory fields.":
          "I campi Email e Password sono obbligatori",
      "Don\'t have an account? Go to Register": "Non hai un account? ",
      "Register": "Registrati",
      "This user account has been disabled by the admin.":
          "Questo account è stato disabilitato.",
      "The password is invalid.": "Password non valida.",
      "Looks like that this car is not electric or plugin hybrid.":
          "Sembra che quest'auto non sia elettrica o plugin hybrid.",
      "Add your car": "Aggiungi macchina",
      "Hey download Noty from the App Store at: https://apps.apple.com/app/noty/id6443537056":
          "Hey scarica Noty da App Store: https://apps.apple.com/app/noty/id6443537056",
      "Delete": "Elimina",
      "Block user": "Blocca utente",
      "Report chat": "Riporta chat",
      "Thanks for reporting 👍🏻": "Grazie per la segnalazione 👍🏻",
      "Looks like you are not an electric car driver. Sorry but you can't join our club. Is it an error? Contact us at: support@notyapp.it":
          "Sembra che tu non abbia un auto elettrica. Scusa ma non puoi far parte del club. È un errore? Contattaci a: support@notyapp.it",
      "You need to set a license plate first.":
          "Devi aggiungere una targa per il tuo veicolo.",
      "You can't set an empty license plate.":
          "Non puoi aggiornare il profilo senza una targa.",
      "This driver is not part of our community.":
          "Questo driver non fa parte della nostra community.",
      'E-mail': 'E-mail',
      "Log in": "Log in",
      "Password": "Password",
      "Save": "Salva",
      "You don\'t have any car here yet.": "Non hai ancora aggiunto nessuna macchina",
      "Forgot your password?": "Dimenticato la password?",
      "Name": "Nome",
      "Share or print your QR": "Stampa QR",
      "Finish": "Fine",
      "-": "-",
      "Enter driver`s car plate number": "Inserisci la targa",
      "Scan QR": "Scansiona QR",
      "Send message": "Invia messaggio",
      "Messaggi": "Messaggi",
      "Messaggio": "Messaggio",
      "Verify next time": "Verifica la prossima volta",
      "Take a photo": "Foto",
      "Surname": "Cognome",
      "We do not save any data. All photos, chats or ID`s are used only for verification.":
          "Non salviamo alcun dato. Tutte le foto, chat o ID vengono utilizzate solo per verifica.",
      "Sign in with Google": "Sign in con Google",
      "This is your QR code which will show to other drivers if they want to contact you.":
          "Questo è il tuo personale QR che verrà mostrato agli altri Notyfer che desiderano contattarti",
      "Plate": "Targa",
      "Continue": "Continua",
      "Take a picture of your technical paper": "Scatta una foto del tuo libretto",
      "Scan": "Scan",
      "Sign in with Apple": "Sign in con Apple",
      "Item": "Item",
      "Reset password": "Reset password",
      "Chats": "Chats",
      "New way of communication between drivers":
          "New way of communication between drivers",
      "Label": "Label",
      'Settings': 'Impostazioni',
      'registraty': 'Registrati',
      'All fields are mandatory fields.': 'Tutti i campi sono campi obbligatori.',
      'enter_plate': 'Enter driver`s car plate number',
    }
  };

  String value(String key) {
    final Map<String, String>? language = _localizedValues[locale.languageCode];
    final String? languageKey = language?[key];
    if (language != null) {
      if (languageKey != null) {
        return languageKey;
      } else {
        return '${locale.languageCode} $key undefined';
      }
    } else {
      return '${locale.languageCode} undefined';
    }
  }

  static String ofGlobalContext(String key) {
    appRouter ??= appLocator.get<AppRouterDelegate>();
    final BuildContext context =
        appLocator.get<AppRouterDelegate>().navigatorKey.currentContext!;
    return AppLocalizations.of(context).value(key);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
