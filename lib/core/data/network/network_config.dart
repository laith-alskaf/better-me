import 'package:BetterMe/core/enums/request_type.dart';

class NetworkConfig {
  // static String BASE_API = 'https://api.openai.com';
  //
  // static String getFullApiRout(String apirout) {
  //   return BASE_API + apirout;
  // }

  static Map<String, String> getHeaders(
      {bool? needAuth = true,
        required RequestType type,
        Map<String, String>? extraHeaders}) {
    return {
      if (needAuth!)
        "Authorization":
        "Bearer sk-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",
      if (type != RequestType.GET)
        "Content-Type": type == RequestType.MULTIPART
            ? "multipart/form-data"
            : "application/json",
      ...extraHeaders ?? {}
    };
  }
}