// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasbeeh.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasbeehAdapter extends TypeAdapter<Tasbeeh> {
  @override
  final int typeId = 1;

  @override
  Tasbeeh read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tasbeeh(
      phrase: fields[0] as String,
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Tasbeeh obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.phrase)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasbeehAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
