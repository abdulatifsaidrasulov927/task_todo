import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class GetAllCategores extends CategoryEvent {
  final String bearerToken;
  GetAllCategores({required this.bearerToken});
  @override
  List<Object?> get props => [bearerToken];
}
