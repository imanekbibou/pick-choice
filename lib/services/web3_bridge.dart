import 'dart:js_util' as js_util;

class Web3Bridge {
  static Future<String> connect() async {
    final res = await js_util.promiseToFuture(
      js_util.callMethod(js_util.globalThis, 'eval', ['pickChoix.connect()']),
    );
    return res.toString();
  }

  static Future<void> saveCoffee(
    String contractAddress,
    String abi,
    String name,
    String extra,
  ) async {
    await js_util.promiseToFuture(
      js_util.callMethod(
        js_util.globalThis,
        'eval',
        ['pickChoix.saveCoffee("$contractAddress", $abi, "${_esc(name)}", "${_esc(extra)}")'],
      ),
    );
  }

  static Future<void> saveBakery(
    String contractAddress,
    String abi,
    String name,
    String extra,
  ) async {
    await js_util.promiseToFuture(
      js_util.callMethod(
        js_util.globalThis,
        'eval',
        ['pickChoix.saveBakery("$contractAddress", $abi, "${_esc(name)}", "${_esc(extra)}")'],
      ),
    );
  }

  static String _esc(String v) {
    return v.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
  }
}
