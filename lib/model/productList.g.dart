// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewProductAdapter extends TypeAdapter<NewProduct> {
  @override
  final int typeId = 0;

  @override
  NewProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewProduct(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NewProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.buyingPrice)
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
      other is NewProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
