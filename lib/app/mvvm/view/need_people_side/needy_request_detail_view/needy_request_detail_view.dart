import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/app_custom_button.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/custom_cache_image/custom_cached_image.dart';
import 'package:open_palms/app/customWidgets/custom_loader.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/needy_request_detail_controller.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_text_style.dart';
import '../../../../config/utils.dart';
import '../../../../customWidgets/custom_dialogs/car_images_dialog.dart';

class NeedyRequestDetailView extends StatefulWidget {
  const NeedyRequestDetailView({super.key});

  @override
  State<NeedyRequestDetailView> createState() => _NeedyRequestDetailViewState();
}

class _NeedyRequestDetailViewState extends State<NeedyRequestDetailView> {
  final NeedyRequestDetailController controller = Get.find();
  String? requestId;

  @override
  void initState() {
    requestId = Get.arguments['requestId'];
    controller.getRequestDetails(requestId ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isDetailLoading.value
          ? Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              color: Colors.white,
              child: Center(child: CustomLoader()),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                title: controller.requestDetail?.request?.status == 'completed' ? 'History Details' : 'Details',
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      15.h.height,
                      Stack(
                        children: [
                          Obx(() {
                            final mainImage = controller.requestDetail?.request?.images?[controller.currentIndex.value];
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 600),
                              child: GestureDetector(
                                onTap: () {
                                  Utils.showCustomDialog(
                                    context: context,
                                    child: JobImagesDialog(
                                      imageUrls: controller.requestDetail?.request?.images ?? [],
                                      initialIndex: controller.currentIndex.value,
                                    ),
                                  );
                                },
                                child: CustomCachedImage(
                                  key: ValueKey<String>(mainImage ?? ''),
                                  imageUrl: mainImage ?? '',
                                  width: double.infinity,
                                  height: 250.h,
                                  borderRadius: 5.sp,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 10.h,
                            right: 10.w,
                            child: Obx(() {
                              final mainImage = controller.requestDetail?.request?.images?[controller.currentIndex.value];
                              final thumbnails = controller.requestDetail?.request?.images?.where((img) => img != mainImage).toList();
                              return SizedBox(
                                height: 170.h,
                                child: Column(
                                  children: List.generate(3, (index) {
                                    final thumb = thumbnails?[index];
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          final index = controller.requestDetail?.request?.images?.indexOf(thumb ?? '') ?? -1;
                                          if (index >= 0) {
                                            controller.changeImage(index);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 5.h), // spacing
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18.sp),
                                              border: Border.all(color: Colors.white, width: 2),
                                            ),
                                            child: CustomCachedImage(
                                              imageUrl: thumb ?? '',
                                              height: double.infinity,
                                              borderRadius: 16.sp,
                                              fit: BoxFit.cover,
                                              width: 50.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }),
                          ),
                          Positioned(
                            top: 10.h,
                            right: 10.w,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(50.sp),
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                              ),
                              child: Center(
                                child: Text(
                                  controller.requestDetail?.request?.priority ?? 'N/A',
                                  style: AppTextStyles.customText14(color: Colors.white, fontWeight: FontWeight.w500),
                                ).paddingHorizontal(14.w).paddingVertical(8.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                      12.h.height,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.requestDetail?.request?.title ?? 'N/A',
                          style: AppTextStyles.customText18(color: Colors.black, fontWeight: FontWeight.w600, height: 1.2),
                        ),
                      ).paddingRight(100.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            controller.requestDetail?.request?.status == 'active' ? 'Requested created on: ' : 'Completion Date: ',
                            style: AppTextStyles.customText14(color: AppColors.textLightBlack),
                          ),
                          Text(
                            controller.requestDetail?.request?.status == 'active'
                                ? Utils.formatBackendDate(controller.requestDetail?.request?.startDate ?? '')
                                : Utils.formatBackendDate(controller.requestDetail?.request?.endDate ?? ''),
                            style: AppTextStyles.customText16(color: AppColors.black, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      15.h.height,
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: Colors.black.withOpacity(0.06)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${controller.requestDetail?.request?.currentAmount ?? 'N/A'}',
                                  style: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'of \$${controller.requestDetail?.request?.targetAmount ?? 'N/A'}',
                                  style: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            10.h.height,
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
                                value: double.parse(controller.requestDetail?.request?.currentAmount.toString() ?? ''),
                                min: 0.0,
                                max: double.parse(controller.requestDetail?.request?.targetAmount.toString() ?? ''),
                                divisions: 25000,
                                onChanged: (double value) {},
                              ),
                            ),
                            10.h.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.calculatePercentage(controller.requestDetail?.request?.targetAmount, controller.requestDetail?.request?.currentAmount.toString())}% Funded",
                                  style: AppTextStyles.customText14(color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "235 supporters",
                                  style: AppTextStyles.customText14(color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            if (controller.requestDetail?.request?.status == 'active') ...[
                              15.h.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppAssets.stopWatchIcon),
                                  3.w.width,
                                  Text(
                                    '${Utils.getDaysRemaining(controller.requestDetail?.request?.endDate ?? '')} days left',
                                    style: AppTextStyles.customText14(color: Colors.black, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ).paddingFromAll(10.sp),
                      ),
                      10.h.height,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: AppTextStyles.customText18(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      8.h.height,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.requestDetail?.request?.description ?? 'N/A',
                          style: AppTextStyles.customText14(color: Color(0xff777E90), height: 1.2),
                        ),
                      ),
                      20.h.height,
                      controller.requestDetail?.request?.status == 'active'
                          ? AppCustomButton(
                              title: 'Active',
                              onPressed: () {},
                              bgColor: Colors.transparent,
                              borderColor: Color(0xffD5D5D5),
                              textStyle: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                            ).paddingHorizontal(50.w)
                          : AppCustomButton(
                              title: 'Completed',
                              onPressed: () {},
                              bgColor: AppColors.primary.withOpacity(0.25),
                              borderColor: Color(0xff94E941),
                              textStyle: AppTextStyles.customText16(color: Colors.black, fontWeight: FontWeight.w500),
                            ).paddingHorizontal(50.w),
                    ],
                  ),
                ).paddingHorizontal(15.w),
              ),
            );
    });
  }
}
