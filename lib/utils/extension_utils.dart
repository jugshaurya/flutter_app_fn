import 'package:intl/intl.dart';

extension Capitalized on String {
  String capitalized() =>
      substring(0, 1).toUpperCase() + substring(1).toLowerCase();
}

extension ListExtension<E> on List<E> {
  void addAllUnique(Iterable<E> iterable) {
    for (var element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension DateTimeExtension on DateTime {
  String formatHHMM() => DateFormat('hh:mm a').format(this);
  String formatDDMMM() => DateFormat('dd MMM').format(this);
  String formatDate() => DateFormat('dd MMM yyyy').format(this);
  String formatDateTime() => DateFormat('dd MMM yyyy hh:mm a').format(this);
}
