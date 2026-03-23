import 'package:flutter/material.dart';
import '../profile/profile.dart';
import 'models/subscription_plan_model.dart';
import 'services/subscription_service.dart';
import 'widgets/subscription/sub_top_bar.dart';
import 'widgets/subscription/plan_card.dart';
import 'widgets/subscription/sub_bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SUBSCRIPTION PLAN SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  List<SubscriptionPlan> _plans = [];
  bool _isLoading = true;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchPlans();
  }

  Future<void> _fetchPlans() async {
    try {
      final plans = await _subscriptionService.getPlans();
      if (mounted) {
        setState(() {
          _plans = plans;
          _isLoading = false;
          // Set initial index to the current plan if found
          final currentIdx = plans.indexWhere((p) => p.isCurrent);
          if (currentIdx != -1) _currentIndex = currentIdx;
        });
      }
    } catch (e) {
      debugPrint('Error fetching plans: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F1F3D),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (_plans.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F1F3D),
        body: Center(
          child: Text(
            'No plans available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    // Sort plans so the active card always renders last (on top)
    List<MapEntry<int, SubscriptionPlan>> sortedPlans = _plans
        .asMap()
        .entries
        .toList();
    sortedPlans.sort((a, b) {
      if (a.key == _currentIndex) return 1;
      if (b.key == _currentIndex) return -1;
      return 0;
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F1F3D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubTopBar(),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: Text(
              'Subscription Plan',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(color: Color(0xFF0E121E), height: 24),
          ),

          // ── Stacked Cards Layout ─────────────────────────────────────────
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: sortedPlans.map((entry) {
                final int i = entry.key;
                final plan = entry.value;
                final bool isActive = i == _currentIndex;

                int diff = i - _currentIndex;
                if (diff < -1) diff += _plans.length;
                if (diff > 1) diff -= _plans.length;

                // 1.3 pushes the rear cards to overflow the screen edges
                final alignment = Alignment(diff * 1.3, 0.0);

                return AnimatedAlign(
                  key: ValueKey(plan.id),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  alignment: alignment,
                  child: AnimatedScale(
                    scale: isActive ? 1.0 : 0.85,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    child: GestureDetector(
                      onTap: () {
                        if (!isActive) setState(() => _currentIndex = i);
                      },
                      child: PlanCard(plan: plan, isActive: isActive),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
          const SubBottomNavBar(),
        ],
      ),
    );
  }
}
