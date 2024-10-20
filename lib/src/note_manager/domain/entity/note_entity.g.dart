// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteEntityAdapter extends TypeAdapter<NoteEntity> {
  @override
  final int typeId = 0;

  @override
  NoteEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      body: (fields[4] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      folderIds: (fields[5] as List).cast<String>(),
      ownerId: fields[6] as String,
      deleted: fields[9] as bool,
      updated: fields[8] as bool,
      mongoId: fields[7] as String?,
      version: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NoteEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.folderIds)
      ..writeByte(6)
      ..write(obj.ownerId)
      ..writeByte(7)
      ..write(obj.mongoId)
      ..writeByte(8)
      ..write(obj.updated)
      ..writeByte(9)
      ..write(obj.deleted)
      ..writeByte(10)
      ..write(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FolderEntityAdapter extends TypeAdapter<FolderEntity> {
  @override
  final int typeId = 1;

  @override
  FolderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderEntity(
      folderName: fields[1] as String,
      ownerId: fields[2] as String,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      id: fields[0] as String,
      mongoId: fields[5] as String?,
      updated: fields[6] as bool,
      deleted: fields[7] as bool,
      version: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FolderEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.folderName)
      ..writeByte(2)
      ..write(obj.ownerId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.mongoId)
      ..writeByte(6)
      ..write(obj.updated)
      ..writeByte(7)
      ..write(obj.deleted)
      ..writeByte(8)
      ..write(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
