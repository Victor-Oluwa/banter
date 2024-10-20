import 'dart:convert'; // For base64 encoding/decoding
import 'dart:typed_data'; // For handling byte arrays
import 'package:crypto/crypto.dart'; // For HMAC and SHA-256
import 'dart:math'; // For random number generation (IV)
import 'package:pointycastle/export.dart'; // For AES-GCM

class CryptoHelper {
  CryptoHelper();

  // Generate a random IV for AES-GCM (12 bytes is standard for GCM)
  static Uint8List _generateIV() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(
        12,
            (_) => random.nextInt(256),
      ),
    );
  }

  // AES-GCM encryption
  static String encrypt({
    required String data,
    required String secretKey,
  }) {
    final key = _deriveKey(secretKey);
    final iv = _generateIV();

    final encrypter = GCMBlockCipher(AESEngine())
      ..init(true, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final plainText = utf8.encode(data);
    final cipherText = encrypter.process(Uint8List.fromList(plainText));

    // Combine IV and cipherText and return as base64
    return base64.encode(iv + cipherText);
  }

  // AES-GCM decryption
  static String decrypt({
    required String base64Data,
    required String secretKey,
  }) {
    final encryptedData = base64.decode(base64Data);
    final key = _deriveKey(secretKey);

    // Extract IV (first 12 bytes)
    final iv = encryptedData.sublist(0, 12);
    final cipherText = encryptedData.sublist(12);

    final encrypter = GCMBlockCipher(AESEngine())
      ..init(false, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final decryptedData = encrypter.process(Uint8List.fromList(cipherText));
    return utf8.decode(decryptedData);
  }

  // Derive a 256-bit key from the secretKey using SHA-256
  static Uint8List _deriveKey(String secretKey) {
    final keyBytes = utf8.encode(secretKey);
    final sha256Hash = sha256.convert(keyBytes).bytes;
    return Uint8List.fromList(sha256Hash);
  }
}
