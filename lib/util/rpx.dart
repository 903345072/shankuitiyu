import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void initScreenUtil(BuildContext constraints) {
  ScreenUtil.init(constraints, designSize: const Size(375, 667));
}

double rpx(double rpx) {
  return ScreenUtil().setWidth(rpx);
}
