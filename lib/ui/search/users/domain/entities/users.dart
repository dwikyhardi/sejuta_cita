import 'package:equatable/equatable.dart';
import 'package:sejuta_cita/ui/search/issues/domain/entities/issues.dart';

class Users extends Equatable {
  final int totalCount;
  final bool incompleteResults;
  final List<User> items;

  const Users({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  @override
  List<Object> get props => [
        totalCount,
        incompleteResults,
        items,
      ];
}
