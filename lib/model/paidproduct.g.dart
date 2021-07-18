// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paidproduct.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaidProductAdapter extends TypeAdapter<PaidProduct> {
  @override
  final int typeId = 7;

  @override
  PaidProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaidProduct(
      fields[0] as String,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PaidProduct obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sellingPrice)
      ..writeByte(3)
      ..write(obj.benefit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaidProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
