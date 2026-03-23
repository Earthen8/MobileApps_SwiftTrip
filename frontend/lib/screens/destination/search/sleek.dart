import 'package:flutter/material.dart';
import '../category_page_base.dart';
import '../detail_page.dart';
import '../models/destination_model.dart';

class SleekSearchPage extends StatefulWidget {
  const SleekSearchPage({super.key});

  @override
  State<SleekSearchPage> createState() => _SleekSearchPageState();
}

class _SleekSearchPageState extends State<SleekSearchPage> {
  bool _isLoading = true;
  List<DestinationModel> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchSleekPlaces();
  }

  Future<void> _fetchSleekPlaces() async {
    // TODO: Replace with real API call: GET /destinations?vibe=sleek
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _items = [
        DestinationModel(
          id: 'sl-1',
          name: 'The Langham Jakarta',
          imageUrl:
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=500',
          rating: 4.9,
          description: 'Ultra-modern luxury with sharp city views.',
          price: 4500000,
          features: ['SCBD View', 'Ultra-modern', 'Luxury'],
          isFavorite: true,
        ),
        DestinationModel(
          id: 'sl-2',
          name: 'Potato Head Suites',
          imageUrl:
              'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?w=500',
          rating: 4.7,
          description: 'Avant-garde architecture and sleek beach club vibes.',
          price: 5200000,
          features: ['Beach Club', 'Avant-garde Arch'],
          hasDiscount: true,
        ),
        DestinationModel(
          id: 'sl-3',
          name: 'Alila Solo',
          imageUrl:
              'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=500',
          rating: 4.8,
          description: 'High-rise minimalist design with sharp horizons.',
          price: 2100000,
          features: ['High-rise', 'Minimalist', 'Solo View'],
        ),
        DestinationModel(
          id: 'sl-4',
          name: 'W Bali - Seminyak',
          imageUrl:
              'https://images.unsplash.com/photo-1582719478250-c89cae4df85b?w=500',
          rating: 4.8,
          description: 'Vibrant and sleek design for the modern traveler.',
          price: 6500000,
          features: ['Vibrant Design', 'Beach Front'],
          isFavorite: true,
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CategoryPageBase(
      title: 'Sleek Spots',
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
