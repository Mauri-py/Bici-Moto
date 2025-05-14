import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Indicadores extends StatelessWidget {
  const Indicadores({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/left_indicator.svg",
            height: 32,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/head_light.svg",
            height: 32,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/dipper.svg",
            height: 32,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/right_indicator.svg",
            height: 32,
          ),
        ),
      ],
    );
  }
}
