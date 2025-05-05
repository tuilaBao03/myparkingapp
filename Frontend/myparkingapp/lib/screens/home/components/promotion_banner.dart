// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../components/scalton/scalton_rounded_container.dart';

import '../../../constants.dart';

class PromotionBanner extends StatefulWidget {
  const PromotionBanner({super.key});

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: isLoading
          ? const AspectRatio(
              aspectRatio: 1.97,
              child: ScaltonRoundedContainer(radious: 12),
            )
          : Material(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.4),
            color: Colors.transparent,

            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.asset("assets/images/Banner.png"),
              ),
          ),
    );
  }
}
