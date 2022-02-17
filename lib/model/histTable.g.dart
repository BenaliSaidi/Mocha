// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'histTable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistTableAdapter extends TypeAdapter<HistTable> {
  @override
  final int typeId = 11;

  @override
  HistTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistTable(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as Map)?.cast<int, String>(),
      (fields[4] as Map)?.cast<int, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistTable obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.table)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.valPrices)
      ..writeByte(4)
      ..write(obj.valNames);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
