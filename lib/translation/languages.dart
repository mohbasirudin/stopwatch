import 'package:get/get.dart';

class Languages extends Translations {
  static const history = "History";
  static const clear = "Clear";
  static const emptyHistory = "empty_history";
  static const language = "Language";
  static const theme = "Theme";
  static const setting = "Setting";
  static const locale = "locale";

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys {
    return {
      "en_US": {
        history: history,
        clear: clear,
        emptyHistory: "No history entries found.",
        language: language,
        theme: theme,
        setting: setting,
        locale:"EN",
      },
      "id_ID": {
        history: "Catatan",
        clear: "Hapus",
        emptyHistory: "Tidak ada catatan yang ditemukan.",
        language: "Bahasa",
        theme: "Tema",
        setting: "Pengaturan",
        locale:"ID",
      }
    };
  }
}
