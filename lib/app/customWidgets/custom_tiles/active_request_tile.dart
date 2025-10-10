import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/custom_cache_image/custom_cached_image.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';

class ActiveRequestTile extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? totalPayment;
  final String? collectedPayment;
  final String? supporters;
  final String? priority;

  const ActiveRequestTile({super.key, this.image, this.title, this.description, this.totalPayment, this.collectedPayment, this.supporters, this.priority});

  @override
  Widget build(BuildContext context) {
    double percentage = 0;
    if (totalPayment != null && collectedPayment != null) {
      final total = double.tryParse(totalPayment!) ?? 0;
      final collected = double.tryParse(collectedPayment!) ?? 0;
      if (total > 0) {
        percentage = (collected / total) * 100;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6.sp),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomCachedImage(height: 130.h, width: 112.w, imageUrl: image ?? '', borderRadius: 4.sp),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(50.sp),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Text(
                      priority ?? '',
                      style: AppTextStyles.customText12(color: Colors.white, fontWeight: FontWeight.w500),
                    ).paddingHorizontal(10.w).paddingVertical(4.h),
                  ),
                ),
              ),
            ],
          ),
          10.w.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                5.h.height,
                Text(
                  description ?? '',
                  style: AppTextStyles.customText14(color: Colors.black.withOpacity(0.6), height: 1.2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                12.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$collectedPayment',
                      style: AppTextStyles.customText12(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'of \$$totalPayment',
                      style: AppTextStyles.customText12(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                5.h.height,
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.textLightBlack.withOpacity(0.1),
                    thumbColor: Colors.green,
                    trackHeight: 6.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                    overlayColor: AppColors.primary,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    padding: EdgeInsets.zero,
                    value: double.parse(collectedPayment.toString()),
                    min: 0.0,
                    max: double.parse(totalPayment.toString()),
                    divisions: 100,
                    onChanged: (double value) {},
                  ),
                ),
                8.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$percentage% Funded",
                      style: AppTextStyles.customText12(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${supporters ?? 0} supporters",
                      style: AppTextStyles.customText12(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingFromAll(6.sp),
    );
  }
}
