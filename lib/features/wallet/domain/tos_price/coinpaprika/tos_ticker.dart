// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sallet/features/wallet/domain/tos_price/coinpaprika/quotes.dart';

part 'tos_ticker.freezed.dart';

part 'tos_ticker.g.dart';

@freezed
abstract class TosTicker with _$TosTicker {
  const TosTicker._();

  const factory TosTicker({
    required String id,
    required String name,
    required String symbol,
    required int rank,
    @JsonKey(name: 'total_supply') required int totalSupply,
    @JsonKey(name: 'max_supply') required int maxSupply,
    @JsonKey(name: 'beta_value') required double betaValue,
    @JsonKey(name: 'first_data_at') required DateTime firstDataAt,
    @JsonKey(name: 'last_updated') required DateTime lastUpdated,
    required Quotes quotes,
  }) = _TosTicker;

  factory TosTicker.fromJson(Map<String, dynamic> json) =>
      _$TosTickerFromJson(json);

  double get price => quotes.usd.price;
}
