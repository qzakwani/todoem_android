// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:crypto/crypto.dart';

String createTaskId(String seed) {
  return generateMd5(seed);
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
