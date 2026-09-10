import 'package:equatable/equatable.dart';
import 'package:wordspace/features/user/domain/entities/user_entitiy.dart';

abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}
final class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

//successful 
final class UserLoading extends UserState {
  List<Object?> get props => [];

}
final class UserError extends UserState {
  final String errMessage;

  UserError({required this.errMessage});
  @override
List<Object?> get props => [errMessage];
}
