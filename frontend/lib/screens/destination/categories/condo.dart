import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../services/destination_service.dart';
import '../category_page_base.dart';
import '../detail_page.dart';

class CondoPage extends StatefulWidget {
  const CondoPage({super.key});

  @override
  State<CondoPage> createState() => _CondoPageState();
}

class _CondoPageState extends State<CondoPage> {
  bool _isLoading = true;
  List<DestinationModel> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchCondos();
  }

  Future<void> _fetchCondos() async {
    final condos = DestinationService().getCondoDestinations();
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _items = condos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Popular Condos',
      items: _items,
      isLoading: _isLoading,
      onItemTap: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(destination: item),
          ),
        );
      },
    );
  }
}
