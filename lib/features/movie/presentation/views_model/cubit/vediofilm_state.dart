part of 'vediofilm_cubit.dart';

@immutable
abstract class VediofilmState {}

final class VediofilmInitial extends VediofilmState {}

final class VediofilmLoading extends VediofilmState {}

final class VediofilmLoaded extends VediofilmState {}

final class VediofilmSuccess extends VediofilmState {
  final String vediokey;
  VediofilmSuccess(this.vediokey);
}

final class VediofilmFailure extends VediofilmState {
  final String errormessage;
  VediofilmFailure(this.errormessage);
}
