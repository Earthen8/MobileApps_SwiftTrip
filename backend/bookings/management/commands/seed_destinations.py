import random
from decimal import Decimal
from django.core.management.base import BaseCommand
from bookings.models import Destination

class Command(BaseCommand):
    help = 'Seeds the database with over 20 unique destinations.'

    def handle(self, *args, **kwargs):
        self.stdout.write("Deleting existing destinations...")
        Destination.objects.all().delete()

        destinations_data = [
            # Discount (Mostly hotels/apartments)
            {"title": "Ocean View Hotel", "category": "Hotel", "location": "Bali, Indonesia", "rating": "4.8", "original_price": "1200000", "discount_percentage": 25, "section_tag": "Discount", "q": "hotel,ocean"},
            {"title": "City Center Apartment", "category": "Apartment", "location": "Jakarta, Indonesia", "rating": "4.2", "original_price": "850000", "discount_percentage": 15, "section_tag": "Discount", "q": "apartment,city"},
            {"title": "Mountain Retreat Condo", "category": "Condo", "location": "Bandung, Indonesia", "rating": "4.5", "original_price": "1500000", "discount_percentage": 30, "section_tag": "Discount", "q": "condo,mountain"},
            {"title": "Lakeside Villa", "category": "Villa", "location": "Lake Toba, Indonesia", "rating": "4.7", "original_price": "2500000", "discount_percentage": 40, "section_tag": "Discount", "q": "villa,lake"},
            {"title": "Budget Inn", "category": "Hotel", "location": "Yogyakarta, Indonesia", "rating": "4.0", "original_price": "400000", "discount_percentage": 10, "section_tag": "Discount", "q": "hotel,budget"},
            {"title": "Cozy Studio", "category": "Apartment", "location": "Surabaya, Indonesia", "rating": "4.3", "original_price": "600000", "discount_percentage": 20, "section_tag": "Discount", "q": "apartment,cozy"},
            {"title": "Sunrise Resort", "category": "Hotel", "location": "Lombok, Indonesia", "rating": "4.9", "original_price": "1800000", "discount_percentage": 35, "section_tag": "Discount", "q": "resort,beach"},

            # Favorite (High ratings)
            {"title": "Luxury Private Villa", "category": "Villa", "location": "Ubud, Bali", "rating": "5.0", "original_price": "4500000", "discount_percentage": 0, "section_tag": "Favorite", "q": "villa,luxury"},
            {"title": "Heritage Hotel", "category": "Hotel", "location": "Semarang, Indonesia", "rating": "4.8", "original_price": "1100000", "discount_percentage": 0, "section_tag": "Favorite", "q": "hotel,heritage"},
            {"title": "Skyline Condo", "category": "Condo", "location": "Jakarta, Indonesia", "rating": "4.7", "original_price": "2000000", "discount_percentage": 0, "section_tag": "Favorite", "q": "condo,skyline"},
            {"title": "Forest Cabin", "category": "Villa", "location": "Lembang, Bandung", "rating": "4.9", "original_price": "1300000", "discount_percentage": 0, "section_tag": "Favorite", "q": "cabin,forest"},
            {"title": "Beachfront Apartment", "category": "Apartment", "location": "Canggu, Bali", "rating": "4.8", "original_price": "1600000", "discount_percentage": 0, "section_tag": "Favorite", "q": "apartment,beach"},
            {"title": "Historic Guesthouse", "category": "Hotel", "location": "Yogyakarta, Indonesia", "rating": "4.7", "original_price": "550000", "discount_percentage": 0, "section_tag": "Favorite", "q": "guesthouse,historic"},
            {"title": "Infinity Pool Villa", "category": "Villa", "location": "Uluwatu, Bali", "rating": "5.0", "original_price": "5000000", "discount_percentage": 0, "section_tag": "Favorite", "q": "villa,pool"},

            # Hot (Trendy, slightly discounted or normal)
            {"title": "Tropical Paradise Resort", "category": "Hotel", "location": "Nusa Penida, Bali", "rating": "4.6", "original_price": "2200000", "discount_percentage": 5, "section_tag": "Hot", "q": "resort,tropical"},
            {"title": "Downtown Loft", "category": "Apartment", "location": "Jakarta, Indonesia", "rating": "4.5", "original_price": "950000", "discount_percentage": 0, "section_tag": "Hot", "q": "apartment,loft"},
            {"title": "Eco Bamboo Villa", "category": "Villa", "location": "Munduk, Bali", "rating": "4.8", "original_price": "1800000", "discount_percentage": 10, "section_tag": "Hot", "q": "villa,bamboo"},
            {"title": "Riverbank Hotel", "category": "Hotel", "location": "Kalimantan, Indonesia", "rating": "4.4", "original_price": "750000", "discount_percentage": 0, "section_tag": "Hot", "q": "hotel,river"},
            {"title": "Minimalist Studio", "category": "Condo", "location": "Bandung, Indonesia", "rating": "4.5", "original_price": "800000", "discount_percentage": 0, "section_tag": "Hot", "q": "condo,minimalist"},
            {"title": "Cliffside Retreat", "category": "Villa", "location": "Sumba, Indonesia", "rating": "4.9", "original_price": "3500000", "discount_percentage": 15, "section_tag": "Hot", "q": "villa,cliff"},
            {"title": "Volcano View Hotel", "category": "Hotel", "location": "Mt Bromo, Indonesia", "rating": "4.6", "original_price": "1000000", "discount_percentage": 0, "section_tag": "Hot", "q": "hotel,volcano"},
        ]

        destinations_to_create = []
        for index, data in enumerate(destinations_data):
            # Using unsplash source with random sig to bypass caching if needed
            image_url = f"https://source.unsplash.com/featured/?{data['q']}&sig={index}"
            
            destinations_to_create.append(
                Destination(
                    title=data["title"],
                    category=data["category"],
                    image_url=image_url,
                    location=data["location"],
                    rating=Decimal(data["rating"]),
                    original_price=Decimal(data["original_price"]),
                    discount_percentage=data["discount_percentage"],
                    description=f"A beautiful {data['category'].lower()} located in {data['location']}. Features exquisite views and amenities.",
                    advantages=["Free WiFi", "Breakfast Included", "Pool Access"], # Randomize or keep static
                    section_tag=data["section_tag"]
                )
            )

        Destination.objects.bulk_create(destinations_to_create)
        self.stdout.write(self.style.SUCCESS(f"Successfully seeded {len(destinations_to_create)} destinations!"))
