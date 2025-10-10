import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_palms/app/mvvm/model/body_model/create_donation_request_body_model.dart';
import 'package:open_palms/app/repository/needy_requests_repo/needy_requests_repo.dart';

import '../../../services/logger_service.dart';

class CreateRequestController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);
  RxList<File> images = <File>[].obs;
  final int maxImages = 4;
  RxString selectedPriority = 'Urgent'.obs;
  RxString selectedCategory = 'Medical'.obs;
  List<String> priorityList = ['Urgent', 'High', 'Medium', 'Low'];
  List<String> categoryList = ['Medical', 'Education', 'Emergency', 'Community', 'Family', 'Others'];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  Future<bool> pickImageFromGalleryForList() async {
    try {
      if (images.length >= maxImages) {
        print('Maximum image limit ($maxImages) reached');
        return false;
      }
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
        print('Image added: ${pickedFile.path}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
      return false;
    }
  }

  Future<bool> pickImageFromCameraForList() async {
    try {
      if (images.length >= maxImages) {
        print('Maximum image limit ($maxImages) reached');
        return false;
      }
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
        print('Image added: ${pickedFile.path}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error picking image from camera: $e');
      return false;
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      print('Image removed at index: $index');
    }
  }

  // --------------------- Create Request Body ---------------------
  CreateDonationRequestBodyModel createDonationRequestBodyModel() {
    return CreateDonationRequestBodyModel(
      title: titleController.text,
      description: descriptionController.text,
      targetAmount: targetAmountController.text,
      category: selectedCategory.value == 'Medical'
          ? 'medical'
          : selectedCategory.value == 'Education'
          ? 'education'
          : selectedCategory.value == 'Emergency'
          ? 'emergency'
          : selectedCategory.value == 'Family'
          ? 'family'
          : selectedCategory.value == 'Others'
          ? 'others'
          : 'community',
      priority: selectedPriority.value == 'Urgent'
          ? 'urgent'
          : selectedPriority.value == 'High'
          ? 'high'
          : selectedPriority.value == 'Medium'
          ? 'medium'
          : 'low',
      duration: durationController.text,
      images: images,
    );
  }

  // --------------------- Create Request API ---------------------
  Future<bool> createRequest() async {
    try {
      final createRequestBodyModel = createDonationRequestBodyModel();
      final apiResponse = await NeedyRequestsRepository().createDonationRequestApi(createRequestBodyModel);
      if (apiResponse.data != null) {
        LoggerService.i(apiResponse.message ?? 'Signup success');
        clearData();
        return true;
      } else {
        LoggerService.w('Signup response is null');
        return false;
      }
    } catch (e, stack) {
      LoggerService.e('Error during signup: $e', error: e, stackTrace: stack);
      return false;
    }
  }

  void clearData() {
    titleController.clear();
    descriptionController.clear();
    targetAmountController.clear();
    durationController.clear();
    selectedPriority.value = 'High';
    images.clear();
  }
}
