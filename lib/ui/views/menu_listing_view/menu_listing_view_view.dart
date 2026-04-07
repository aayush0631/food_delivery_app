import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'menu_listing_view_viewmodel.dart';

class MenuListingViewView extends StackedView<MenuListingViewViewModel> {
  const MenuListingViewView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MenuListingViewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("MenuListingViewView")),
      ),
    );
  }

  @override
  MenuListingViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MenuListingViewViewModel();
}
