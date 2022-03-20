// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletedProduct.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DelProductAdapter extends TypeAdapter<DelProduct> {
  @override
  final int typeId = 13;

  @override
  DelProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DelProduct(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DelProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.table)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DelProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
