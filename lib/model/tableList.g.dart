// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tableList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableslistAdapter extends TypeAdapter<Tableslist> {
  @override
  final int typeId = 5;

  @override
  Tableslist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tableslist(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tableslist obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableslistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
