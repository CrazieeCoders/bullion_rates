import 'package:flutter/material.dart';


class HeaderClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
      var path = new Path();
      path.lineTo(0, size.height - 30);
      var controlPoint = Offset(50, size.height);
      var endPoint = Offset(size.width / 2, size.height);
      path.quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);


         return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }




}