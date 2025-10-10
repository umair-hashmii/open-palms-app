import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_palms/app/config/padding_extensions.dart';
import 'package:open_palms/app/customWidgets/app_custom_button.dart';
import 'package:open_palms/app/customWidgets/app_custom_field.dart';
import 'package:open_palms/app/customWidgets/custom_app_bar.dart';
import 'package:open_palms/app/customWidgets/drop_down_widget.dart';
import 'package:open_palms/app/customWidgets/sizedbox_extension.dart';
import 'package:open_palms/app/mvvm/view_model/needy_side_controllers/create_request_controller.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_text_style.dart';
import '../../../../config/global_variables.dart';
import '../../../../config/utils.dart';
import '../../../../customWidgets/add_tile.dart';
import '../../../../customWidgets/custom_loader.dart';
import '../../../../customWidgets/custom_snackbar/custom_snackbar.dart';

class CreateRequestView extends StatefulWidget {
  const CreateRequestView({super.key});

  @override
  State<CreateRequestView> createState() => _CreateRequestViewState();
}

class _CreateRequestViewState extends State<CreateRequestView> {
  final CreateRequestController controller = Get.find();
  final _formKey = GlobalKey<FormState>(); // ✅ Added form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Create Request', backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey, // ✅ Wrap inside a form
            child: Column(
              children: [
                20.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Pictures',
                      style: AppTextStyles.customText(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return controller.images.isEmpty
                          ? AddTiles(
                              hasEditIcon: true,
                              height: 130.h,
                              width: 106.w,
                              icon: Icons.add,
                              centerWidget: Icon(Icons.upload_outlined, color: AppColors.primary, size: 30.sp),
                              onTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              onIconTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              iconBgColor: Colors.black,
                              iconColor: AppColors.white,
                            ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut)
                          : Obx(() {
                              return AddTiles(
                                height: 130.h,
                                hasEditIcon: true,
                                icon: Icons.remove,
                                image: controller.images[0].path,
                                onIconTap: () {
                                  controller.images.removeAt(0);
                                },
                                width: 106.w,
                              ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut);
                            });
                    }),
                    Obx(() {
                      return controller.images.length < 2
                          ? AddTiles(
                              hasEditIcon: true,
                              height: 130.h,
                              width: 106.w,
                              icon: Icons.add,
                              centerWidget: Icon(Icons.upload_outlined, color: AppColors.primary, size: 30.sp),
                              onTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              onIconTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              iconBgColor: Colors.black,
                              iconColor: AppColors.white,
                            ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut)
                          : Obx(() {
                              return AddTiles(
                                height: 130.h,
                                hasEditIcon: true,
                                icon: Icons.remove,
                                image: controller.images[1].path,
                                onIconTap: () {
                                  controller.images.removeAt(1);
                                },
                                width: 106.w,
                              ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut);
                            });
                    }),
                    Obx(() {
                      return controller.images.length < 3
                          ? AddTiles(
                              hasEditIcon: true,
                              height: 130.h,
                              width: 106.w,
                              icon: Icons.add,
                              centerWidget: Icon(Icons.upload_outlined, color: AppColors.primary, size: 30.sp),
                              onTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              onIconTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              iconBgColor: Colors.black,
                              iconColor: AppColors.white,
                            ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut)
                          : Obx(() {
                              return AddTiles(
                                height: 130.h,
                                hasEditIcon: true,
                                icon: Icons.remove,
                                image: controller.images[2].path,
                                onIconTap: () {
                                  controller.images.removeAt(2);
                                },
                                width: 106.w,
                              ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut);
                            });
                    }),
                  ],
                ),
                15.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return controller.images.length < 4
                          ? AddTiles(
                              hasEditIcon: true,
                              height: 130.h,
                              width: 106.w,
                              icon: Icons.add,
                              centerWidget: Icon(Icons.upload_outlined, color: AppColors.primary, size: 30.sp),
                              onTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              onIconTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () {
                                    Get.back();
                                    controller.pickImageFromCameraForList();
                                  },
                                  onGalleryTap: () {
                                    Get.back();
                                    controller.pickImageFromGalleryForList();
                                  },
                                );
                              },
                              iconBgColor: Colors.black,
                              iconColor: AppColors.white,
                            ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut)
                          : Obx(() {
                              return AddTiles(
                                height: 130.h,
                                width: 106.w,
                                hasEditIcon: true,
                                icon: Icons.remove,
                                image: controller.images[3].path,
                                onIconTap: () {
                                  controller.images.removeAt(3);
                                },
                              ).animate().fade(duration: 500.ms).scale(begin: Offset(0.95, 0.95), curve: Curves.easeOut);
                            });
                    }),
                  ],
                ),
                15.h.height,
                // ---------------- FIELDS ----------------
                AppCustomField(
                  isSecondField: true,
                  labelTitle: 'Title',
                  hintText: 'Enter Title',
                  labelColor: Colors.black,
                  controller: controller.titleController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Title is required' : null, // ✅ Added validation
                ),
                15.h.height,
                AppCustomField(
                  isSecondField: true,
                  controller: controller.targetAmountController,
                  labelTitle: 'Set Goal Amount',
                  hintText: 'Enter Amount',
                  keyboardType: TextInputType.number,
                  labelColor: Colors.black,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Amount is required' : null, // ✅ Added validation
                ),
                15.h.height,
                Obx(() {
                  return DropDownWidgetTwo(
                    selectedValue: controller.selectedPriority.value,
                    onChanged: (val) {
                      controller.selectedPriority.value = val!;
                    },
                    itemsList: controller.priorityList,
                    title: 'Priority',
                  );
                }),
                15.h.height,
                Obx(() {
                  return DropDownWidgetTwo(
                    selectedValue: controller.selectedCategory.value,
                    onChanged: (val) {
                      controller.selectedCategory.value = val!;
                    },
                    itemsList: controller.categoryList,
                    title: 'Category',
                  );
                }),
                15.h.height,
                AppCustomField(
                  isSecondField: true,
                  controller: controller.durationController,
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Time Duration',
                        style: AppTextStyles.customText(fontSize: 16, color: AppColors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(' (Days)', style: AppTextStyles.customText(fontSize: 12, color: AppColors.textLightBlack)),
                    ],
                  ),
                  hintText: 'Enter Days',
                  keyboardType: TextInputType.number,
                  labelColor: Colors.black,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Duration is required';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(val.trim())) {
                      return 'Only numbers allowed';
                    }
                    return null;
                  }, // ✅ Added numeric-only validation
                ),
                15.h.height,
                AppCustomField(
                  isSecondField: true,
                  labelTitle: 'Description',
                  hintText: 'Write here.....',
                  minLines: 5,
                  maxLines: 5,
                  labelColor: Colors.black,
                  controller: controller.descriptionController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Description is required' : null, // ✅ Added validation
                ),
                20.h.height,
                AppCustomButton(
                  title: 'Request',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (controller.images.length < 4) {
                        CustomSnackbar.show(
                          iconData: Icons.warning_amber,
                          textColor: AppColors.negativeRed,
                          title: "Error",
                          message: "",
                          backgroundColor: AppColors.white,
                          iconColor: AppColors.negativeRed,
                          borderColor: AppColors.negativeRed,
                          messageText: ["Kindly Upload 4 Images so that we can verify your request easily."],
                        );
                      } else {
                        Get.dialog(CustomLoader(), barrierDismissible: false);
                        bool isLogin = await controller.createRequest();
                        Get.back();
                        if (isLogin) {
                          Get.back();
                          CustomSnackbar.show(
                            iconData: Icons.check_circle,
                            title: "Success",
                            message: "",
                            textColor: AppColors.positiveGreen,
                            backgroundColor: AppColors.white,
                            iconColor: Colors.green,
                            borderColor: AppColors.positiveGreen,
                            messageText: ["Request Added Successfully"],
                          );
                        } else {
                          CustomSnackbar.show(
                            iconData: Icons.warning_amber,
                            textColor: AppColors.negativeRed,
                            title: "Error",
                            message: "",
                            backgroundColor: AppColors.white,
                            iconColor: AppColors.negativeRed,
                            borderColor: AppColors.negativeRed,
                            messageText: GlobalVariables.errorMessages,
                          );
                        }
                      }
                    }
                  },
                ).paddingHorizontal(40.w),
                20.h.height,
              ],
            ),
          ).paddingHorizontal(15.w),
        ),
      ),
    );
  }
}
