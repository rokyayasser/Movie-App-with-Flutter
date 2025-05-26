// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavItemModelAdapter extends TypeAdapter<FavItemModel> {
  @override
  final int typeId = 0;

  @override
  FavItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavItemModel(
      ImageUrl: fields[0] as String,
      Title: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ImageUrl)
      ..writeByte(1)
      ..write(obj.Title)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
