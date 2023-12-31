import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils/widget/WAColors.dart';




class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
        color: WAPrimaryColor,
        size: 30
    );
  }
}
