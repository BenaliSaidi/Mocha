// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewListAdapter extends TypeAdapter<NewList> {
  @override
  final int typeId = 1;

  @override
  NewList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewList(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.recette)
      ..writeByte(1)
      ..write(obj.gain)
      ..writeByte(2)
      ..write(obj.dateNow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
