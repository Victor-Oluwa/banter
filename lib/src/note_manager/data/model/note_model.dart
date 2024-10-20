import 'package:banter/core/utils/typedef.dart';
import 'package:banter/src/note_manager/domain/entity/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.title,
    required super.body,
    required super.folderIds,
    required super.ownerId,
    required super.createdAt,
    required super.updatedAt,
    super.mongoId,
    super.updated = true,
    super.deleted = false,
    super.version =1
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'localId': id,
      '_id': mongoId,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'body': body,
      'folderIds': folderIds,
      'ownerId': ownerId,
      'updated':updated,
      'deleted':deleted,
      'version':version,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['localId'] as String,
      mongoId: map['_id'],
      title: map['title'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      body: (map['body'] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      folderIds: (map['folderIds'] as List).cast<String>(),
      ownerId: map['ownerId'] as String,
      deleted: map['deleted'] as bool? ?? false,
      updated: map['updated'] as bool? ?? true,
      version: map['version'] as int,
    );
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
        id: entity.id,
        mongoId: entity.mongoId,
        title: entity.title,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        body: entity.body,
        folderIds: entity.folderIds,
        updated: entity.updated,
        deleted: entity.deleted,
        version: entity.version,
        ownerId: entity.ownerId);
  }
}

class FolderModel extends FolderEntity {
  const FolderModel({
    required super.folderName,
    required super.ownerId,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.updated = false,
    super.deleted = false,
    super.mongoId,
    super.version,
  });

  factory FolderModel.fromEntity(FolderEntity folder) {
    return FolderModel(
      folderName: folder.folderName,
      ownerId: folder.ownerId,
      updatedAt: folder.updatedAt,
      createdAt: folder.createdAt,
      mongoId: folder.mongoId,
      updated: folder.updated,
      deleted: folder.deleted,
      version: folder.version,
      id: folder.id,
    );
  }

  @override
  List<Object?> get props => [
    folderName,
    ownerId,
    createdAt,
    updatedAt,
    mongoId,
    updated,
    deleted,
    version,
    id,
  ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'localId': id,
      'folderName': folderName,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'updated': updated,
      'deleted': deleted,
      'version': version,
      '_id': mongoId,
    };
  }

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      id: map['localId'] as String,
      folderName: map['folderName'] as String,
      ownerId: map['ownerId'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      updated: map['updated'] as bool,
      mongoId: map['_id'] as String,
      deleted: map['deleted'] as bool,
      version: map['version'] as int,
    );
  }
}
