// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart' show DateFormat;
import 'package:jiffy/jiffy.dart';

extension TimeLeft on DateTime {
  String get dueIn => Jiffy(this).fromNow();
  String get formatIt => DateFormat('LLL d, y @').add_jm().format(this);
}
