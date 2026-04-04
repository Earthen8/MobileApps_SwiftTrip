import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../category_page_base.dart';
import '../detail_page.dart';
import '../services/destination_service.dart';

class VillaPage extends StatefulWidget {
  const VillaPage({super.key});

  @override
  State<VillaPage> createState() => _VillaPageState();
}

class _VillaPageState extends State<VillaPage> {
  bool _isLoading = true;
  List<DestinationModel> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchVillas();
  }

  Future<void> _fetchVillas() async {
    try {
      final items = await DestinationService().getVillaDestinations();
      if (!mounted) return;
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching villas: $e');
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Popular Villas',
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
