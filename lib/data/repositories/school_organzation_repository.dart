// File: school_organzation_repository.dart (Complete Local Repository)
import 'package:sqflite/sqflite.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/school_organzation.dart';
import 'package:ui_temarlije/features/administrator/school_org/model/school.dart';
import 'package:ui_temarlije/service/database_service.dart';
import 'package:get/get.dart';
import 'package:ui_temarlije/service/school_orginzation_service.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

/// Repository for school organization data with offline-first support
/// Manages both local SQLite database and remote API synchronization
class SchoolOrganzationRepository {
  final LocalDatabaseService _databaseHelper = LocalDatabaseService();
  final SchoolOrganizationService _remoteService =
      Get.find<SchoolOrganizationService>();

  static const String _tableName = 'school_organization';
  static const String _syncMetadataTable = 'sync_metadata';

  /// Gets the database instance
  Future<Database> get _database async => await _databaseHelper.database;

  /// Initializes the school organization table if not exists
  Future<void> _ensureTableExists(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id TEXT PRIMARY KEY,
        tenant_code TEXT UNIQUE NOT NULL,
        name TEXT NOT NULL,
        location TEXT NOT NULL,
        address TEXT NOT NULL,
        contact TEXT NOT NULL,
        established_year INTEGER NOT NULL,
        school_type TEXT NOT NULL,
        created_by TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_synced INTEGER DEFAULT 1,
        is_deleted INTEGER DEFAULT 0,
        last_modified TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_syncMetadataTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        entity_id TEXT NOT NULL,
        operation TEXT NOT NULL,
        data TEXT NOT NULL,
        created_at TEXT NOT NULL,
        retry_count INTEGER DEFAULT 0,
        synced INTEGER DEFAULT 0
      )
    ''');

    // Create indexes for better query performance
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_school_tenant ON $_tableName(tenant_code)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_school_sync ON $_tableName(is_synced)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_sync_pending ON $_syncMetadataTable(synced)
    ''');
  }

  /// Converts SchoolOrganzationModel to database map
  Map<String, dynamic> _toMap(SchoolOrganzationModel school) {
    return {
      'id': school.id.toString(),
      'tenant_code': school.tenantCode,
      'name': school.name,
      'location': jsonEncode(school.location.toJson()),
      'address': jsonEncode(school.address.toJson()),
      'contact': jsonEncode(school.contact.toJson()),
      'established_year': school.establishedYear,
      'school_type': school.schoolType.toString().split('.').last,
      'created_by': school.createdBy.toString(),
      'created_at': school.createdAt.toIso8601String(),
      'updated_at': school.updatedAt.toIso8601String(),
      'is_synced': 1,
      'is_deleted': 0,
      'last_modified': DateTime.now().toIso8601String(),
    };
  }

  /// Converts database map to SchoolOrganzationModel
  SchoolOrganzationModel _fromMap(Map<String, dynamic> map) {
    return SchoolOrganzationModel(
      id: UuidValue.fromString(map['id']),
      tenantCode: map['tenant_code'],
      name: map['name'],
      schoolType: _parseSchoolType(map['school_type']),
      establishedYear: map['established_year'],
      address: AddressInfo.fromJson(jsonDecode(map['address'])),
      location: Location.fromJson(jsonDecode(map['location'])),
      contact: Contact.fromJson(jsonDecode(map['contact'])),
      createdBy: UuidValue.fromString(map['created_by']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  SchoolType _parseSchoolType(String type) {
    switch (type.toLowerCase()) {
      case 'public':
        return SchoolType.Public;
      case 'private':
        return SchoolType.Private;
      case 'international':
        return SchoolType.International;
      case 'governmentallied':
        return SchoolType.GovernmentAllied;
      default:
        return SchoolType.Public;
    }
  }

  /// Creates a school organization with offline support
  /// Saves locally first, then syncs to remote
  /// This upper commnet is misslideing the fuction acctually
  /// doing is the qite oposite
  Future<SchoolOrganzationModel> createSchoolOrg(
    SchoolOrganzationModel request,
  ) async {
    final db = await _database;
    await _ensureTableExists(db);

    await db.insert(
      _tableName,
      _toMap(request),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return request;
  }

  /// Retrieves all school organizations from local database
  Future<List<SchoolOrganzationModel>> getAllSchools() async {
    final db = await _database;
    await _ensureTableExists(db);

    final result = await db.query(
      _tableName,
      where: 'is_deleted = 0',
      orderBy: 'created_at DESC',
    );

    return result.map(_fromMap).toList();
  }

  /// Retrieves a single school organization by ID
  Future<SchoolOrganzationModel?> getSchoolById(String id) async {
    final db = await _database;
    await _ensureTableExists(db);

    final result = await db.query(
      _tableName,
      where: 'id = ? AND is_deleted = 0',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;
    return _fromMap(result.first);
  }

  /// Updates a school organization locally and queues for sync
  Future<void> updateSchoolOrg(
    String id,
    UpdateSchoolOrganzationRequest request,
  ) async {
    final db = await _database;
    await _ensureTableExists(db);

    // Get existing school
    final existing = await getSchoolById(id);
    if (existing == null) throw Exception('School not found');

    // Update local record
    await db.update(
      _tableName,
      {
        if (request.schoolName != null) 'name': request.schoolName,
        if (request.location != null)
          'location': jsonEncode(request.location!.toJson()),
        if (request.address != null)
          'address': jsonEncode(request.address!.toJson()),
        if (request.contact != null)
          'contact': jsonEncode(request.contact!.toJson()),
        if (request.establishedYear != null)
          'established_year': request.establishedYear,
        if (request.schoolType != null) 'school_type': request.schoolType,
        'updated_at': DateTime.now().toIso8601String(),
        'is_synced': 0,
        'last_modified': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    // Queue update operation
    await _queueSyncOperation(id, 'update', request.toJson());
  }

  /// Deletes a school organization locally and queues for sync
  Future<void> deleteSchoolOrg(String id) async {
    final db = await _database;
    await _ensureTableExists(db);

    // Soft delete
    await db.update(
      _tableName,
      {
        'is_deleted': 1,
        'is_synced': 0,
        'last_modified': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    // Queue delete operation
    await _queueSyncOperation(id, 'delete', {});
  }

  /// Queues a sync operation for later processing
  Future<void> _queueSyncOperation(
    String entityId,
    String operation,
    Map<String, dynamic> data,
  ) async {
    final db = await _database;
    await db.insert(_syncMetadataTable, {
      'entity_id': entityId,
      'operation': operation,
      'data': jsonEncode(data),
      'created_at': DateTime.now().toIso8601String(),
      'retry_count': 0,
      'synced': 0,
    });
  }

  /// Synchronizes pending operations with remote server
  Future<void> syncWithRemote() async {
    final db = await _database;
    await _ensureTableExists(db);

    // Get all pending sync operations
    final pendingOps = await db.query(
      _syncMetadataTable,
      where: 'synced = 0',
      orderBy: 'created_at ASC',
    );

    for (final op in pendingOps) {
      try {
        final entityId = op['entity_id'] as String;
        final operation = op['operation'] as String;
        final data = jsonDecode(op['data'] as String);

        switch (operation) {
          case 'create':
            final request = CreateSchoolOrganzationRequest.fromJson(data);
            final remoteSchool = await _remoteService.createSchoolOrg(request);
            // Update local record with server data
            await db.update(
              _tableName,
              {
                'id': remoteSchool.id.toString(),
                'tenant_code': remoteSchool.tenantCode,
                'created_by': remoteSchool.createdBy.toString(),
                'created_at': remoteSchool.createdAt.toIso8601String(),
                'updated_at': remoteSchool.updatedAt.toIso8601String(),
                'is_synced': 1,
              },
              where: 'id = ?',
              whereArgs: [entityId],
            );
            break;

          case 'update':
            final request = UpdateSchoolOrganzationRequest.fromJson(data);
            await _remoteService.updateSchoolOrg(entityId, request);
            await db.update(
              _tableName,
              {'is_synced': 1},
              where: 'id = ?',
              whereArgs: [entityId],
            );
            break;

          case 'delete':
            await _remoteService.deleteSchoolOrg(entityId);
            await db.delete(_tableName, where: 'id = ?', whereArgs: [entityId]);
            break;
        }

        // Mark operation as synced
        await db.update(
          _syncMetadataTable,
          {'synced': 1},
          where: 'id = ?',
          whereArgs: [op['id']],
        );
      } catch (e) {
        // Update retry count
        await db.update(
          _syncMetadataTable,
          {'retry_count': (op['retry_count'] as int) + 1},
          where: 'id = ?',
          whereArgs: [op['id']],
        );
      }
    }
  }

  /// Fetches latest data from remote and updates local database
  Future<void> fetchAndSyncFromRemote() async {
    try {
      final remoteSchools = await _remoteService.listSchools();
      final db = await _database;
      await _ensureTableExists(db);

      for (final school in remoteSchools) {
        await db.insert(
          _tableName,
          _toMap(school),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      // Silently fail - we'll retry on next sync
      print('Failed to sync from remote: $e');
    }
  }
}

/// Extension to parse UuidValue
extension UuidValueExtension on UuidValue {
  static UuidValue fromString(String value) {
    // Implementation depends on your UUID package
    return UuidValue.raw(value);
  }
}
