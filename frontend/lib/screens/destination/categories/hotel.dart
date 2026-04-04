import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../services/destination_service.dart';
import '../category_page_base.dart';
import '../detail_page.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  bool _isLoading = true;
  List<DestinationModel> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    final hotels = await DestinationService().getHotelDestinations();
    if (!mounted) return;
    setState(() {
      _items = hotels;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Popular Hotels',
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
