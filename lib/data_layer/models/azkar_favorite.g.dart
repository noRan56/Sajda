// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AzkarFavoriteAdapter extends TypeAdapter<AzkarFavorite> {
  @override
  final int typeId = 2;

  @override
  AzkarFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AzkarFavorite(
      category: fields[0] as String,
      text: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AzkarFavorite obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AzkarFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
