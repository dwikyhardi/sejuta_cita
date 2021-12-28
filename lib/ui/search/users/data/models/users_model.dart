import 'dart:convert';

import 'package:sejuta_cita/ui/search/issues/data/models/issues_model.dart';
import 'package:sejuta_cita/ui/search/users/domain/entities/users.dart';

class UsersModel extends Users {
  const UsersModel({
    required int totalCount,
    required bool incompleteResults,
    required List<UserModel> items,
  }) : super(
          totalCount: totalCount,
          items: items,
          incompleteResults: incompleteResults,
        );

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> items = [];
    if (json['items'] != null) {
      items = <UserModel>[];
      json['items'].forEach((v) {
        items.add(UserModel.fromJson(v));
      });
    }
    return UsersModel(
      totalCount: json['total_count'],
      incompleteResults: json['incomplete_results'],
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    data['items'] = items.map((v) => jsonEncode(jsonEncode(v))).toList();
    return data;
  }
}
