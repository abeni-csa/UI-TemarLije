import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:ui_temarlije/data/models/lesson_plans.dart';
import 'package:uuid/rng.dart';

enum ConflictResolutionStrategy { lastWriteWins, keepBoth, userChoice, merge }

class ConflictResolution {
  final LessonPlan localVersion;
  final LessonPlan remoteVersion;
  final ConflictResolutionStrategy strategy;

  const ConflictResolution({
    required this.localVersion,
    required this.remoteVersion,
    required this.strategy,
  });

  // Detect if two notes are in conflict
  static bool hasConflict(LessonPlan local, LessonPlan remote) {
    // No conflict if they're the same version
    if (local.version == remote.version &&
        local.updatedAt == remote.updatedAt) {
      return false;
    }

    // Conflict exists if both were modified after last sync
    final localSyncTime = local.lastSyncedAt;
    final remoteSyncTime = remote.lastSyncedAt;

    if (localSyncTime == null || remoteSyncTime == null) {
      return true; // Assume conflict if sync time is unknown
    }

    return local.updatedAt.isAfter(localSyncTime) &&
        remote.updatedAt.isAfter(remoteSyncTime);
  }

  // Resolve conflict based on strategy
  LessonPlan resolve() {
    switch (strategy) {
      case ConflictResolutionStrategy.lastWriteWins:
        return _resolveLastWriteWins();
      case ConflictResolutionStrategy.keepBoth:
        return _resolveKeepBoth();
      case ConflictResolutionStrategy.merge:
        return _resolveMerge();
      case ConflictResolutionStrategy.userChoice:
        // This would typically show a UI dialog
        // For now, fall back to LWW
        return _resolveLastWriteWins();
    }
  }

  LessonPlan _resolveLastWriteWins() {
    if (localVersion.updatedAt.isAfter(remoteVersion.updatedAt)) {
      return localVersion.copyWith(
        version: remoteVersion.version + 1,
        lastSyncedAt: DateTime.now(),
      );
    } else {
      return remoteVersion.copyWith(
        version: localVersion.version + 1,
        lastSyncedAt: DateTime.now(),
      );
    }
  }

  LessonPlan _resolveKeepBoth() {
    // Create a new note with combined content
    return localVersion.copyWith(
      title: '${localVersion.title} (Conflicted)',
      subject:
          '''
          Local Version:
          ${localVersion.subject}
          ---
          Remote Version:
          ${remoteVersion.subject}
          ''',
      durationMinutes: localVersion.durationMinutes,
      gradeLevel:
          '''
          Local Version:
          ${localVersion.gradeLevel}
          
          ---
          
          Remote Version:
          ${remoteVersion.gradeLevel}
          ''',

      version: max(localVersion.version, remoteVersion.version) + 1,
      lastSyncedAt: DateTime.now(),
    );
  }

  LessonPlan _resolveMerge() {
    // Simple merge strategy: combine titles and content
    final mergedTitle = _mergeText(localVersion.title, remoteVersion.title);
    final mergedSubject = _mergeText(
      localVersion.subject,
      remoteVersion.subject,
    );
    final mergedGradeLeve = _mergeText(
      localVersion.gradeLevel,
      remoteVersion.gradeLevel,
    );
    final mergedDurationMinutes = _mergeInt(
      localVersion.durationMinutes,
      remoteVersion.durationMinutes,
    );

    return LessonPlan(
      id: localVersion.id,
      title: mergedTitle,
      subject: mergedSubject,
      durationMinutes: mergedDurationMinutes,
      gradeLevel: mergedGradeLeve,
      createdAt: localVersion.createdAt,
      updatedAt: DateTime.now(),
      lastSyncedAt: DateTime.now(),
      version: max(localVersion.version, remoteVersion.version) + 1,
    );
  }

  String _mergeText(String local, String remote) {
    if (local == remote) return local;

    // Simple merge: if one is a subset of the other, use the longer one
    if (local.contains(remote)) return local;
    if (remote.contains(local)) return remote;

    // Otherwise, combine both with a separator
    return '$local\n\n---\n\n$remote';
  }

  int _mergeInt(int local, int remote) {
    if (local == remote) return local;

    // Simple merge: if one is a subset of the other, use the longer one
    if (local.isEqual(remote)) return local;
    if (remote.isEqual(local)) return remote;

    // Otherwise, combine both with a separator
    return local;
  }
}
