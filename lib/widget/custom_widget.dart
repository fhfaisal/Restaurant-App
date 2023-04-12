import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
var baseUrl="http://temp.techsolutions-bd.com/api/admin/";
myStyle(double size ,[Color? clr,FontWeight? fw]){
  return GoogleFonts.roboto(
    fontSize: size,
    color: clr,
    fontWeight: fw
  );
}