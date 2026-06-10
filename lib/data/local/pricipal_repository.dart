// lib/data/local/database/app_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ui_temarlije/data/models/fileds.dart';
import 'package:ui_temarlije/data/models/principal.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class PricipalRepositoryLocalAppData {
  static final PricipalRepositoryLocalAppData _instance =
      PricipalRepositoryLocalAppData._internal();
  static PricipalRepositoryLocalAppData get instance => _instance;
  static Database? _database;

  PricipalRepositoryLocalAppData._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'school_management.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  IF NOT EXISTS principals (
        id TEXT PRIMARY KEY,
        auth_user_id TEXT NOT NULL,
        first_name TEXT NOT NULL,
        middle_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        date_of_birth TEXT NOT NULL,
        staff_id TEXT NOT NULL,
        department TEXT NOT NULL,
        position TEXT NOT NULL,
        staff_type TEXT NOT NULL,
        address_info TEXT NOT NULL,
        employment_type TEXT NOT NULL,
        hire_date TEXT NOT NULL,
        can_manage_users INTEGER NOT NULL,
        can_manage_finances INTEGER NOT NULL,
        can_manage_academics INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_synced INTEGER DEFAULT 1,
        created_at_local TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_principals_auth_user_id ON principals(auth_user_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_principals_sync_status ON principals(is_synced)
    ''');
  }

  // Principal CRUD Operations
  Future<void> insertPrincipal(
    PrincipalModel principal, {
    bool isSynced = true,
  }) async {
    final db = await database;
    await db.insert('principals', {
      'id': principal.id.toString(),
      'auth_user_id': principal.authUserId.toString(),
      'first_name': principal.firstName,
      'middle_name': principal.middleName,
      'last_name': principal.lastName,
      'date_of_birth': principal.dateOfBirth,
      'staff_id': principal.staffId,
      'department': principal.department,
      'position': principal.position,
      'staff_type': principal.staffType.name,
      'address_info': jsonEncode(principal.addressInfo.toJson()),
      'employment_type': principal.employmentType,
      'hire_date': principal.hireDate,
      'can_manage_users': principal.canManageUsers ? 1 : 0,
      'can_manage_finances': principal.canManageFinances ? 1 : 0,
      'can_manage_academics': principal.canManageAcademics ? 1 : 0,
      'created_at': principal.createdAt.toIso8601String(),
      'updated_at': principal.updatedAt.toIso8601String(),
      'is_synced': isSynced ? 1 : 0,
      'created_at_local': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PrincipalModel>> getAllPrincipals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'principals',
      orderBy: 'created_at_local DESC',
    );
    return List.generate(maps.length, (i) => _principalFromMap(maps[i]));
  }

  Future<PrincipalModel?> getPrincipalById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'principals',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return _principalFromMap(maps.first);
    }
    return null;
  }

  Future<PrincipalModel?> getPrincipalByAuthUserId(String authUserId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'principals',
      where: 'auth_user_id = ?',
      whereArgs: [authUserId],
    );
    if (maps.isNotEmpty) {
      return _principalFromMap(maps.first);
    }
    return null;
  }

  Future<int> updatePrincipal(PrincipalModel principal) async {
    final db = await database;
    return await db.update(
      'principals',
      {
        'first_name': principal.firstName,
        'middle_name': principal.middleName,
        'last_name': principal.lastName,
        'date_of_birth': principal.dateOfBirth,
        'department': principal.department,
        'position': principal.position,
        'address_info': jsonEncode(principal.addressInfo.toJson()),
        'employment_type': principal.employmentType,
        'hire_date': principal.hireDate,
        'can_manage_users': principal.canManageUsers ? 1 : 0,
        'can_manage_finances': principal.canManageFinances ? 1 : 0,
        'can_manage_academics': principal.canManageAcademics ? 1 : 0,
        'updated_at': principal.updatedAt.toIso8601String(),
        'is_synced': 0,
      },
      where: 'id = ?',
      whereArgs: [principal.id.toString()],
    );
  }

  Future<int> deletePrincipal(String id) async {
    final db = await database;
    return await db.delete('principals', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PrincipalModel>> searchPrincipals(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'principals',
      where: 'first_name LIKE ? OR last_name LIKE ? OR staff_id LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'created_at_local DESC',
    );
    return List.generate(maps.length, (i) => _principalFromMap(maps[i]));
  }

  Future<List<PrincipalModel>> getUnsyncedPrincipals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'principals',
      where: 'is_synced = 0',
    );
    return List.generate(maps.length, (i) => _principalFromMap(maps[i]));
  }

  Future<void> markAsSynced(String id) async {
    final db = await database;
    await db.update(
      'principals',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  PrincipalModel _principalFromMap(Map<String, dynamic> map) {
    return PrincipalModel(
      id: UuidValue.raw(map['id']),
      authUserId: UuidValue.raw(map['auth_user_id']),
      firstName: map['first_name'],
      middleName: map['middle_name'],
      lastName: map['last_name'],
      dateOfBirth: map['date_of_birth'],
      staffId: map['staff_id'],
      department: map['department'],
      position: map['position'],
      staffType: StaffType.values.firstWhere(
        (e) => e.name == map['staff_type'],
        orElse: () => StaffType.SchoolAdmin,
      ),
      addressInfo: AddressInfo.fromJson(jsonDecode(map['address_info'])),
      employmentType: map['employment_type'],
      hireDate: map['hire_date'],
      canManageUsers: map['can_manage_users'] == 1,
      canManageFinances: map['can_manage_finances'] == 1,
      canManageAcademics: map['can_manage_academics'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Future<void> clearAllPrincipals() async {
    final db = await database;
    await db.delete('principals');
  }
}
