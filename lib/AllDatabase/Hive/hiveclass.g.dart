// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class hiveclassAdapter extends TypeAdapter<hiveclass> {
  @override
  final int typeId = 1;

  @override
  hiveclass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return hiveclass(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, hiveclass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.discription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is hiveclassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
