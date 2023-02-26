import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:core';

/*String generateJwtToken(String payload, String secretKey) {
  // Add the header
  final header = {'alg': 'HS256', 'typ': 'JWT'};
  // Encode the header
  final headerJson = jsonEncode(header);
  final headerBase64 = base64UrlEncode(utf8.encode(headerJson));
  // Encode the payload
  final payloadBase64 = base64UrlEncode(utf8.encode(payload));
  // Sign the header and payload
  final signature = hmacSha256('$headerBase64.$payloadBase64', secretKey);
  final signatureBase64 = base64UrlEncode(signature.bytes);
  // Combine the header, payload, and signature to form the token
  final token = '$headerBase64.$payloadBase64.$signatureBase64';
  return token;
}

bool verifyJwtToken(String token, String secretKey) {
  final parts = token.split('.');
  if (parts.length != 3) {
    return false;
  }
  final header = jsonDecode(utf8.decode(base64Url.decode(parts[0])));
  final payload = jsonDecode(utf8.decode(base64Url.decode(parts[1])));
  final signature = base64Url.decode(parts[2]);
  final verifiedSignature =
      hmacSha256('${parts[0]}.${parts[1]}', secretKey).bytes;
  return verifiedSignature.length == signature.length &&
      verifiedSignature.every((element) =>
          element == signature[verifiedSignature.indexOf(element)]);
}

Hmac hmacSha256(String input, String secretKey) {
  return Hmac(sha256, utf8.encode(secretKey))..add(utf8.encode(input));
}*/
