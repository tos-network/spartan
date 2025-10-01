import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallet/features/settings/application/app_localizations_provider.dart';
import 'package:sallet/features/wallet/presentation/xswd/components/invoke_widget.dart';
import 'package:sallet/features/wallet/presentation/xswd/components/transaction_builder_mixin.dart';
import 'package:sallet/shared/theme/extensions.dart';
import 'package:sallet/shared/utils/utils.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart';

class DeployContractBuilderWidget extends ConsumerStatefulWidget {
  final DeployContractBuilder deployContractBuilder;

  const DeployContractBuilderWidget({
    super.key,
    required this.deployContractBuilder,
  });

  @override
  ConsumerState<DeployContractBuilderWidget> createState() =>
      _DeployContractBuilderWidgetState();
}

class _DeployContractBuilderWidgetState
    extends ConsumerState<DeployContractBuilderWidget>
    with TransactionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(appLocalizationsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.deploy_contract,
              style: context.bodyLarge!.copyWith(
                color: context.moreColors.mutedColor,
              ),
            ),
          ],
        ),
        buildLabeledText(
          context,
          loc.contract.capitalize(),
          widget.deployContractBuilder.module,
        ),
        if (widget.deployContractBuilder.invoke != null)
          InvokeWidget(
            maxGas: widget.deployContractBuilder.invoke!.maxGas,
            chunkId: widget.deployContractBuilder.invoke!.chunkId,
            deposits: widget.deployContractBuilder.invoke!.deposits,
            parameters: widget.deployContractBuilder.invoke!.parameters,
          ),
      ],
    );
  }
}
