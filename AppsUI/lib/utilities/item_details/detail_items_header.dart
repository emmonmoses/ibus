import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailItemsHeader extends StatelessWidget {
  const DetailItemsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          FadeInDown(
            delay: const Duration(milliseconds: 100),
            child: Material(
              color: Colors.white.withOpacity(0.21),
              borderRadius: BorderRadius.circular(10),
              child: const BackButton(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: const Text(
              "Trip Detail",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: Material(
              color: Colors.white.withOpacity(0.21),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/heart.svg',
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
