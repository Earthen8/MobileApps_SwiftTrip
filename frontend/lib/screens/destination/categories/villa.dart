import 'package:flutter/material.dart';
import '../models/destination_model.dart';
import '../category_page_base.dart';
import '../detail_page.dart';
import 'package:dio/dio.dart';
import '../../../core/constants.dart';

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
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.travelUrl}destinations/',
        queryParameters: {'category': 'Villa'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        if (!mounted) return;
        setState(() {
          _items = data.map((json) => DestinationModel.fromJson(json)).toList();
          _isLoading = false;
        });
      }
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
