import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../../global_widgets/base_textfield.dart';
import '../create_post_controller.dart';

class PostInfoCard extends StatelessWidget {
  PostInfoCard({super.key});
  final CreatePostController controller = Get.find<CreatePostController>();

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _expirestAfter = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.infoFormKey,
      child: Column(
        children: [
          const SizedBox(height: 5),
          BaseTextField(
            focusNode: _titleFocusNode,
            nexFocusNode: _descriptionFocusNode,
            minLines: 1,
            maxLines: 5,
            maxLength: 255,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller.titleTextController,
            labelText: 'Title',
            hintText: 'Enter title',
            onSaved: (value) {
              controller.title = value!.trim();
            },
            validator: (value) =>
                (value!.trim().isNotEmpty) ? null : 'Title cannot be empty '.tr,
          ),
          const SizedBox(height: 10),
          BaseTextField(
            focusNode: _descriptionFocusNode,
            minLines: 3,
            maxLines: 10,
            maxLength: 1000,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: controller.descriptionTextController,
            labelText: 'Detailed description',
            hintText: 'Detailed description',
            onSaved: (value) {
              controller.description = value!.trim();
            },
            validator: (value) => (value!.trim().isNotEmpty)
                ? null
                : 'Description cannot be empty'.tr,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Post Expires After (Days)'.tr),
              InputQty.int(
                maxVal: 14,
                initVal: 3,
                minVal: 1,
                steps: 1,
                onQtyChanged: (value) {
                  controller.postExpiresAfter = value;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
