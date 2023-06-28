// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitorModelAdapter extends TypeAdapter<VisitorModel> {
  @override
  final int typeId = 0;

  @override
  VisitorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisitorModel(
      name: fields[0] as String?,
      cpf: fields[1] as String?,
      apVisited: fields[2] as String?,
      carPlate: fields[3] as String?,
      dateTimeRegister: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VisitorModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cpf)
      ..writeByte(2)
      ..write(obj.apVisited)
      ..writeByte(3)
      ..write(obj.carPlate)
      ..writeByte(5)
      ..write(obj.dateTimeRegister);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
