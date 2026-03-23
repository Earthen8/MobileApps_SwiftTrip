import 'package:flutter/material.dart';
import '../models/subscription_plan_model.dart';

class SubscriptionService {
  Future<List<SubscriptionPlan>> getPlans() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      SubscriptionPlan(
        id: 'plan_golden',
        name: 'Golden',
        gradientColor: Color(0xFFEAB308),
        buttonLabel: 'Buy Golden Plan',
        isCurrent: false,
        features: [
          PlanFeature(
            text: 'Priority AI Travel Assistant (24/7 real-time support)',
            isHighlighted: true,
          ),
          PlanFeature(
            text:
                'Exclusive mid-tier discounts on flights & hotels (up to 15%)',
            isHighlighted: true,
          ),
          PlanFeature(
            text:
                'Flexible booking options with low-fee reschedule & cancellation',
          ),
          PlanFeature(
            text: 'Early access to flash sales & limited travel deals',
          ),
          PlanFeature(text: 'Earn 2x loyalty points on every transaction'),
        ],
      ),
      SubscriptionPlan(
        id: 'plan_free',
        name: 'Free Plan',
        gradientColor: Color(0xFF84CC16),
        buttonLabel: 'Currently Used',
        isCurrent: true,
        features: [
          PlanFeature(
            text: 'Standard AI Travel Assistant (best-effort support)',
            isHighlighted: true,
          ),
          PlanFeature(text: 'Access to basic discounts (up to 5%)'),
          PlanFeature(text: 'Standard booking with regular fees'),
          PlanFeature(text: 'Standard access to sales and deals'),
          PlanFeature(text: 'Earn 1x loyalty points on every transaction'),
        ],
      ),
      SubscriptionPlan(
        id: 'plan_premium',
        name: 'Premium',
        gradientColor: Color(0xFFEF4444),
        buttonLabel: 'Buy Premium Plan',
        isCurrent: false,
        features: [
          PlanFeature(
            text: 'Premium AI Travel Assistant (24/7 priority support)',
            isHighlighted: true,
          ),
          PlanFeature(
            text: 'Top-tier discounts on flights & hotels (up to 25%)',
            isHighlighted: true,
          ),
          PlanFeature(
            text:
                'Most flexible booking with waived reschedule & cancellation fees',
            isHighlighted: true,
          ),
          PlanFeature(text: 'Priority access to all sales & limited deals'),
          PlanFeature(text: 'Earn 3x loyalty points on every transaction'),
          PlanFeature(text: 'Complimentary travel insurance coverage'),
        ],
      ),
    ];
  }
}
