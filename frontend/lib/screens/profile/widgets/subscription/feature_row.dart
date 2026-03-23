import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/subscription_plan_model.dart';

class FeatureRow extends StatelessWidget {
  final PlanFeature feature;
  final Color accentColor;

  const FeatureRow({super.key, required this.feature, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: OverflowBox(
              maxWidth: 55,
              maxHeight: 55,
              child: feature.isHighlighted
                  ? SvgPicture.string(
                      '''<svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
<g filter="url(#filter0_d_478_1279)">
<path d="M36.5124 22.5924V19.5024C36.5124 18.9524 36.0624 18.5024 35.5124 18.5024H32.4224L30.2124 16.2924C30.1199 16.1997 30.01 16.1262 29.8891 16.076C29.7681 16.0258 29.6384 16 29.5074 16C29.3765 16 29.2468 16.0258 29.1258 16.076C29.0048 16.1262 28.895 16.1997 28.8024 16.2924L26.5924 18.5024H23.5024C22.9524 18.5024 22.5024 18.9524 22.5024 19.5024V22.5924L20.2924 24.8024C20.1997 24.895 20.1262 25.0048 20.076 25.1258C20.0258 25.2468 20 25.3765 20 25.5074C20 25.6384 20.0258 25.7681 20.076 25.8891C20.1262 26.01 20.1997 26.1199 20.2924 26.2124L22.5024 28.4224V31.5124C22.5024 32.0624 22.9524 32.5124 23.5024 32.5124H26.5924L28.8024 34.7224C29.0024 34.9224 29.2524 35.0124 29.5124 35.0124C29.7724 35.0124 30.0224 34.9124 30.2224 34.7224L32.4324 32.5124H35.5224C36.0724 32.5124 36.5224 32.0624 36.5224 31.5124V28.4224L38.7324 26.2124C38.8251 26.1199 38.8987 26.01 38.9489 25.8891C38.9991 25.7681 39.0249 25.6384 39.0249 25.5074C39.0249 25.3765 38.9991 25.2468 38.9489 25.1258C38.8987 25.0048 38.8251 24.895 38.7324 24.8024L36.5224 22.5924H36.5124ZM28.0984 29.9224L24.8024 26.38L26.5173 24.5368L28.0862 26.2231L32.0876 21.9224L33.8024 23.7656L28.0741 29.9224H28.0984Z" fill="#FFCC00"/>
</g>
<defs>
<filter id="filter0_d_478_1279" x="0" y="0" width="59.0249" height="59.0125" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4"/>
<feGaussianBlur stdDeviation="10"/>
<feComposite in2="hardAlpha" operator="out"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_478_1279"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_478_1279" result="shape"/>
</filter>
</defs>
</svg>''',
                      width: 65,
                      height: 65,
                    )
                  : SvgPicture.string(
                      '''<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
<g filter="url(#filter0_d_478_1261)">
<path d="M18 6C13.5817 6 10 9.58175 10 14C10 18.4185 13.5817 22 18 22C22.4185 22 26 18.4185 26 14C26 9.58175 22.4185 6 18 6ZM18 21.0157C14.1403 21.0157 11 17.8597 11 14C11 10.1402 14.1403 6.99997 18 6.99997C21.8597 6.99997 25 10.1402 25 14C25 17.8597 21.8597 21.0157 18 21.0157ZM21.1927 11.0728L16.499 15.796L14.3852 13.6823C14.19 13.487 13.8735 13.487 13.678 13.6823C13.4827 13.8775 13.4827 14.194 13.678 14.3892L16.1527 16.8643C16.348 17.0592 16.6645 17.0592 16.86 16.8643C16.8825 16.8418 16.9018 16.8172 16.9193 16.7917L21.9003 11.78C22.0953 11.5847 22.0953 11.2682 21.9003 11.0728C21.7048 10.8775 21.3883 10.8775 21.1927 11.0728Z" fill="white"/>
</g>
<defs>
<filter id="filter0_d_478_1261" x="0" y="0" width="36" height="36" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="4"/>
<feGaussianBlur stdDeviation="5"/>
<feComposite in2="hardAlpha" operator="out"/>
<feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 1 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_478_1261"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_478_1261" result="shape"/>
</filter>
</defs>
</svg>''',
                      width: 40,
                      height: 40,
                    ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              feature.text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
