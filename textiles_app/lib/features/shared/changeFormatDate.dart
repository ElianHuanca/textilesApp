// ignore_for_file: file_names

String changeFormatDate(String a) {
  DateTime date = DateTime.parse(a);
  String fecha = "${date.day}-${date.month}-${date.year}";
  return fecha;
}
