import 'package:cooki/common/component/app_images.dart';
import 'package:flutter/material.dart';

enum Certification {
  usda(
    label: 'USDA Organic',
    description:
        'This label indicates that the product is grown and processed according to federal guidelines that promote ecological balance, conserve biodiversity, and reduce reliance on synthetic fertilizers and pesticides, supporting sustainable farming practices.',
  ),
  fairTrade(
    label: 'Fair Trade Certified',
    description:
        'This label ensures that farmers and workers are paid fair wages and work in safe conditions, while also promoting environmental sustainability by encouraging organic farming and reducing harmful chemicals.',
  ),
  rfa(
    label: 'Rainforest Alliance Certified',
    description:
        'Products with this label are sourced from farms that meet comprehensive standards for environmental protection, including biodiversity conservation, soil and water management, and forest preservation.',
  ),
  gmoFree(
    label: 'Non-GMO Project Verified',
    description:
        'This label verifies that a product is made without genetically modified organisms, which supports traditional agricultural practices and biodiversity, potentially reducing the environmental impact of farming.',
  ),
  msc(
    label: 'MSC Certified Sustainable Seafood',
    description:
        'The Marine Stewardship Council label ensures that seafood is caught using methods that maintain fish populations and protect marine ecosystems, promoting long-term ocean sustainability.',
  ),
  bCorp(
    label: 'B Corp Certified',
    description:
        'Companies with this certification meet high standards of social and environmental performance, transparency, and accountability, often using sustainable sourcing and reducing their carbon footprint.',
  ),
  fsc(
    label: 'FSC Certified',
    description:
        'This label on paper and wood products ensures that they come from responsibly managed forests that provide environmental, social, and economic benefits, helping to protect forests and biodiversity.',
  ),
  ewg(
    label: 'EWG Verified',
    description:
        "Products with this label meet the Environmental Working Group's strict standards for health and environmental safety, ensuring that they are free from harmful chemicals and support a cleaner, more sustainable environment.",
  ),
  locallyGrown(
    label: 'Locally Grown',
    description:
        'This label indicates that the product was grown or produced nearby, reducing the carbon footprint associated with transportation, supporting local economies, and often promoting sustainable farming practices tailored to the local environment.',
  ),
  plantBased(
    label: 'Plant-Based',
    description:
        'This label signifies that the product is made entirely from plants, which typically requires fewer resources like water and land and generates lower greenhouse gas emissions compared to animal-based products, contributing to environmental sustainability.',
  );

  const Certification({
    required this.label,
    required this.description,
  });

  final String label;
  final String description;

  Image get image => switch (this) {
        usda => AppImages.usdaOrganic,
        fairTrade => AppImages.fairTrade,
        rfa => AppImages.rainforestAlliance,
        gmoFree => AppImages.gmoFree,
        msc => AppImages.msc,
        bCorp => AppImages.bCorp,
        fsc => AppImages.fsc,
        ewg => AppImages.ewg,
        locallyGrown => AppImages.locallyGrown,
        plantBased => AppImages.plantBased,
      };
}
