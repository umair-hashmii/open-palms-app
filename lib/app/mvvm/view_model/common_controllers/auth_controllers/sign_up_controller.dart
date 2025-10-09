import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_palms/app/services/logger_service.dart';
import '../../../../config/global_variables.dart';
import '../../../../repository/auth_repo/auth_repo.dart';
import '../../../model/body_model/sign_up_body_model.dart';

class SignUpController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<File?> profilePicture = Rx<File?>(null);
  Rx<File?> nationalIdFront = Rx<File?>(null);
  Rx<File?> nationalIdBack = Rx<File?>(null);
  Rx<File?> passportImage = Rx<File?>(null);
  Rx<File?> licenseImage = Rx<File?>(null);
  RxString imageType = ''.obs;
  RxBool isVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void togglePassword() {
    isVisible.value = !isVisible.value;
  }

  // --------------------- Image Picker ---------------------
  Future<bool> pickImageFromGallery({required Rx<File?> file}) async {
    try {
      file.value = null;
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        file.value = File(pickedFile.path);
        return true;
      }
      return false;
    } catch (e) {
      LoggerService.e('Error picking image: $e');
      return false;
    }
  }

  Future<bool> pickImageFromCamera({required Rx<File?> file}) async {
    try {
      file.value = null;
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        file.value = File(pickedFile.path);
        return true;
      }
      return false;
    } catch (e) {
      LoggerService.e('Error picking image: $e');
      return false;
    }
  }

  // --------------------- SignUp Body ---------------------
  SignUpBodyModel createSignUpBodyModelForDonor() {
    return SignUpBodyModel(
      password: passwordController.text,
      email: emailController.text,
      role: 'donor',
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      profilePicture: profilePicture.value,
    );
  }

  // --------------------- Signup API ---------------------
  Future<bool> signUp() async {
    try {
      final signUpBodyModel = GlobalVariables.userType == UserType.donor ? createSignUpBodyModelForDonor() : createSignUpBodyModelForDonor();
      final apiResponse = await AuthRepository().signUpApi(signUpBodyModel);
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
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    profilePicture.value = null;
    nationalIdFront.value = null;
    nationalIdBack.value = null;
    passportImage.value = null;
    licenseImage.value = null;
    imageType.value = '';
    isVisible.value = true;
    isConfirmPasswordVisible.value = true;
  }
}
