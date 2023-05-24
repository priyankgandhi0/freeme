import 'package:flutter/material.dart';
import '../../globle.dart';

class AuthBackGround extends StatelessWidget {
  final Widget? child;

  const AuthBackGround({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FmImage.assetImage(
          path: Assets.iconsAppLogo,
          fit: BoxFit.contain,
          width: 181.sw(),
          height: 67.sh(),
        ).paddingOnly(
          left: 124.sw(),
          right: 124.sw(),
          top: 80.sh(),
          bottom: 40.sh(),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: backGroundWhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
            ),
            child: child!,
          ),
        )
      ],
    );
  }
}
