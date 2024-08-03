import 'package:cooki/common/component/button/primary_button.dart';
import 'package:cooki/common/component/indicator/error_indicator.dart';
import 'package:cooki/common/component/indicator/loading_indicator.dart';
import 'package:cooki/common/helper/toast_helper.dart';
import 'package:cooki/common/theme/app_text_styles.dart';
import 'package:cooki/feature/shopping_list/data/di/shopping_list_service_locator.dart';
import 'package:cooki/feature/shopping_list/presentation/view_model/interfered_restrictions/interfered_restrictions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListItemRestrictions extends StatelessWidget {
  const ShoppingListItemRestrictions({
    required this.productId,
    super.key,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InterferedRestrictionsViewModel(shoppingListRepository)
        ..add(InterferedRestrictionsRequested(productId)),
      child: _RestrictionsView(
        productId: productId,
      ),
    );
  }
}

class _RestrictionsView extends StatelessWidget {
  const _RestrictionsView({
    required this.productId,
  });

  final String productId;

  void _errorListener(
    BuildContext context,
    InterferedRestrictionsState state,
  ) {
    if (state.status.isError) {
      ToastHelper.of(context).showGenericError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InterferedRestrictionsViewModel,
        InterferedRestrictionsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _errorListener,
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingIndicator();
        }

        if (state.status.isError) {
          return ErrorIndicator(
            onRetry: () => context
                .read<InterferedRestrictionsViewModel>()
                .add(InterferedRestrictionsRequested(productId)),
          );
        }

        if (state.medications.isEmpty && state.dietaryRestrictions.isEmpty) {
          return const SizedBox.shrink();
        }

        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restrictions',
                style: AppTextStyles.titleMedium,
              ),
              if (state.dietaryRestrictions.isNotEmpty) ...[
                const SizedBox(height: 4),
                _RestrictionInformation(
                  label: 'Dietary restrictions',
                  items: state.dietaryRestrictions
                      .map((restriction) => restriction.displayLabel)
                      .toList(),
                ),
              ],
              if (state.medications.isNotEmpty) ...[
                const SizedBox(height: 4),
                _RestrictionInformation(
                  label: 'Medications',
                  items: state.medications
                      .map((medication) => medication.displayLabel)
                      .toList(),
                ),
              ],
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'View Alternative Products',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                onPress: () {},
                prefixIcon: const Icon(
                  Icons.switch_access_shortcut,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RestrictionInformation extends StatelessWidget {
  const _RestrictionInformation({
    required this.items,
    required this.label,
  });

  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label this interferes with:',
          style: AppTextStyles.bodyMedium,
        ),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 4.0,
            ),
            child: Text(
              '\u2022 $item',
              style: AppTextStyles.bodyMedium,
            ),
          ),
      ],
    );
  }
}
