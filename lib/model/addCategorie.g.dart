// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addCategorie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorieAdapter extends TypeAdapter<Categorie> {
  @override
  final int typeId = 9;

  @override
  Categorie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categorie(
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Categorie obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.categorie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
