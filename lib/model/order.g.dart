// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewOrderAdapter extends TypeAdapter<NewOrder> {
  @override
  final int typeId = 6;

  @override
  NewOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewOrder(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as String,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NewOrder obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.buyingPrice)
      ..writeByte(2)
      ..write(obj.sellingPrice)
      ..writeByte(3)
      ..write(obj.benefit)
      ..writeByte(4)
      ..write(obj.tables)
      ..writeByte(5)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
