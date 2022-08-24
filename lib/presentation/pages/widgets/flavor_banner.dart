import 'package:flutter/material.dart';

import '../../../flavors.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (F.appFlavor == Flavor.DEV) {
      return Banner(
        message: 'DEV',
        location: BannerLocation.topEnd,
        color: Colors.deepPurple,
        child: child,
      );
    }
    return child ?? const SizedBox();
  }
}
