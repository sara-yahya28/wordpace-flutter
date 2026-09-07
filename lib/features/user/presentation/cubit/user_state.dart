import 'package:equatable/equatable.dart';
import 'package:wordspace/features/user/domain/entities/user_entitiy.dart';

abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class UserLoaded extends UserState {
  final UserEntity user;

  @override
  List<Object?> get props => [user];
  UserLoaded({required this.user});
}

//successful 
final class UserLoading extends UserState {
  List<Object?> get props => [];

}
final class UserError extends UserState {
  final String errMessage;

  @override
List<Object?> get props => [errMessage];
  UserError({required this.errMessage});
}
