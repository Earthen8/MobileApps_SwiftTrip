# SwiftTrip

**Tagline:** An AI powered travel companion for seamless booking and discovery.

---

## 1. Project Overview
SwiftTrip is a comprehensive travel application designed to simplify the journey of modern travelers. By integrating advanced AI capabilities with real-time travel data, SwiftTrip offers a unified platform for searching, booking, and managing flights, land transport, and accommodations.

**Target Audience:** Travelers looking for a one-stop-shop for flights, land transport (bus, train, car), and local accommodations with AI-driven guidance.

## 2. Core Features
- **AI Smart Assistant:** A Gemini-powered chat interface that intelligently routes user intents—ranging from travel searches to app support—towards specific services or actions.
- **Multi-Modal Transport Search:** Unified searching experience for:
    - **Flights:** Real-time data and pricing via the Amadeus API.
    - **Land Transport:** Buses, Trains, and Cars powered by specialized Mock Services for consistent simulation.
- **Dynamic Mapping:** Interactive map integration using OpenStreetMap. Coordinates (latitude and longitude) are injected at the source and persist through the booking lifecycle to be rendered on the interactive "Next Trip" map.
- **Cart and Checkout:** A robust, state-managed system (via Provider) that handles multiple travel items and facilitates a seamless finalization of transactions.
- **Destination Discovery:** Curated recommendations for hotels and vacation spots, complete with detailed descriptions and visuals.

## 3. Technology Stack
- **Frontend:** [Flutter](https://flutter.dev/) (v3.x) utilizing **Provider** for efficient state management.
- **Backend:** [Django REST Framework (DRF)](https://www.django-rest-framework.org/) for scalable API development.
- **AI Integration:** [Google Gemini](https://ai.google.dev/) (`gemini-2.5-flash`) for natural language intent routing and consultation.
- **External APIs:** [Amadeus API](https://developers.amadeus.com/) for real-time global flight data.
- **Maps:** Flutter Map using [OpenStreetMap](https://www.openstreetmap.org/) tiles for interactive destination visualization.

## 4. Architecture and Data Flow
- **AI Intent Routing:** The `GeminiChatView` (Backend) analyzes user messages to determine if the intent is a search (`SEARCH`), travel consultation (`CONSULTATION`), or technical support (`SUPPORT`).
- **Coordinate Pipeline:** Latitude and longitude are captured during the search phase (via `AmadeusService` or `MockVehicleService`) and persisted through the `CartTicket` model. These are eventually rendered dynamically on the `NextTripPage` map.
- **Service Layer:** Decoupled service architecture ensures modularity.
    - **Python:** `AmadeusService`, `MockLandService`, and `ChatService`.
    - **Dart:** `CartService`, `AirportSearchService`, and various API providers.

## 5. Setup and Installation

### Backend (Django)
1. Navigate to the `backend/` folder.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Configure your `.env` file (refer to `.env.example`):
   - `AMADEUS_API_KEY` & `AMADEUS_API_SECRET`
   - `GEMINI_API_KEY`
4. Run migrations:
   ```bash
   python manage.py migrate
   ```
5. Start the server:
   ```bash
   python manage.py runserver 0.0.0.0:8000
   ```

### Frontend (Flutter)
1. Navigate to the `frontend/` folder.
2. Install packages:
   ```bash
   flutter pub get
   ```
3. Update the **Base URL** in `lib/core/constants.dart` to match your local machine's IP address (for physical device testing) or `10.0.2.2` (for Android Emulator).
4. Run the app:
   ```bash
   flutter run
   ```

## 6. Key Configuration Files
- **`backend/support/views.py`**: Contains the core AI routing logic, persona rules, and system instructions for the Gemini model.
- **`frontend/lib/screens/cart/models/cart_models.dart`**: Defines the unified data structure for all travel items (flights, land, and accommodations).
- **`backend/travel_data/services/amadeus_service.py`**: Manages real-time flight search logic and coordinate extraction.
- **`frontend/lib/screens/searching/services/airport_search_service.dart`**: The frontend source of truth for city and airport coordinate mapping.
- **`frontend/lib/core/constants.dart`**: Global configuration for API endpoints and primary app settings.

## 7. Project Structure
```text
swifttrip/
├── backend/                # Django REST API
│   ├── support/            # AI Chat and Support Ticketing
│   ├── travel_data/        # Amadeus/Mock Services logic
│   ├── bookings/           # Cart and Transaction models
│   └── users/              # Authentication and Profiles
└── frontend/               # Flutter Application
    ├── lib/core/           # Constants and Themes
    ├── lib/providers/      # State Management (Cart, Auth)
    ├── lib/screens/        # Main App Screens
    └── lib/widgets/        # Reusable UI Components
```

## 8. Team Members
- **Lead Full Stack Developer:** Earthen | [github.com/Earthen8](https://github.com/Earthen8)
- **UI Collaborator:** Hansel | [github.com/hanselrichie](https://github.com/hanselrichie)

---
*Created for the College Mobile App Development Project.*
