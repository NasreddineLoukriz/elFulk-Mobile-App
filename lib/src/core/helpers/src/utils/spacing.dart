import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(height: height.h);

SizedBox horizontalSpace(double width) => SizedBox(width: width.w);

double screenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height -
    MediaQuery.of(context).padding.top -
    MediaQuery.of(context).padding.bottom;
