import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_detail.freezed.dart';
part 'order_detail.g.dart';

@freezed
class OrderDetail with _$OrderDetail {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory OrderDetail({
    required int id,
    required int orderId,
    required int productId,
    required int qty,
    required int price,
    required DateTime orderDetailDate,
  }) = _OrderDetail;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
}
