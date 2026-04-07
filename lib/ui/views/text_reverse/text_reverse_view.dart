import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:week8/ui/common/ui_helpers.dart';
import 'text_reverse_view.form.dart';

import 'text_reverse_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'reverseInput',
    validator: TextReverseValidators.validateReverseText,
  ),
])
class TextReverseView extends StackedView<TextReverseViewModel>
    with $TextReverseView {
  const TextReverseView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TextReverseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Reverser')),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,
              const Text(
                'Text to Reverse',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              verticalSpaceSmall,
              TextFormField(controller: reverseInputController),
              if (viewModel.hasReverseInputValidationMessage) ...[
                verticalSpaceTiny,
                Text(
                  viewModel.reverseInputValidationMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              verticalSpaceMedium,
              Text(
                viewModel.reversedText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TextReverseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TextReverseViewModel();

  @override
  void onDispose(TextReverseViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
