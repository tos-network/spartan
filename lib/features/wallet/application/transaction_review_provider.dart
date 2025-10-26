import 'package:spartan/features/logger/logger.dart';
import 'package:spartan/features/wallet/application/wallet_provider.dart';
import 'package:spartan/features/wallet/domain/transaction_review_state.dart';
import 'package:spartan/features/wallet/domain/transaction_summary.dart';
import 'package:spartan/shared/providers/provider_extensions.dart';
import 'package:spartan/shared/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_review_provider.g.dart';

@riverpod
class TransactionReview extends _$TransactionReview {
  @override
  TransactionReviewState build() {
    ref.cacheFor(Duration(seconds: 3));
    return TransactionReviewState.initial();
  }

  void signaturePending(String transactionHashToSign) {
    state = TransactionReviewState.signaturePending(
      isBroadcasted: false,
      isConfirmed: false,
      hashToSign: transactionHashToSign,
    );
  }

  void setSingleTransferTransaction(TransactionSummary transactionSummary) {
    try {
      // Reset to initial state first to avoid any state inconsistency
      state = TransactionReviewState.initial();

      final network = ref.read(
        walletStateProvider.select((state) => state.network),
      );
      final transfer = transactionSummary.getSingleTransfer();
      final asset = transfer.asset;
      final destination = transfer.destination;
      final knownAssets = ref.read(
        walletStateProvider.select((state) => state.knownAssets),
      );
      final name = knownAssets[asset]?.name ?? '';
      final ticker = knownAssets[asset]?.ticker ?? '';
      final decimals = knownAssets[asset]?.decimals ?? 0;
      final formattedAmount = formatCoin(transfer.amount, decimals, ticker);
      final destinationAddress = parseRawAddress(rawAddress: destination);

      state = TransactionReviewState.singleTransferTransaction(
        isBroadcasted: false,
        isConfirmed: true,
        asset: asset,
        name: name,
        ticker: ticker,
        amount: formattedAmount,
        fee: formatTos(transactionSummary.fee, network),
        destination: destination,
        destinationAddress: destinationAddress,
        txHash: transactionSummary.hash,
      );
    } catch (e, stackTrace) {
      talker.error('Error in setSingleTransferTransaction: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> setBurnTransaction(TransactionSummary transactionSummary) async {
    // Reset to initial state first to avoid any state inconsistency
    state = TransactionReviewState.initial();

    final network = ref.read(
      walletStateProvider.select((state) => state.network),
    );
    final burn = transactionSummary.getBurn();
    final asset = burn.asset;
    final knownAssets = ref.read(
      walletStateProvider.select((state) => state.knownAssets),
    );
    final name = knownAssets[asset]?.name ?? '';
    final ticker = knownAssets[asset]?.ticker ?? '';
    final decimals = knownAssets[asset]?.decimals ?? 0;
    final formattedAmount = formatCoin(burn.amount, decimals, ticker);

    state = TransactionReviewState.burnTransaction(
      isBroadcasted: false,
      isConfirmed: false,
      asset: asset,
      name: name,
      ticker: ticker,
      amount: formattedAmount,
      fee: formatTos(transactionSummary.fee, network),
      txHash: transactionSummary.hash,
    );
  }

  void setDeleteMultisigTransaction(TransactionSummary transactionSummary) {
    final walletRepository = ref.read(
      walletStateProvider.select((state) => state.nativeWalletRepository),
    );
    if (walletRepository == null) {
      talker.warning('WalletRepository is not available');
      return;
    }

    // Reset to initial state first to avoid any state inconsistency
    state = TransactionReviewState.initial();

    state = TransactionReviewState.deleteMultisigTransaction(
      isBroadcasted: false,
      isConfirmed: true,
      fee: formatTos(transactionSummary.fee, walletRepository.network),
      txHash: transactionSummary.hash,
    );
  }

  void setConfirmation(bool? isConfirmed) {
    // Use ?? false to ensure we never pass null to copyWith
    state = state.copyWith(isConfirmed: isConfirmed ?? false);
  }

  void broadcast() {
    state = state.copyWith(isBroadcasted: true);
  }
}
