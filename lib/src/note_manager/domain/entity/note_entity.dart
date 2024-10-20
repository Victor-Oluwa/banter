import 'package:banter/core/utils/typedef.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String createdAt;
  @HiveField(3)
  final String updatedAt;
  @HiveField(4)
  final List<StringMap> body;
  @HiveField(5)
  final List<String> folderIds;
  @HiveField(6)
  final String ownerId;
  @HiveField(7)
  final String? mongoId;
  @HiveField(8)
  final bool? updated;
  @HiveField(9)
  final bool? deleted;
  @HiveField(10)
  final int version;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.folderIds,
    required this.ownerId,
    this.deleted = false,
    this.updated = true,
    this.mongoId,
    this.version = 1,
  });

  @override
  List<dynamic> get props => [
        id,
        title,
        createdAt,
        updatedAt,
        body,
        folderIds,
        ownerId,
        mongoId,
        updated,
        deleted,
        version,
      ];

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
      'updated': updated,
      'deleted': deleted,
      'version': version,
    };
  }

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
      id: map['localId'] as String,
      mongoId: map['_id'] as String? ?? '',
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
}

@HiveType(typeId: 1)
class FolderEntity extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String folderName;
  @HiveField(2)
  final String ownerId;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String updatedAt;
  @HiveField(5)
  final String? mongoId;
  @HiveField(6)
  final bool updated;
  @HiveField(7)
  final bool deleted;
  @HiveField(8)
  final int version;

  const FolderEntity({
    required this.folderName,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.mongoId,
    this.updated = false,
    this.deleted = false,
    this.version = 0,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'localId': id,
      'folderName': folderName,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '_id': mongoId,
      'deleted': deleted,
      'updated': updated,
      'version': version,
    };
  }

  factory FolderEntity.fromMap(Map<String, dynamic> map) {
    return FolderEntity(
      id: map['localId'] as String,
      folderName: map['folderName'] as String,
      ownerId: map['ownerId'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      mongoId: map['_id'] as String,
      updated: map['updated'] as bool,
      deleted: map['deleted'] as bool,
      version: map['version'] as int,
    );
  }
}
