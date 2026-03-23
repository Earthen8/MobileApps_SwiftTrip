import 'package:flutter/material.dart';
import 'widgets/destination_section.dart';
import 'search/cozy.dart';
import 'search/airy.dart';
import 'search/moody.dart';
import 'search/sleek.dart';
import 'services/destination_service.dart';
import 'models/destination_model.dart';

class DestinationSearchPage extends StatefulWidget {
  const DestinationSearchPage({super.key});

  @override
  State<DestinationSearchPage> createState() => _DestinationSearchPageState();
}

class _DestinationSearchPageState extends State<DestinationSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final DestinationService _service = DestinationService();

  late final List<String> _trendingTags;
  late final List<DestinationModel> _recentSearches;
  late final List<DestinationModel> _topRated;
  late final List<DestinationModel> _hotDestinations;

  @override
  void initState() {
    super.initState();
    _trendingTags = _service.getTrendingTags();
    _recentSearches = _service.getRecentSearches();
    _topRated = _service.getTopRated();
    _hotDestinations = _service.getHotDestinations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // ── Search bar row with back button ───────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (val) {
                          setState(() {});
                          // TODO: Trigger search API with debounce on val
                        },
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Looking For Something?', // TODO: Create search page
                          hintStyle: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF9E9E9E),
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── People are looking for ──────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'People are looking for...',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 8,
                        children: List.generate(_trendingTags.length, (i) {
                          final tagLabel = _trendingTags[i];

                          return GestureDetector(
                            onTap: () {
                              _searchController.text = tagLabel;

                              Widget? targetPage;
                              if (tagLabel == 'Cozy') {
                                targetPage = const CozySearchPage();
                              } else if (tagLabel == 'Airy') {
                                targetPage = const AirySearchPage();
                              } else if (tagLabel == 'Moody') {
                                targetPage = const MoodySearchPage();
                              } else if (tagLabel == 'Sleek') {
                                targetPage = const SleekSearchPage();
                              }

                              if (targetPage != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => targetPage!,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B99E3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tagLabel,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(
                      color: Color(0xFF404040),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 16),

                    // ── Recent Searches ─────────────────────────────
                    DestinationSection(
                      title: 'Recent Searches',
                      items: _recentSearches,
                    ),

                    // ── Top Rated ───────────────────────────────────
                    DestinationSection(title: 'Top Rated', items: _topRated),

                    // ── Hot Destinations ────────────────────────────
                    DestinationSection(
                      title: 'Hot Destinations',
                      items: _hotDestinations,
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
