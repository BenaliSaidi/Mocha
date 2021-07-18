// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TotalUnitProduct.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalUnitAdapter extends TypeAdapter<TotalUnit> {
  @override
  final int typeId = 8;

  @override
  TotalUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalUnit(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TotalUnit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.unite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
