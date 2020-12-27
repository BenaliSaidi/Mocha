// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lastuse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastDateAdapter extends TypeAdapter<LastDate> {
  @override
  final int typeId = 3;

  @override
  LastDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastDate(
      fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LastDate obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lastuse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
