import 'package:flutter/material.dart';
import '../category_page_base.dart';
import '../services/destination_service.dart';
import '../detail_page.dart';

class CozySearchPage extends StatelessWidget {
  const CozySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Cozy',
      items: DestinationService().getHotDestinations(), // Fallback to Hot for now
      onItemTap: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DestinationDetailPage(destination: item)),
        );
      },
    );
  }
}
