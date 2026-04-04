import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../services/destination_service.dart';
import '../category_page_base.dart';
import '../detail_page.dart';

class MoodySearchPage extends StatelessWidget {
  const MoodySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DestinationModel>>(
      future: DestinationService().fetchByTag('Moody'),
      builder: (context, snapshot) {
        return CategoryPageBase(
          title: 'Moody',
          isLoading: snapshot.connectionState == ConnectionState.waiting,
          items: snapshot.data ?? [],
          onItemTap: (item) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinationDetailPage(destination: item),
              ),
            );
          },
        );
      },
    );
  }
}
