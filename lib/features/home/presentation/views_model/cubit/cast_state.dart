part of 'cast_cubit.dart';

@immutable
abstract class CastState {}

final class CastInitial extends CastState {}

final class CastLoading extends CastState {}

final class CastFailure extends CastState {
  final String errormessage;
  CastFailure({required this.errormessage});
}

final class CastSuccess extends CastState {
  final List<cast> castlist;
  CastSuccess({required this.castlist});
}
