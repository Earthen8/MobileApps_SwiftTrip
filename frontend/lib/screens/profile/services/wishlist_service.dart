import '../../destination/models/destination_model.dart';

class WishlistService {
  Future<List<DestinationModel>> getWishlistItems() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      DestinationModel(
        id: 'item_1',
        title: 'The Edge Bali Villa - Uluwatu',
        rating: 4.9,
        description:
            'Luxury cliffside villa with private pool and panoramic Indian Ocean views.',
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
        price: 15000000,
        features: ['Cliffside Villa', 'Private Pool', 'Ocean View'],
        isFavorite: true,
      ),
      DestinationModel(
        id: 'item_2',
        title: 'Plataran Komodo Resort - Labuan Bajo',
        rating: 4.8,
        description: 'Beachfront resort near Komodo with clear turquoise waters.',
        imageUrl: 'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=500',
        price: 8500000,
        features: ['Beachfront', 'Komodo View', 'Turquoise Water'],
        isFavorite: true,
      ),
      DestinationModel(
        id: 'item_3',
        title: 'Padma Hotel Bandung - Ciumbuleuit',
        rating: 4.8,
        description:
            'Mountain-view hotel with cool climate, infinity pool, and forest atmosphere.',
        imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=500',
        price: 2500000,
        features: ['Mountain View', 'Infinity Pool', 'Forest Vibe'],
        isFavorite: true,
      ),
      DestinationModel(
        id: 'item_4',
        title: 'Ayana Resort - Jimbaran Bali',
        rating: 4.9,
        description:
            'Famous luxury resort with Rock Bar and stunning sunset ocean views.',
        imageUrl: 'https://images.unsplash.com/photo-1505739771715-9c3fcd5f1b38?w=500',
        price: 7000000,
        features: ['Rock Bar', 'Sunset View', 'Jimbaran Bay'],
        isFavorite: true,
      ),
      DestinationModel(
        id: 'item_5',
        title: 'The Ritz-Carlton Jakarta - Mega Kuningan',
        rating: 4.7,
        description:
            'High-end city hotel with premium service in the heart of Jakarta business district.',
        imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=500',
        price: 3500000,
        features: ['Mega Kuningan', 'Premium Service', 'City Hotel'],
        isFavorite: true,
      ),
    ];
  }
}
