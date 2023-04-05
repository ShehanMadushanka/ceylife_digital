import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:xor/xor.dart';

class CommonUtils {
  CommonUtils._();

  static Uint8List _processBlocks(Uint8List input, CBCBlockCipher engine) {
    var output = new Uint8List(input.lengthInBytes);

    for (int offset = 0; offset < input.lengthInBytes;) {
      offset += engine.processBlock(input, offset, output, offset);
    }

    return output;
  }

  static String formatBytesAsHexString(Uint8List bytes) {
    var result = new StringBuffer();
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      var part = bytes[i];
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return result.toString().toUpperCase();
  }

  static Uint8List createUint8ListFromHexString(String hex) {
    var result = new Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      var num = hex.substring(i, i + 2);
      var byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }
    return result;
  }

  static Uint8List generateXOR(Uint8List key, Uint8List val) {
    var xorVal = xor(key, val);
    return xorVal;
  }

  static Uint8List generateRandomByteArray() {
    List<int> bytes = [];
    var random = Random.secure();

    for (int i = 0; i < 16; i++) {
      bytes.add(random.nextInt(255));
    }

    return Uint8List.fromList(bytes);
  }

  static String getSHA(String deviceID) {
    var deviceIDByte = utf8.encode(deviceID);
    var shaBytes = sha1.convert(deviceIDByte).bytes;
    return HEX.encode(shaBytes).substring(0, 32);
  }
}
