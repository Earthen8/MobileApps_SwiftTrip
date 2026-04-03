import 'package:flutter/material.dart';
import '../category_page_base.dart';
import '../services/destination_service.dart';
import '../detail_page.dart';

class SleekSearchPage extends StatelessWidget {
  const SleekSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Sleek',
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
