

import 'package:flutter/material.dart';
import 'package:myparkingapp/data/response/service.dart';

import '../../../components/cards/medium/Service_info_medium_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';




class ServiceCardList extends StatefulWidget {
  final List<Service> services;

  const ServiceCardList({super.key, required this.services, });

  @override
  State<ServiceCardList> createState() => _ServiceCardListState();
}

class _ServiceCardListState extends State<ServiceCardList> {
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
    // only for demo
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 254,
          child: isLoading
              ? buildFeaturedPartnersLoadingIndicator()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.services.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: (widget.services.length - 1) == index ? defaultPadding : 0,
                    ),
                    child: ServiceInfoMediumCard(
                      image: widget.services[index].image,
                      name: widget.services[index].name,
                      description: widget.services[index].description,
                      version: widget.services[index].version,
                      press: widget.services[index].press,

                    )
                  ),
                ),
        ),
      ],
    );
  }

  SingleChildScrollView buildFeaturedPartnersLoadingIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: MediumCardScalton(),
          ),
        ),
      ),
    );
  }
}
