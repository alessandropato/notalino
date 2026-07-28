// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    colorValue,
    iconCodePoint,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      ),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class ProjectRow extends DataClass implements Insertable<ProjectRow> {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? colorValue;
  final int? iconCodePoint;
  const ProjectRow({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.colorValue,
    this.iconCodePoint,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    if (!nullToAbsent || iconCodePoint != null) {
      map['icon_code_point'] = Variable<int>(iconCodePoint);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      iconCodePoint: iconCodePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(iconCodePoint),
    );
  }

  factory ProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      iconCodePoint: serializer.fromJson<int?>(json['iconCodePoint']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'colorValue': serializer.toJson<int?>(colorValue),
      'iconCodePoint': serializer.toJson<int?>(iconCodePoint),
    };
  }

  ProjectRow copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<int?> colorValue = const Value.absent(),
    Value<int?> iconCodePoint = const Value.absent(),
  }) => ProjectRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    iconCodePoint: iconCodePoint.present
        ? iconCodePoint.value
        : this.iconCodePoint,
  );
  ProjectRow copyWithCompanion(ProjectsCompanion data) {
    return ProjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    createdAt,
    updatedAt,
    colorValue,
    iconCodePoint,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.colorValue == this.colorValue &&
          other.iconCodePoint == this.iconCodePoint);
}

class ProjectsCompanion extends UpdateCompanion<ProjectRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int?> colorValue;
  final Value<int?> iconCodePoint;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.colorValue = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? colorValue,
    Expression<int>? iconCodePoint,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (colorValue != null) 'color_value': colorValue,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int?>? colorValue,
    Value<int?>? iconCodePoint,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCodePoint: $iconCodePoint, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectContextsTable extends ProjectContexts
    with TableInfo<$ProjectContextsTable, ProjectContextRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectContextsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _overviewMarkdownMeta = const VerificationMeta(
    'overviewMarkdown',
  );
  @override
  late final GeneratedColumn<String> overviewMarkdown = GeneratedColumn<String>(
    'overview_markdown',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeetingIdsJsonMeta =
      const VerificationMeta('sourceMeetingIdsJson');
  @override
  late final GeneratedColumn<String> sourceMeetingIdsJson =
      GeneratedColumn<String>(
        'source_meeting_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    overviewMarkdown,
    updatedAt,
    sourceMeetingIdsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'project_contexts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectContextRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('overview_markdown')) {
      context.handle(
        _overviewMarkdownMeta,
        overviewMarkdown.isAcceptableOrUnknown(
          data['overview_markdown']!,
          _overviewMarkdownMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overviewMarkdownMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('source_meeting_ids_json')) {
      context.handle(
        _sourceMeetingIdsJsonMeta,
        sourceMeetingIdsJson.isAcceptableOrUnknown(
          data['source_meeting_ids_json']!,
          _sourceMeetingIdsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectContextRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectContextRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      overviewMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview_markdown'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      sourceMeetingIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_meeting_ids_json'],
      )!,
    );
  }

  @override
  $ProjectContextsTable createAlias(String alias) {
    return $ProjectContextsTable(attachedDatabase, alias);
  }
}

class ProjectContextRow extends DataClass
    implements Insertable<ProjectContextRow> {
  final String id;
  final String projectId;
  final String overviewMarkdown;
  final DateTime updatedAt;

  /// Lista di meetingId incorporati, serializzata come JSON array.
  final String sourceMeetingIdsJson;
  const ProjectContextRow({
    required this.id,
    required this.projectId,
    required this.overviewMarkdown,
    required this.updatedAt,
    required this.sourceMeetingIdsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['overview_markdown'] = Variable<String>(overviewMarkdown);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['source_meeting_ids_json'] = Variable<String>(sourceMeetingIdsJson);
    return map;
  }

  ProjectContextsCompanion toCompanion(bool nullToAbsent) {
    return ProjectContextsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      overviewMarkdown: Value(overviewMarkdown),
      updatedAt: Value(updatedAt),
      sourceMeetingIdsJson: Value(sourceMeetingIdsJson),
    );
  }

  factory ProjectContextRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectContextRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      overviewMarkdown: serializer.fromJson<String>(json['overviewMarkdown']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      sourceMeetingIdsJson: serializer.fromJson<String>(
        json['sourceMeetingIdsJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'overviewMarkdown': serializer.toJson<String>(overviewMarkdown),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'sourceMeetingIdsJson': serializer.toJson<String>(sourceMeetingIdsJson),
    };
  }

  ProjectContextRow copyWith({
    String? id,
    String? projectId,
    String? overviewMarkdown,
    DateTime? updatedAt,
    String? sourceMeetingIdsJson,
  }) => ProjectContextRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    overviewMarkdown: overviewMarkdown ?? this.overviewMarkdown,
    updatedAt: updatedAt ?? this.updatedAt,
    sourceMeetingIdsJson: sourceMeetingIdsJson ?? this.sourceMeetingIdsJson,
  );
  ProjectContextRow copyWithCompanion(ProjectContextsCompanion data) {
    return ProjectContextRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      overviewMarkdown: data.overviewMarkdown.present
          ? data.overviewMarkdown.value
          : this.overviewMarkdown,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sourceMeetingIdsJson: data.sourceMeetingIdsJson.present
          ? data.sourceMeetingIdsJson.value
          : this.sourceMeetingIdsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectContextRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('overviewMarkdown: $overviewMarkdown, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sourceMeetingIdsJson: $sourceMeetingIdsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    overviewMarkdown,
    updatedAt,
    sourceMeetingIdsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectContextRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.overviewMarkdown == this.overviewMarkdown &&
          other.updatedAt == this.updatedAt &&
          other.sourceMeetingIdsJson == this.sourceMeetingIdsJson);
}

class ProjectContextsCompanion extends UpdateCompanion<ProjectContextRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> overviewMarkdown;
  final Value<DateTime> updatedAt;
  final Value<String> sourceMeetingIdsJson;
  final Value<int> rowid;
  const ProjectContextsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.overviewMarkdown = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sourceMeetingIdsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectContextsCompanion.insert({
    required String id,
    required String projectId,
    required String overviewMarkdown,
    required DateTime updatedAt,
    this.sourceMeetingIdsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       overviewMarkdown = Value(overviewMarkdown),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectContextRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? overviewMarkdown,
    Expression<DateTime>? updatedAt,
    Expression<String>? sourceMeetingIdsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (overviewMarkdown != null) 'overview_markdown': overviewMarkdown,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sourceMeetingIdsJson != null)
        'source_meeting_ids_json': sourceMeetingIdsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectContextsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? overviewMarkdown,
    Value<DateTime>? updatedAt,
    Value<String>? sourceMeetingIdsJson,
    Value<int>? rowid,
  }) {
    return ProjectContextsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      overviewMarkdown: overviewMarkdown ?? this.overviewMarkdown,
      updatedAt: updatedAt ?? this.updatedAt,
      sourceMeetingIdsJson: sourceMeetingIdsJson ?? this.sourceMeetingIdsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (overviewMarkdown.present) {
      map['overview_markdown'] = Variable<String>(overviewMarkdown.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sourceMeetingIdsJson.present) {
      map['source_meeting_ids_json'] = Variable<String>(
        sourceMeetingIdsJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectContextsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('overviewMarkdown: $overviewMarkdown, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sourceMeetingIdsJson: $sourceMeetingIdsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeetingsTable extends Meetings
    with TableInfo<$MeetingsTable, MeetingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needsReanalysisMeta = const VerificationMeta(
    'needsReanalysis',
  );
  @override
  late final GeneratedColumn<bool> needsReanalysis = GeneratedColumn<bool>(
    'needs_reanalysis',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_reanalysis" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    title,
    createdAt,
    status,
    errorMessage,
    needsReanalysis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meetings';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('needs_reanalysis')) {
      context.handle(
        _needsReanalysisMeta,
        needsReanalysis.isAcceptableOrUnknown(
          data['needs_reanalysis']!,
          _needsReanalysisMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeetingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      needsReanalysis: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_reanalysis'],
      )!,
    );
  }

  @override
  $MeetingsTable createAlias(String alias) {
    return $MeetingsTable(attachedDatabase, alias);
  }
}

class MeetingRow extends DataClass implements Insertable<MeetingRow> {
  final String id;
  final String projectId;
  final String title;
  final DateTime createdAt;
  final String status;
  final String? errorMessage;
  final bool needsReanalysis;
  const MeetingRow({
    required this.id,
    required this.projectId,
    required this.title,
    required this.createdAt,
    required this.status,
    this.errorMessage,
    required this.needsReanalysis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['needs_reanalysis'] = Variable<bool>(needsReanalysis);
    return map;
  }

  MeetingsCompanion toCompanion(bool nullToAbsent) {
    return MeetingsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      title: Value(title),
      createdAt: Value(createdAt),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      needsReanalysis: Value(needsReanalysis),
    );
  }

  factory MeetingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      needsReanalysis: serializer.fromJson<bool>(json['needsReanalysis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'needsReanalysis': serializer.toJson<bool>(needsReanalysis),
    };
  }

  MeetingRow copyWith({
    String? id,
    String? projectId,
    String? title,
    DateTime? createdAt,
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    bool? needsReanalysis,
  }) => MeetingRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    needsReanalysis: needsReanalysis ?? this.needsReanalysis,
  );
  MeetingRow copyWithCompanion(MeetingsCompanion data) {
    return MeetingRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      needsReanalysis: data.needsReanalysis.present
          ? data.needsReanalysis.value
          : this.needsReanalysis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('needsReanalysis: $needsReanalysis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    title,
    createdAt,
    status,
    errorMessage,
    needsReanalysis,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.needsReanalysis == this.needsReanalysis);
}

class MeetingsCompanion extends UpdateCompanion<MeetingRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<bool> needsReanalysis;
  final Value<int> rowid;
  const MeetingsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.needsReanalysis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingsCompanion.insert({
    required String id,
    required String projectId,
    required String title,
    required DateTime createdAt,
    required String status,
    this.errorMessage = const Value.absent(),
    this.needsReanalysis = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       title = Value(title),
       createdAt = Value(createdAt),
       status = Value(status);
  static Insertable<MeetingRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<bool>? needsReanalysis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (needsReanalysis != null) 'needs_reanalysis': needsReanalysis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<bool>? needsReanalysis,
    Value<int>? rowid,
  }) {
    return MeetingsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      needsReanalysis: needsReanalysis ?? this.needsReanalysis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (needsReanalysis.present) {
      map['needs_reanalysis'] = Variable<bool>(needsReanalysis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('needsReanalysis: $needsReanalysis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecordingsTable extends Recordings
    with TableInfo<$RecordingsTable, RecordingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meetings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceFileNameMeta = const VerificationMeta(
    'sourceFileName',
  );
  @override
  late final GeneratedColumn<String> sourceFileName = GeneratedColumn<String>(
    'source_file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localFilePathMeta = const VerificationMeta(
    'localFilePath',
  );
  @override
  late final GeneratedColumn<String> localFilePath = GeneratedColumn<String>(
    'local_file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioDurationSecondsMeta =
      const VerificationMeta('audioDurationSeconds');
  @override
  late final GeneratedColumn<int> audioDurationSeconds = GeneratedColumn<int>(
    'audio_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chunkCountMeta = const VerificationMeta(
    'chunkCount',
  );
  @override
  late final GeneratedColumn<int> chunkCount = GeneratedColumn<int>(
    'chunk_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    orderIndex,
    sourceFileName,
    localFilePath,
    fileSizeBytes,
    audioDurationSeconds,
    status,
    chunkCount,
    errorMessage,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recordings';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('source_file_name')) {
      context.handle(
        _sourceFileNameMeta,
        sourceFileName.isAcceptableOrUnknown(
          data['source_file_name']!,
          _sourceFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceFileNameMeta);
    }
    if (data.containsKey('local_file_path')) {
      context.handle(
        _localFilePathMeta,
        localFilePath.isAcceptableOrUnknown(
          data['local_file_path']!,
          _localFilePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localFilePathMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fileSizeBytesMeta);
    }
    if (data.containsKey('audio_duration_seconds')) {
      context.handle(
        _audioDurationSecondsMeta,
        audioDurationSeconds.isAcceptableOrUnknown(
          data['audio_duration_seconds']!,
          _audioDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('chunk_count')) {
      context.handle(
        _chunkCountMeta,
        chunkCount.isAcceptableOrUnknown(data['chunk_count']!, _chunkCountMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      sourceFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_file_name'],
      )!,
      localFilePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_file_path'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      audioDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}audio_duration_seconds'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      chunkCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chunk_count'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecordingsTable createAlias(String alias) {
    return $RecordingsTable(attachedDatabase, alias);
  }
}

class RecordingRow extends DataClass implements Insertable<RecordingRow> {
  final String id;
  final String meetingId;
  final int orderIndex;
  final String sourceFileName;
  final String localFilePath;
  final int fileSizeBytes;
  final int? audioDurationSeconds;
  final String status;
  final int chunkCount;
  final String? errorMessage;
  final DateTime createdAt;
  const RecordingRow({
    required this.id,
    required this.meetingId,
    required this.orderIndex,
    required this.sourceFileName,
    required this.localFilePath,
    required this.fileSizeBytes,
    this.audioDurationSeconds,
    required this.status,
    required this.chunkCount,
    this.errorMessage,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['order_index'] = Variable<int>(orderIndex);
    map['source_file_name'] = Variable<String>(sourceFileName);
    map['local_file_path'] = Variable<String>(localFilePath);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    if (!nullToAbsent || audioDurationSeconds != null) {
      map['audio_duration_seconds'] = Variable<int>(audioDurationSeconds);
    }
    map['status'] = Variable<String>(status);
    map['chunk_count'] = Variable<int>(chunkCount);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecordingsCompanion toCompanion(bool nullToAbsent) {
    return RecordingsCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      orderIndex: Value(orderIndex),
      sourceFileName: Value(sourceFileName),
      localFilePath: Value(localFilePath),
      fileSizeBytes: Value(fileSizeBytes),
      audioDurationSeconds: audioDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(audioDurationSeconds),
      status: Value(status),
      chunkCount: Value(chunkCount),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
    );
  }

  factory RecordingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordingRow(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      sourceFileName: serializer.fromJson<String>(json['sourceFileName']),
      localFilePath: serializer.fromJson<String>(json['localFilePath']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      audioDurationSeconds: serializer.fromJson<int?>(
        json['audioDurationSeconds'],
      ),
      status: serializer.fromJson<String>(json['status']),
      chunkCount: serializer.fromJson<int>(json['chunkCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'sourceFileName': serializer.toJson<String>(sourceFileName),
      'localFilePath': serializer.toJson<String>(localFilePath),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'audioDurationSeconds': serializer.toJson<int?>(audioDurationSeconds),
      'status': serializer.toJson<String>(status),
      'chunkCount': serializer.toJson<int>(chunkCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecordingRow copyWith({
    String? id,
    String? meetingId,
    int? orderIndex,
    String? sourceFileName,
    String? localFilePath,
    int? fileSizeBytes,
    Value<int?> audioDurationSeconds = const Value.absent(),
    String? status,
    int? chunkCount,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
  }) => RecordingRow(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    orderIndex: orderIndex ?? this.orderIndex,
    sourceFileName: sourceFileName ?? this.sourceFileName,
    localFilePath: localFilePath ?? this.localFilePath,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    audioDurationSeconds: audioDurationSeconds.present
        ? audioDurationSeconds.value
        : this.audioDurationSeconds,
    status: status ?? this.status,
    chunkCount: chunkCount ?? this.chunkCount,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
  );
  RecordingRow copyWithCompanion(RecordingsCompanion data) {
    return RecordingRow(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      sourceFileName: data.sourceFileName.present
          ? data.sourceFileName.value
          : this.sourceFileName,
      localFilePath: data.localFilePath.present
          ? data.localFilePath.value
          : this.localFilePath,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      audioDurationSeconds: data.audioDurationSeconds.present
          ? data.audioDurationSeconds.value
          : this.audioDurationSeconds,
      status: data.status.present ? data.status.value : this.status,
      chunkCount: data.chunkCount.present
          ? data.chunkCount.value
          : this.chunkCount,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordingRow(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('sourceFileName: $sourceFileName, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('audioDurationSeconds: $audioDurationSeconds, ')
          ..write('status: $status, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    meetingId,
    orderIndex,
    sourceFileName,
    localFilePath,
    fileSizeBytes,
    audioDurationSeconds,
    status,
    chunkCount,
    errorMessage,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordingRow &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.orderIndex == this.orderIndex &&
          other.sourceFileName == this.sourceFileName &&
          other.localFilePath == this.localFilePath &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.audioDurationSeconds == this.audioDurationSeconds &&
          other.status == this.status &&
          other.chunkCount == this.chunkCount &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt);
}

class RecordingsCompanion extends UpdateCompanion<RecordingRow> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<int> orderIndex;
  final Value<String> sourceFileName;
  final Value<String> localFilePath;
  final Value<int> fileSizeBytes;
  final Value<int?> audioDurationSeconds;
  final Value<String> status;
  final Value<int> chunkCount;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecordingsCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.sourceFileName = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.audioDurationSeconds = const Value.absent(),
    this.status = const Value.absent(),
    this.chunkCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordingsCompanion.insert({
    required String id,
    required String meetingId,
    required int orderIndex,
    required String sourceFileName,
    required String localFilePath,
    required int fileSizeBytes,
    this.audioDurationSeconds = const Value.absent(),
    required String status,
    this.chunkCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       orderIndex = Value(orderIndex),
       sourceFileName = Value(sourceFileName),
       localFilePath = Value(localFilePath),
       fileSizeBytes = Value(fileSizeBytes),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<RecordingRow> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<int>? orderIndex,
    Expression<String>? sourceFileName,
    Expression<String>? localFilePath,
    Expression<int>? fileSizeBytes,
    Expression<int>? audioDurationSeconds,
    Expression<String>? status,
    Expression<int>? chunkCount,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (sourceFileName != null) 'source_file_name': sourceFileName,
      if (localFilePath != null) 'local_file_path': localFilePath,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (audioDurationSeconds != null)
        'audio_duration_seconds': audioDurationSeconds,
      if (status != null) 'status': status,
      if (chunkCount != null) 'chunk_count': chunkCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordingsCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<int>? orderIndex,
    Value<String>? sourceFileName,
    Value<String>? localFilePath,
    Value<int>? fileSizeBytes,
    Value<int?>? audioDurationSeconds,
    Value<String>? status,
    Value<int>? chunkCount,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecordingsCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      orderIndex: orderIndex ?? this.orderIndex,
      sourceFileName: sourceFileName ?? this.sourceFileName,
      localFilePath: localFilePath ?? this.localFilePath,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      audioDurationSeconds: audioDurationSeconds ?? this.audioDurationSeconds,
      status: status ?? this.status,
      chunkCount: chunkCount ?? this.chunkCount,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (sourceFileName.present) {
      map['source_file_name'] = Variable<String>(sourceFileName.value);
    }
    if (localFilePath.present) {
      map['local_file_path'] = Variable<String>(localFilePath.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (audioDurationSeconds.present) {
      map['audio_duration_seconds'] = Variable<int>(audioDurationSeconds.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (chunkCount.present) {
      map['chunk_count'] = Variable<int>(chunkCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordingsCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('sourceFileName: $sourceFileName, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('audioDurationSeconds: $audioDurationSeconds, ')
          ..write('status: $status, ')
          ..write('chunkCount: $chunkCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecordingTranscriptsTable extends RecordingTranscripts
    with TableInfo<$RecordingTranscriptsTable, RecordingTranscriptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordingTranscriptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordingIdMeta = const VerificationMeta(
    'recordingId',
  );
  @override
  late final GeneratedColumn<String> recordingId = GeneratedColumn<String>(
    'recording_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recordings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recordingId, content, language];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recording_transcripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordingTranscriptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recording_id')) {
      context.handle(
        _recordingIdMeta,
        recordingId.isAcceptableOrUnknown(
          data['recording_id']!,
          _recordingIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordingIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordingTranscriptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordingTranscriptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recording_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
    );
  }

  @override
  $RecordingTranscriptsTable createAlias(String alias) {
    return $RecordingTranscriptsTable(attachedDatabase, alias);
  }
}

class RecordingTranscriptRow extends DataClass
    implements Insertable<RecordingTranscriptRow> {
  final String id;
  final String recordingId;
  final String content;
  final String? language;
  const RecordingTranscriptRow({
    required this.id,
    required this.recordingId,
    required this.content,
    this.language,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recording_id'] = Variable<String>(recordingId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    return map;
  }

  RecordingTranscriptsCompanion toCompanion(bool nullToAbsent) {
    return RecordingTranscriptsCompanion(
      id: Value(id),
      recordingId: Value(recordingId),
      content: Value(content),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
    );
  }

  factory RecordingTranscriptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordingTranscriptRow(
      id: serializer.fromJson<String>(json['id']),
      recordingId: serializer.fromJson<String>(json['recordingId']),
      content: serializer.fromJson<String>(json['content']),
      language: serializer.fromJson<String?>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordingId': serializer.toJson<String>(recordingId),
      'content': serializer.toJson<String>(content),
      'language': serializer.toJson<String?>(language),
    };
  }

  RecordingTranscriptRow copyWith({
    String? id,
    String? recordingId,
    String? content,
    Value<String?> language = const Value.absent(),
  }) => RecordingTranscriptRow(
    id: id ?? this.id,
    recordingId: recordingId ?? this.recordingId,
    content: content ?? this.content,
    language: language.present ? language.value : this.language,
  );
  RecordingTranscriptRow copyWithCompanion(RecordingTranscriptsCompanion data) {
    return RecordingTranscriptRow(
      id: data.id.present ? data.id.value : this.id,
      recordingId: data.recordingId.present
          ? data.recordingId.value
          : this.recordingId,
      content: data.content.present ? data.content.value : this.content,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordingTranscriptRow(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('content: $content, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recordingId, content, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordingTranscriptRow &&
          other.id == this.id &&
          other.recordingId == this.recordingId &&
          other.content == this.content &&
          other.language == this.language);
}

class RecordingTranscriptsCompanion
    extends UpdateCompanion<RecordingTranscriptRow> {
  final Value<String> id;
  final Value<String> recordingId;
  final Value<String> content;
  final Value<String?> language;
  final Value<int> rowid;
  const RecordingTranscriptsCompanion({
    this.id = const Value.absent(),
    this.recordingId = const Value.absent(),
    this.content = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordingTranscriptsCompanion.insert({
    required String id,
    required String recordingId,
    required String content,
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordingId = Value(recordingId),
       content = Value(content);
  static Insertable<RecordingTranscriptRow> custom({
    Expression<String>? id,
    Expression<String>? recordingId,
    Expression<String>? content,
    Expression<String>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordingId != null) 'recording_id': recordingId,
      if (content != null) 'content': content,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordingTranscriptsCompanion copyWith({
    Value<String>? id,
    Value<String>? recordingId,
    Value<String>? content,
    Value<String?>? language,
    Value<int>? rowid,
  }) {
    return RecordingTranscriptsCompanion(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      content: content ?? this.content,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordingId.present) {
      map['recording_id'] = Variable<String>(recordingId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordingTranscriptsCompanion(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('content: $content, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TranscriptsTable extends Transcripts
    with TableInfo<$TranscriptsTable, TranscriptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranscriptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meetings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fullTextMeta = const VerificationMeta(
    'fullText',
  );
  @override
  late final GeneratedColumn<String> fullText = GeneratedColumn<String>(
    'full_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordingCountMeta = const VerificationMeta(
    'recordingCount',
  );
  @override
  late final GeneratedColumn<int> recordingCount = GeneratedColumn<int>(
    'recording_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    fullText,
    language,
    recordingCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transcripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<TranscriptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('full_text')) {
      context.handle(
        _fullTextMeta,
        fullText.isAcceptableOrUnknown(data['full_text']!, _fullTextMeta),
      );
    } else if (isInserting) {
      context.missing(_fullTextMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('recording_count')) {
      context.handle(
        _recordingCountMeta,
        recordingCount.isAcceptableOrUnknown(
          data['recording_count']!,
          _recordingCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordingCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TranscriptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranscriptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      fullText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_text'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      recordingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recording_count'],
      )!,
    );
  }

  @override
  $TranscriptsTable createAlias(String alias) {
    return $TranscriptsTable(attachedDatabase, alias);
  }
}

class TranscriptRow extends DataClass implements Insertable<TranscriptRow> {
  final String id;
  final String meetingId;
  final String fullText;
  final String? language;
  final int recordingCount;
  const TranscriptRow({
    required this.id,
    required this.meetingId,
    required this.fullText,
    this.language,
    required this.recordingCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['full_text'] = Variable<String>(fullText);
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    map['recording_count'] = Variable<int>(recordingCount);
    return map;
  }

  TranscriptsCompanion toCompanion(bool nullToAbsent) {
    return TranscriptsCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      fullText: Value(fullText),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      recordingCount: Value(recordingCount),
    );
  }

  factory TranscriptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranscriptRow(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      fullText: serializer.fromJson<String>(json['fullText']),
      language: serializer.fromJson<String?>(json['language']),
      recordingCount: serializer.fromJson<int>(json['recordingCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'fullText': serializer.toJson<String>(fullText),
      'language': serializer.toJson<String?>(language),
      'recordingCount': serializer.toJson<int>(recordingCount),
    };
  }

  TranscriptRow copyWith({
    String? id,
    String? meetingId,
    String? fullText,
    Value<String?> language = const Value.absent(),
    int? recordingCount,
  }) => TranscriptRow(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    fullText: fullText ?? this.fullText,
    language: language.present ? language.value : this.language,
    recordingCount: recordingCount ?? this.recordingCount,
  );
  TranscriptRow copyWithCompanion(TranscriptsCompanion data) {
    return TranscriptRow(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      fullText: data.fullText.present ? data.fullText.value : this.fullText,
      language: data.language.present ? data.language.value : this.language,
      recordingCount: data.recordingCount.present
          ? data.recordingCount.value
          : this.recordingCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptRow(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('fullText: $fullText, ')
          ..write('language: $language, ')
          ..write('recordingCount: $recordingCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, meetingId, fullText, language, recordingCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranscriptRow &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.fullText == this.fullText &&
          other.language == this.language &&
          other.recordingCount == this.recordingCount);
}

class TranscriptsCompanion extends UpdateCompanion<TranscriptRow> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<String> fullText;
  final Value<String?> language;
  final Value<int> recordingCount;
  final Value<int> rowid;
  const TranscriptsCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.fullText = const Value.absent(),
    this.language = const Value.absent(),
    this.recordingCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranscriptsCompanion.insert({
    required String id,
    required String meetingId,
    required String fullText,
    this.language = const Value.absent(),
    required int recordingCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       fullText = Value(fullText),
       recordingCount = Value(recordingCount);
  static Insertable<TranscriptRow> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? fullText,
    Expression<String>? language,
    Expression<int>? recordingCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (fullText != null) 'full_text': fullText,
      if (language != null) 'language': language,
      if (recordingCount != null) 'recording_count': recordingCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranscriptsCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<String>? fullText,
    Value<String?>? language,
    Value<int>? recordingCount,
    Value<int>? rowid,
  }) {
    return TranscriptsCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      fullText: fullText ?? this.fullText,
      language: language ?? this.language,
      recordingCount: recordingCount ?? this.recordingCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (fullText.present) {
      map['full_text'] = Variable<String>(fullText.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (recordingCount.present) {
      map['recording_count'] = Variable<int>(recordingCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptsCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('fullText: $fullText, ')
          ..write('language: $language, ')
          ..write('recordingCount: $recordingCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeetingReportsTable extends MeetingReports
    with TableInfo<$MeetingReportsTable, MeetingReportRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meetings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawJsonMeta = const VerificationMeta(
    'rawJson',
  );
  @override
  late final GeneratedColumn<String> rawJson = GeneratedColumn<String>(
    'raw_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelUsedMeta = const VerificationMeta(
    'modelUsed',
  );
  @override
  late final GeneratedColumn<String> modelUsed = GeneratedColumn<String>(
    'model_used',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    summary,
    rawJson,
    modelUsed,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingReportRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('raw_json')) {
      context.handle(
        _rawJsonMeta,
        rawJson.isAcceptableOrUnknown(data['raw_json']!, _rawJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_rawJsonMeta);
    }
    if (data.containsKey('model_used')) {
      context.handle(
        _modelUsedMeta,
        modelUsed.isAcceptableOrUnknown(data['model_used']!, _modelUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_modelUsedMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeetingReportRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingReportRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      rawJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_json'],
      )!,
      modelUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_used'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $MeetingReportsTable createAlias(String alias) {
    return $MeetingReportsTable(attachedDatabase, alias);
  }
}

class MeetingReportRow extends DataClass
    implements Insertable<MeetingReportRow> {
  final String id;
  final String meetingId;
  final String summary;
  final String rawJson;
  final String modelUsed;
  final DateTime generatedAt;
  const MeetingReportRow({
    required this.id,
    required this.meetingId,
    required this.summary,
    required this.rawJson,
    required this.modelUsed,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['summary'] = Variable<String>(summary);
    map['raw_json'] = Variable<String>(rawJson);
    map['model_used'] = Variable<String>(modelUsed);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  MeetingReportsCompanion toCompanion(bool nullToAbsent) {
    return MeetingReportsCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      summary: Value(summary),
      rawJson: Value(rawJson),
      modelUsed: Value(modelUsed),
      generatedAt: Value(generatedAt),
    );
  }

  factory MeetingReportRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingReportRow(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      summary: serializer.fromJson<String>(json['summary']),
      rawJson: serializer.fromJson<String>(json['rawJson']),
      modelUsed: serializer.fromJson<String>(json['modelUsed']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'summary': serializer.toJson<String>(summary),
      'rawJson': serializer.toJson<String>(rawJson),
      'modelUsed': serializer.toJson<String>(modelUsed),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  MeetingReportRow copyWith({
    String? id,
    String? meetingId,
    String? summary,
    String? rawJson,
    String? modelUsed,
    DateTime? generatedAt,
  }) => MeetingReportRow(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    summary: summary ?? this.summary,
    rawJson: rawJson ?? this.rawJson,
    modelUsed: modelUsed ?? this.modelUsed,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  MeetingReportRow copyWithCompanion(MeetingReportsCompanion data) {
    return MeetingReportRow(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      summary: data.summary.present ? data.summary.value : this.summary,
      rawJson: data.rawJson.present ? data.rawJson.value : this.rawJson,
      modelUsed: data.modelUsed.present ? data.modelUsed.value : this.modelUsed,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingReportRow(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('summary: $summary, ')
          ..write('rawJson: $rawJson, ')
          ..write('modelUsed: $modelUsed, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, meetingId, summary, rawJson, modelUsed, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingReportRow &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.summary == this.summary &&
          other.rawJson == this.rawJson &&
          other.modelUsed == this.modelUsed &&
          other.generatedAt == this.generatedAt);
}

class MeetingReportsCompanion extends UpdateCompanion<MeetingReportRow> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<String> summary;
  final Value<String> rawJson;
  final Value<String> modelUsed;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const MeetingReportsCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.summary = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.modelUsed = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingReportsCompanion.insert({
    required String id,
    required String meetingId,
    required String summary,
    required String rawJson,
    required String modelUsed,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       summary = Value(summary),
       rawJson = Value(rawJson),
       modelUsed = Value(modelUsed),
       generatedAt = Value(generatedAt);
  static Insertable<MeetingReportRow> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? summary,
    Expression<String>? rawJson,
    Expression<String>? modelUsed,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (summary != null) 'summary': summary,
      if (rawJson != null) 'raw_json': rawJson,
      if (modelUsed != null) 'model_used': modelUsed,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<String>? summary,
    Value<String>? rawJson,
    Value<String>? modelUsed,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return MeetingReportsCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      summary: summary ?? this.summary,
      rawJson: rawJson ?? this.rawJson,
      modelUsed: modelUsed ?? this.modelUsed,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (rawJson.present) {
      map['raw_json'] = Variable<String>(rawJson.value);
    }
    if (modelUsed.present) {
      map['model_used'] = Variable<String>(modelUsed.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingReportsCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('summary: $summary, ')
          ..write('rawJson: $rawJson, ')
          ..write('modelUsed: $modelUsed, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportProblemsTable extends ReportProblems
    with TableInfo<$ReportProblemsTable, ProblemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportProblemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<String> reportId = GeneratedColumn<String>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meeting_reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    orderIndex,
    title,
    detail,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_problems';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProblemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProblemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProblemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      )!,
    );
  }

  @override
  $ReportProblemsTable createAlias(String alias) {
    return $ReportProblemsTable(attachedDatabase, alias);
  }
}

class ProblemRow extends DataClass implements Insertable<ProblemRow> {
  final String id;
  final String reportId;
  final int orderIndex;
  final String title;
  final String detail;
  const ProblemRow({
    required this.id,
    required this.reportId,
    required this.orderIndex,
    required this.title,
    required this.detail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_id'] = Variable<String>(reportId);
    map['order_index'] = Variable<int>(orderIndex);
    map['title'] = Variable<String>(title);
    map['detail'] = Variable<String>(detail);
    return map;
  }

  ReportProblemsCompanion toCompanion(bool nullToAbsent) {
    return ReportProblemsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      orderIndex: Value(orderIndex),
      title: Value(title),
      detail: Value(detail),
    );
  }

  factory ProblemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProblemRow(
      id: serializer.fromJson<String>(json['id']),
      reportId: serializer.fromJson<String>(json['reportId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String>(json['detail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportId': serializer.toJson<String>(reportId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String>(detail),
    };
  }

  ProblemRow copyWith({
    String? id,
    String? reportId,
    int? orderIndex,
    String? title,
    String? detail,
  }) => ProblemRow(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    orderIndex: orderIndex ?? this.orderIndex,
    title: title ?? this.title,
    detail: detail ?? this.detail,
  );
  ProblemRow copyWithCompanion(ReportProblemsCompanion data) {
    return ProblemRow(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProblemRow(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('detail: $detail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reportId, orderIndex, title, detail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProblemRow &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.orderIndex == this.orderIndex &&
          other.title == this.title &&
          other.detail == this.detail);
}

class ReportProblemsCompanion extends UpdateCompanion<ProblemRow> {
  final Value<String> id;
  final Value<String> reportId;
  final Value<int> orderIndex;
  final Value<String> title;
  final Value<String> detail;
  final Value<int> rowid;
  const ReportProblemsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportProblemsCompanion.insert({
    required String id,
    required String reportId,
    required int orderIndex,
    required String title,
    required String detail,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportId = Value(reportId),
       orderIndex = Value(orderIndex),
       title = Value(title),
       detail = Value(detail);
  static Insertable<ProblemRow> custom({
    Expression<String>? id,
    Expression<String>? reportId,
    Expression<int>? orderIndex,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportProblemsCompanion copyWith({
    Value<String>? id,
    Value<String>? reportId,
    Value<int>? orderIndex,
    Value<String>? title,
    Value<String>? detail,
    Value<int>? rowid,
  }) {
    return ReportProblemsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      orderIndex: orderIndex ?? this.orderIndex,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<String>(reportId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportProblemsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportDecisionsTable extends ReportDecisions
    with TableInfo<$ReportDecisionsTable, DecisionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportDecisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<String> reportId = GeneratedColumn<String>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meeting_reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    orderIndex,
    title,
    detail,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_decisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DecisionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DecisionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DecisionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      )!,
    );
  }

  @override
  $ReportDecisionsTable createAlias(String alias) {
    return $ReportDecisionsTable(attachedDatabase, alias);
  }
}

class DecisionRow extends DataClass implements Insertable<DecisionRow> {
  final String id;
  final String reportId;
  final int orderIndex;
  final String title;
  final String detail;
  const DecisionRow({
    required this.id,
    required this.reportId,
    required this.orderIndex,
    required this.title,
    required this.detail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_id'] = Variable<String>(reportId);
    map['order_index'] = Variable<int>(orderIndex);
    map['title'] = Variable<String>(title);
    map['detail'] = Variable<String>(detail);
    return map;
  }

  ReportDecisionsCompanion toCompanion(bool nullToAbsent) {
    return ReportDecisionsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      orderIndex: Value(orderIndex),
      title: Value(title),
      detail: Value(detail),
    );
  }

  factory DecisionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DecisionRow(
      id: serializer.fromJson<String>(json['id']),
      reportId: serializer.fromJson<String>(json['reportId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String>(json['detail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportId': serializer.toJson<String>(reportId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String>(detail),
    };
  }

  DecisionRow copyWith({
    String? id,
    String? reportId,
    int? orderIndex,
    String? title,
    String? detail,
  }) => DecisionRow(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    orderIndex: orderIndex ?? this.orderIndex,
    title: title ?? this.title,
    detail: detail ?? this.detail,
  );
  DecisionRow copyWithCompanion(ReportDecisionsCompanion data) {
    return DecisionRow(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DecisionRow(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('detail: $detail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reportId, orderIndex, title, detail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecisionRow &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.orderIndex == this.orderIndex &&
          other.title == this.title &&
          other.detail == this.detail);
}

class ReportDecisionsCompanion extends UpdateCompanion<DecisionRow> {
  final Value<String> id;
  final Value<String> reportId;
  final Value<int> orderIndex;
  final Value<String> title;
  final Value<String> detail;
  final Value<int> rowid;
  const ReportDecisionsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportDecisionsCompanion.insert({
    required String id,
    required String reportId,
    required int orderIndex,
    required String title,
    required String detail,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportId = Value(reportId),
       orderIndex = Value(orderIndex),
       title = Value(title),
       detail = Value(detail);
  static Insertable<DecisionRow> custom({
    Expression<String>? id,
    Expression<String>? reportId,
    Expression<int>? orderIndex,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportDecisionsCompanion copyWith({
    Value<String>? id,
    Value<String>? reportId,
    Value<int>? orderIndex,
    Value<String>? title,
    Value<String>? detail,
    Value<int>? rowid,
  }) {
    return ReportDecisionsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      orderIndex: orderIndex ?? this.orderIndex,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<String>(reportId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportDecisionsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportActionItemsTable extends ReportActionItems
    with TableInfo<$ReportActionItemsTable, ActionItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportActionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<String> reportId = GeneratedColumn<String>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meeting_reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskMeta = const VerificationMeta('task');
  @override
  late final GeneratedColumn<String> task = GeneratedColumn<String>(
    'task',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
    'owner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<String> due = GeneratedColumn<String>(
    'due',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    orderIndex,
    task,
    owner,
    due,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_action_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActionItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('task')) {
      context.handle(
        _taskMeta,
        task.isAcceptableOrUnknown(data['task']!, _taskMeta),
      );
    } else if (isInserting) {
      context.missing(_taskMeta);
    }
    if (data.containsKey('owner')) {
      context.handle(
        _ownerMeta,
        owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta),
      );
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActionItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActionItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      task: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task'],
      )!,
      owner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner'],
      ),
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due'],
      ),
    );
  }

  @override
  $ReportActionItemsTable createAlias(String alias) {
    return $ReportActionItemsTable(attachedDatabase, alias);
  }
}

class ActionItemRow extends DataClass implements Insertable<ActionItemRow> {
  final String id;
  final String reportId;
  final int orderIndex;
  final String task;
  final String? owner;
  final String? due;
  const ActionItemRow({
    required this.id,
    required this.reportId,
    required this.orderIndex,
    required this.task,
    this.owner,
    this.due,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['report_id'] = Variable<String>(reportId);
    map['order_index'] = Variable<int>(orderIndex);
    map['task'] = Variable<String>(task);
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String>(owner);
    }
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<String>(due);
    }
    return map;
  }

  ReportActionItemsCompanion toCompanion(bool nullToAbsent) {
    return ReportActionItemsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      orderIndex: Value(orderIndex),
      task: Value(task),
      owner: owner == null && nullToAbsent
          ? const Value.absent()
          : Value(owner),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
    );
  }

  factory ActionItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActionItemRow(
      id: serializer.fromJson<String>(json['id']),
      reportId: serializer.fromJson<String>(json['reportId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      task: serializer.fromJson<String>(json['task']),
      owner: serializer.fromJson<String?>(json['owner']),
      due: serializer.fromJson<String?>(json['due']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reportId': serializer.toJson<String>(reportId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'task': serializer.toJson<String>(task),
      'owner': serializer.toJson<String?>(owner),
      'due': serializer.toJson<String?>(due),
    };
  }

  ActionItemRow copyWith({
    String? id,
    String? reportId,
    int? orderIndex,
    String? task,
    Value<String?> owner = const Value.absent(),
    Value<String?> due = const Value.absent(),
  }) => ActionItemRow(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    orderIndex: orderIndex ?? this.orderIndex,
    task: task ?? this.task,
    owner: owner.present ? owner.value : this.owner,
    due: due.present ? due.value : this.due,
  );
  ActionItemRow copyWithCompanion(ReportActionItemsCompanion data) {
    return ActionItemRow(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      task: data.task.present ? data.task.value : this.task,
      owner: data.owner.present ? data.owner.value : this.owner,
      due: data.due.present ? data.due.value : this.due,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActionItemRow(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('task: $task, ')
          ..write('owner: $owner, ')
          ..write('due: $due')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reportId, orderIndex, task, owner, due);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActionItemRow &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.orderIndex == this.orderIndex &&
          other.task == this.task &&
          other.owner == this.owner &&
          other.due == this.due);
}

class ReportActionItemsCompanion extends UpdateCompanion<ActionItemRow> {
  final Value<String> id;
  final Value<String> reportId;
  final Value<int> orderIndex;
  final Value<String> task;
  final Value<String?> owner;
  final Value<String?> due;
  final Value<int> rowid;
  const ReportActionItemsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.task = const Value.absent(),
    this.owner = const Value.absent(),
    this.due = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportActionItemsCompanion.insert({
    required String id,
    required String reportId,
    required int orderIndex,
    required String task,
    this.owner = const Value.absent(),
    this.due = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reportId = Value(reportId),
       orderIndex = Value(orderIndex),
       task = Value(task);
  static Insertable<ActionItemRow> custom({
    Expression<String>? id,
    Expression<String>? reportId,
    Expression<int>? orderIndex,
    Expression<String>? task,
    Expression<String>? owner,
    Expression<String>? due,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (task != null) 'task': task,
      if (owner != null) 'owner': owner,
      if (due != null) 'due': due,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportActionItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? reportId,
    Value<int>? orderIndex,
    Value<String>? task,
    Value<String?>? owner,
    Value<String?>? due,
    Value<int>? rowid,
  }) {
    return ReportActionItemsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      orderIndex: orderIndex ?? this.orderIndex,
      task: task ?? this.task,
      owner: owner ?? this.owner,
      due: due ?? this.due,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<String>(reportId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (task.present) {
      map['task'] = Variable<String>(task.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (due.present) {
      map['due'] = Variable<String>(due.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportActionItemsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('task: $task, ')
          ..write('owner: $owner, ')
          ..write('due: $due, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeetingMarkdownsTable extends MeetingMarkdowns
    with TableInfo<$MeetingMarkdownsTable, MeetingMarkdownRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingMarkdownsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meetings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMarkdownMeta = const VerificationMeta(
    'contentMarkdown',
  );
  @override
  late final GeneratedColumn<String> contentMarkdown = GeneratedColumn<String>(
    'content_markdown',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    contentMarkdown,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_markdowns';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingMarkdownRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('content_markdown')) {
      context.handle(
        _contentMarkdownMeta,
        contentMarkdown.isAcceptableOrUnknown(
          data['content_markdown']!,
          _contentMarkdownMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentMarkdownMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeetingMarkdownRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingMarkdownRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      contentMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_markdown'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $MeetingMarkdownsTable createAlias(String alias) {
    return $MeetingMarkdownsTable(attachedDatabase, alias);
  }
}

class MeetingMarkdownRow extends DataClass
    implements Insertable<MeetingMarkdownRow> {
  final String id;
  final String meetingId;
  final String contentMarkdown;
  final DateTime generatedAt;
  const MeetingMarkdownRow({
    required this.id,
    required this.meetingId,
    required this.contentMarkdown,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['content_markdown'] = Variable<String>(contentMarkdown);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  MeetingMarkdownsCompanion toCompanion(bool nullToAbsent) {
    return MeetingMarkdownsCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      contentMarkdown: Value(contentMarkdown),
      generatedAt: Value(generatedAt),
    );
  }

  factory MeetingMarkdownRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingMarkdownRow(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      contentMarkdown: serializer.fromJson<String>(json['contentMarkdown']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'contentMarkdown': serializer.toJson<String>(contentMarkdown),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  MeetingMarkdownRow copyWith({
    String? id,
    String? meetingId,
    String? contentMarkdown,
    DateTime? generatedAt,
  }) => MeetingMarkdownRow(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    contentMarkdown: contentMarkdown ?? this.contentMarkdown,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  MeetingMarkdownRow copyWithCompanion(MeetingMarkdownsCompanion data) {
    return MeetingMarkdownRow(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      contentMarkdown: data.contentMarkdown.present
          ? data.contentMarkdown.value
          : this.contentMarkdown,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingMarkdownRow(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('contentMarkdown: $contentMarkdown, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, meetingId, contentMarkdown, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingMarkdownRow &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.contentMarkdown == this.contentMarkdown &&
          other.generatedAt == this.generatedAt);
}

class MeetingMarkdownsCompanion extends UpdateCompanion<MeetingMarkdownRow> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<String> contentMarkdown;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const MeetingMarkdownsCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.contentMarkdown = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingMarkdownsCompanion.insert({
    required String id,
    required String meetingId,
    required String contentMarkdown,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       contentMarkdown = Value(contentMarkdown),
       generatedAt = Value(generatedAt);
  static Insertable<MeetingMarkdownRow> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? contentMarkdown,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (contentMarkdown != null) 'content_markdown': contentMarkdown,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingMarkdownsCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<String>? contentMarkdown,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return MeetingMarkdownsCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      contentMarkdown: contentMarkdown ?? this.contentMarkdown,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (contentMarkdown.present) {
      map['content_markdown'] = Variable<String>(contentMarkdown.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingMarkdownsCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('contentMarkdown: $contentMarkdown, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsageRecordsTable extends UsageRecords
    with TableInfo<$UsageRecordsTable, UsageRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioSecondsMeta = const VerificationMeta(
    'audioSeconds',
  );
  @override
  late final GeneratedColumn<int> audioSeconds = GeneratedColumn<int>(
    'audio_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostUsdMeta = const VerificationMeta(
    'estimatedCostUsd',
  );
  @override
  late final GeneratedColumn<double> estimatedCostUsd = GeneratedColumn<double>(
    'estimated_cost_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    projectId,
    operationType,
    model,
    audioSeconds,
    inputTokens,
    outputTokens,
    estimatedCostUsd,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsageRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('audio_seconds')) {
      context.handle(
        _audioSecondsMeta,
        audioSeconds.isAcceptableOrUnknown(
          data['audio_seconds']!,
          _audioSecondsMeta,
        ),
      );
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('estimated_cost_usd')) {
      context.handle(
        _estimatedCostUsdMeta,
        estimatedCostUsd.isAcceptableOrUnknown(
          data['estimated_cost_usd']!,
          _estimatedCostUsdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedCostUsdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      audioSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}audio_seconds'],
      ),
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      ),
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      ),
      estimatedCostUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost_usd'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $UsageRecordsTable createAlias(String alias) {
    return $UsageRecordsTable(attachedDatabase, alias);
  }
}

class UsageRecordRow extends DataClass implements Insertable<UsageRecordRow> {
  final String id;
  final String? meetingId;
  final String? projectId;
  final String operationType;
  final String model;
  final int? audioSeconds;
  final int? inputTokens;
  final int? outputTokens;
  final double estimatedCostUsd;
  final DateTime timestamp;
  const UsageRecordRow({
    required this.id,
    this.meetingId,
    this.projectId,
    required this.operationType,
    required this.model,
    this.audioSeconds,
    this.inputTokens,
    this.outputTokens,
    required this.estimatedCostUsd,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || meetingId != null) {
      map['meeting_id'] = Variable<String>(meetingId);
    }
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    map['operation_type'] = Variable<String>(operationType);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || audioSeconds != null) {
      map['audio_seconds'] = Variable<int>(audioSeconds);
    }
    if (!nullToAbsent || inputTokens != null) {
      map['input_tokens'] = Variable<int>(inputTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    map['estimated_cost_usd'] = Variable<double>(estimatedCostUsd);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  UsageRecordsCompanion toCompanion(bool nullToAbsent) {
    return UsageRecordsCompanion(
      id: Value(id),
      meetingId: meetingId == null && nullToAbsent
          ? const Value.absent()
          : Value(meetingId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      operationType: Value(operationType),
      model: Value(model),
      audioSeconds: audioSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(audioSeconds),
      inputTokens: inputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(inputTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      estimatedCostUsd: Value(estimatedCostUsd),
      timestamp: Value(timestamp),
    );
  }

  factory UsageRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageRecordRow(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String?>(json['meetingId']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      operationType: serializer.fromJson<String>(json['operationType']),
      model: serializer.fromJson<String>(json['model']),
      audioSeconds: serializer.fromJson<int?>(json['audioSeconds']),
      inputTokens: serializer.fromJson<int?>(json['inputTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      estimatedCostUsd: serializer.fromJson<double>(json['estimatedCostUsd']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String?>(meetingId),
      'projectId': serializer.toJson<String?>(projectId),
      'operationType': serializer.toJson<String>(operationType),
      'model': serializer.toJson<String>(model),
      'audioSeconds': serializer.toJson<int?>(audioSeconds),
      'inputTokens': serializer.toJson<int?>(inputTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'estimatedCostUsd': serializer.toJson<double>(estimatedCostUsd),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  UsageRecordRow copyWith({
    String? id,
    Value<String?> meetingId = const Value.absent(),
    Value<String?> projectId = const Value.absent(),
    String? operationType,
    String? model,
    Value<int?> audioSeconds = const Value.absent(),
    Value<int?> inputTokens = const Value.absent(),
    Value<int?> outputTokens = const Value.absent(),
    double? estimatedCostUsd,
    DateTime? timestamp,
  }) => UsageRecordRow(
    id: id ?? this.id,
    meetingId: meetingId.present ? meetingId.value : this.meetingId,
    projectId: projectId.present ? projectId.value : this.projectId,
    operationType: operationType ?? this.operationType,
    model: model ?? this.model,
    audioSeconds: audioSeconds.present ? audioSeconds.value : this.audioSeconds,
    inputTokens: inputTokens.present ? inputTokens.value : this.inputTokens,
    outputTokens: outputTokens.present ? outputTokens.value : this.outputTokens,
    estimatedCostUsd: estimatedCostUsd ?? this.estimatedCostUsd,
    timestamp: timestamp ?? this.timestamp,
  );
  UsageRecordRow copyWithCompanion(UsageRecordsCompanion data) {
    return UsageRecordRow(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      model: data.model.present ? data.model.value : this.model,
      audioSeconds: data.audioSeconds.present
          ? data.audioSeconds.value
          : this.audioSeconds,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      estimatedCostUsd: data.estimatedCostUsd.present
          ? data.estimatedCostUsd.value
          : this.estimatedCostUsd,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageRecordRow(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('projectId: $projectId, ')
          ..write('operationType: $operationType, ')
          ..write('model: $model, ')
          ..write('audioSeconds: $audioSeconds, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('estimatedCostUsd: $estimatedCostUsd, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    meetingId,
    projectId,
    operationType,
    model,
    audioSeconds,
    inputTokens,
    outputTokens,
    estimatedCostUsd,
    timestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageRecordRow &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.projectId == this.projectId &&
          other.operationType == this.operationType &&
          other.model == this.model &&
          other.audioSeconds == this.audioSeconds &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.estimatedCostUsd == this.estimatedCostUsd &&
          other.timestamp == this.timestamp);
}

class UsageRecordsCompanion extends UpdateCompanion<UsageRecordRow> {
  final Value<String> id;
  final Value<String?> meetingId;
  final Value<String?> projectId;
  final Value<String> operationType;
  final Value<String> model;
  final Value<int?> audioSeconds;
  final Value<int?> inputTokens;
  final Value<int?> outputTokens;
  final Value<double> estimatedCostUsd;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const UsageRecordsCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.operationType = const Value.absent(),
    this.model = const Value.absent(),
    this.audioSeconds = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.estimatedCostUsd = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsageRecordsCompanion.insert({
    required String id,
    this.meetingId = const Value.absent(),
    this.projectId = const Value.absent(),
    required String operationType,
    required String model,
    this.audioSeconds = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    required double estimatedCostUsd,
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       operationType = Value(operationType),
       model = Value(model),
       estimatedCostUsd = Value(estimatedCostUsd),
       timestamp = Value(timestamp);
  static Insertable<UsageRecordRow> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? projectId,
    Expression<String>? operationType,
    Expression<String>? model,
    Expression<int>? audioSeconds,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<double>? estimatedCostUsd,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (projectId != null) 'project_id': projectId,
      if (operationType != null) 'operation_type': operationType,
      if (model != null) 'model': model,
      if (audioSeconds != null) 'audio_seconds': audioSeconds,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (estimatedCostUsd != null) 'estimated_cost_usd': estimatedCostUsd,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsageRecordsCompanion copyWith({
    Value<String>? id,
    Value<String?>? meetingId,
    Value<String?>? projectId,
    Value<String>? operationType,
    Value<String>? model,
    Value<int?>? audioSeconds,
    Value<int?>? inputTokens,
    Value<int?>? outputTokens,
    Value<double>? estimatedCostUsd,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return UsageRecordsCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      projectId: projectId ?? this.projectId,
      operationType: operationType ?? this.operationType,
      model: model ?? this.model,
      audioSeconds: audioSeconds ?? this.audioSeconds,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      estimatedCostUsd: estimatedCostUsd ?? this.estimatedCostUsd,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (audioSeconds.present) {
      map['audio_seconds'] = Variable<int>(audioSeconds.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (estimatedCostUsd.present) {
      map['estimated_cost_usd'] = Variable<double>(estimatedCostUsd.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageRecordsCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('projectId: $projectId, ')
          ..write('operationType: $operationType, ')
          ..write('model: $model, ')
          ..write('audioSeconds: $audioSeconds, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('estimatedCostUsd: $estimatedCostUsd, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QaThreadsTable extends QaThreads
    with TableInfo<$QaThreadsTable, QaThreadRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QaThreadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, projectId, title, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qa_threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<QaThreadRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QaThreadRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QaThreadRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QaThreadsTable createAlias(String alias) {
    return $QaThreadsTable(attachedDatabase, alias);
  }
}

class QaThreadRow extends DataClass implements Insertable<QaThreadRow> {
  final String id;
  final String projectId;
  final String title;
  final DateTime createdAt;
  const QaThreadRow({
    required this.id,
    required this.projectId,
    required this.title,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QaThreadsCompanion toCompanion(bool nullToAbsent) {
    return QaThreadsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      title: Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory QaThreadRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QaThreadRow(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QaThreadRow copyWith({
    String? id,
    String? projectId,
    String? title,
    DateTime? createdAt,
  }) => QaThreadRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
  );
  QaThreadRow copyWithCompanion(QaThreadsCompanion data) {
    return QaThreadRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QaThreadRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectId, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QaThreadRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class QaThreadsCompanion extends UpdateCompanion<QaThreadRow> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QaThreadsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QaThreadsCompanion.insert({
    required String id,
    required String projectId,
    required String title,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectId = Value(projectId),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<QaThreadRow> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QaThreadsCompanion copyWith({
    Value<String>? id,
    Value<String>? projectId,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return QaThreadsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QaThreadsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QaMessagesTable extends QaMessages
    with TableInfo<$QaMessagesTable, QaMessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QaMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta(
    'threadId',
  );
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES qa_threads (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _citedMeetingIdsJsonMeta =
      const VerificationMeta('citedMeetingIdsJson');
  @override
  late final GeneratedColumn<String> citedMeetingIdsJson =
      GeneratedColumn<String>(
        'cited_meeting_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _usageRecordIdMeta = const VerificationMeta(
    'usageRecordId',
  );
  @override
  late final GeneratedColumn<String> usageRecordId = GeneratedColumn<String>(
    'usage_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    threadId,
    role,
    content,
    timestamp,
    citedMeetingIdsJson,
    usageRecordId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qa_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<QaMessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(
        _threadIdMeta,
        threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta),
      );
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('cited_meeting_ids_json')) {
      context.handle(
        _citedMeetingIdsJsonMeta,
        citedMeetingIdsJson.isAcceptableOrUnknown(
          data['cited_meeting_ids_json']!,
          _citedMeetingIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('usage_record_id')) {
      context.handle(
        _usageRecordIdMeta,
        usageRecordId.isAcceptableOrUnknown(
          data['usage_record_id']!,
          _usageRecordIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QaMessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QaMessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      threadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      citedMeetingIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cited_meeting_ids_json'],
      )!,
      usageRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_record_id'],
      ),
    );
  }

  @override
  $QaMessagesTable createAlias(String alias) {
    return $QaMessagesTable(attachedDatabase, alias);
  }
}

class QaMessageRow extends DataClass implements Insertable<QaMessageRow> {
  final String id;
  final String threadId;
  final String role;
  final String content;
  final DateTime timestamp;
  final String citedMeetingIdsJson;
  final String? usageRecordId;
  const QaMessageRow({
    required this.id,
    required this.threadId,
    required this.role,
    required this.content,
    required this.timestamp,
    required this.citedMeetingIdsJson,
    this.usageRecordId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['thread_id'] = Variable<String>(threadId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['cited_meeting_ids_json'] = Variable<String>(citedMeetingIdsJson);
    if (!nullToAbsent || usageRecordId != null) {
      map['usage_record_id'] = Variable<String>(usageRecordId);
    }
    return map;
  }

  QaMessagesCompanion toCompanion(bool nullToAbsent) {
    return QaMessagesCompanion(
      id: Value(id),
      threadId: Value(threadId),
      role: Value(role),
      content: Value(content),
      timestamp: Value(timestamp),
      citedMeetingIdsJson: Value(citedMeetingIdsJson),
      usageRecordId: usageRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(usageRecordId),
    );
  }

  factory QaMessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QaMessageRow(
      id: serializer.fromJson<String>(json['id']),
      threadId: serializer.fromJson<String>(json['threadId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      citedMeetingIdsJson: serializer.fromJson<String>(
        json['citedMeetingIdsJson'],
      ),
      usageRecordId: serializer.fromJson<String?>(json['usageRecordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'threadId': serializer.toJson<String>(threadId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'citedMeetingIdsJson': serializer.toJson<String>(citedMeetingIdsJson),
      'usageRecordId': serializer.toJson<String?>(usageRecordId),
    };
  }

  QaMessageRow copyWith({
    String? id,
    String? threadId,
    String? role,
    String? content,
    DateTime? timestamp,
    String? citedMeetingIdsJson,
    Value<String?> usageRecordId = const Value.absent(),
  }) => QaMessageRow(
    id: id ?? this.id,
    threadId: threadId ?? this.threadId,
    role: role ?? this.role,
    content: content ?? this.content,
    timestamp: timestamp ?? this.timestamp,
    citedMeetingIdsJson: citedMeetingIdsJson ?? this.citedMeetingIdsJson,
    usageRecordId: usageRecordId.present
        ? usageRecordId.value
        : this.usageRecordId,
  );
  QaMessageRow copyWithCompanion(QaMessagesCompanion data) {
    return QaMessageRow(
      id: data.id.present ? data.id.value : this.id,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      citedMeetingIdsJson: data.citedMeetingIdsJson.present
          ? data.citedMeetingIdsJson.value
          : this.citedMeetingIdsJson,
      usageRecordId: data.usageRecordId.present
          ? data.usageRecordId.value
          : this.usageRecordId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QaMessageRow(')
          ..write('id: $id, ')
          ..write('threadId: $threadId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('citedMeetingIdsJson: $citedMeetingIdsJson, ')
          ..write('usageRecordId: $usageRecordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    threadId,
    role,
    content,
    timestamp,
    citedMeetingIdsJson,
    usageRecordId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QaMessageRow &&
          other.id == this.id &&
          other.threadId == this.threadId &&
          other.role == this.role &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.citedMeetingIdsJson == this.citedMeetingIdsJson &&
          other.usageRecordId == this.usageRecordId);
}

class QaMessagesCompanion extends UpdateCompanion<QaMessageRow> {
  final Value<String> id;
  final Value<String> threadId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> timestamp;
  final Value<String> citedMeetingIdsJson;
  final Value<String?> usageRecordId;
  final Value<int> rowid;
  const QaMessagesCompanion({
    this.id = const Value.absent(),
    this.threadId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.citedMeetingIdsJson = const Value.absent(),
    this.usageRecordId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QaMessagesCompanion.insert({
    required String id,
    required String threadId,
    required String role,
    required String content,
    required DateTime timestamp,
    this.citedMeetingIdsJson = const Value.absent(),
    this.usageRecordId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       threadId = Value(threadId),
       role = Value(role),
       content = Value(content),
       timestamp = Value(timestamp);
  static Insertable<QaMessageRow> custom({
    Expression<String>? id,
    Expression<String>? threadId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? timestamp,
    Expression<String>? citedMeetingIdsJson,
    Expression<String>? usageRecordId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (threadId != null) 'thread_id': threadId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (citedMeetingIdsJson != null)
        'cited_meeting_ids_json': citedMeetingIdsJson,
      if (usageRecordId != null) 'usage_record_id': usageRecordId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QaMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? threadId,
    Value<String>? role,
    Value<String>? content,
    Value<DateTime>? timestamp,
    Value<String>? citedMeetingIdsJson,
    Value<String?>? usageRecordId,
    Value<int>? rowid,
  }) {
    return QaMessagesCompanion(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      citedMeetingIdsJson: citedMeetingIdsJson ?? this.citedMeetingIdsJson,
      usageRecordId: usageRecordId ?? this.usageRecordId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (citedMeetingIdsJson.present) {
      map['cited_meeting_ids_json'] = Variable<String>(
        citedMeetingIdsJson.value,
      );
    }
    if (usageRecordId.present) {
      map['usage_record_id'] = Variable<String>(usageRecordId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QaMessagesCompanion(')
          ..write('id: $id, ')
          ..write('threadId: $threadId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('citedMeetingIdsJson: $citedMeetingIdsJson, ')
          ..write('usageRecordId: $usageRecordId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $ProjectContextsTable projectContexts = $ProjectContextsTable(
    this,
  );
  late final $MeetingsTable meetings = $MeetingsTable(this);
  late final $RecordingsTable recordings = $RecordingsTable(this);
  late final $RecordingTranscriptsTable recordingTranscripts =
      $RecordingTranscriptsTable(this);
  late final $TranscriptsTable transcripts = $TranscriptsTable(this);
  late final $MeetingReportsTable meetingReports = $MeetingReportsTable(this);
  late final $ReportProblemsTable reportProblems = $ReportProblemsTable(this);
  late final $ReportDecisionsTable reportDecisions = $ReportDecisionsTable(
    this,
  );
  late final $ReportActionItemsTable reportActionItems =
      $ReportActionItemsTable(this);
  late final $MeetingMarkdownsTable meetingMarkdowns = $MeetingMarkdownsTable(
    this,
  );
  late final $UsageRecordsTable usageRecords = $UsageRecordsTable(this);
  late final $QaThreadsTable qaThreads = $QaThreadsTable(this);
  late final $QaMessagesTable qaMessages = $QaMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    projectContexts,
    meetings,
    recordings,
    recordingTranscripts,
    transcripts,
    meetingReports,
    reportProblems,
    reportDecisions,
    reportActionItems,
    meetingMarkdowns,
    usageRecords,
    qaThreads,
    qaMessages,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('project_contexts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meetings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meetings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recordings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recordings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recording_transcripts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meetings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transcripts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meetings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meeting_reports', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meeting_reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('report_problems', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meeting_reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('report_decisions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meeting_reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('report_action_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meetings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meeting_markdowns', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('qa_threads', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'qa_threads',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('qa_messages', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String id,
      required String name,
      Value<String> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int?> colorValue,
      Value<int?> iconCodePoint,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> colorValue,
      Value<int?> iconCodePoint,
      Value<int> rowid,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, ProjectRow> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProjectContextsTable, List<ProjectContextRow>>
  _projectContextsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.projectContexts,
    aliasName: 'projects__id__project_contexts__project_id',
  );

  $$ProjectContextsTableProcessedTableManager get projectContextsRefs {
    final manager = $$ProjectContextsTableTableManager(
      $_db,
      $_db.projectContexts,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _projectContextsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeetingsTable, List<MeetingRow>>
  _meetingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meetings,
    aliasName: 'projects__id__meetings__project_id',
  );

  $$MeetingsTableProcessedTableManager get meetingsRefs {
    final manager = $$MeetingsTableTableManager(
      $_db,
      $_db.meetings,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_meetingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QaThreadsTable, List<QaThreadRow>>
  _qaThreadsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.qaThreads,
    aliasName: 'projects__id__qa_threads__project_id',
  );

  $$QaThreadsTableProcessedTableManager get qaThreadsRefs {
    final manager = $$QaThreadsTableTableManager(
      $_db,
      $_db.qaThreads,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_qaThreadsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> projectContextsRefs(
    Expression<bool> Function($$ProjectContextsTableFilterComposer f) f,
  ) {
    final $$ProjectContextsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectContexts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectContextsTableFilterComposer(
            $db: $db,
            $table: $db.projectContexts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> meetingsRefs(
    Expression<bool> Function($$MeetingsTableFilterComposer f) f,
  ) {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableFilterComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> qaThreadsRefs(
    Expression<bool> Function($$QaThreadsTableFilterComposer f) f,
  ) {
    final $$QaThreadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.qaThreads,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaThreadsTableFilterComposer(
            $db: $db,
            $table: $db.qaThreads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  Expression<T> projectContextsRefs<T extends Object>(
    Expression<T> Function($$ProjectContextsTableAnnotationComposer a) f,
  ) {
    final $$ProjectContextsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projectContexts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectContextsTableAnnotationComposer(
            $db: $db,
            $table: $db.projectContexts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> meetingsRefs<T extends Object>(
    Expression<T> Function($$MeetingsTableAnnotationComposer a) f,
  ) {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> qaThreadsRefs<T extends Object>(
    Expression<T> Function($$QaThreadsTableAnnotationComposer a) f,
  ) {
    final $$QaThreadsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.qaThreads,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaThreadsTableAnnotationComposer(
            $db: $db,
            $table: $db.qaThreads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          ProjectRow,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (ProjectRow, $$ProjectsTableReferences),
          ProjectRow,
          PrefetchHooks Function({
            bool projectContextsRefs,
            bool meetingsRefs,
            bool qaThreadsRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<int?> iconCodePoint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                colorValue: colorValue,
                iconCodePoint: iconCodePoint,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int?> colorValue = const Value.absent(),
                Value<int?> iconCodePoint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                colorValue: colorValue,
                iconCodePoint: iconCodePoint,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectContextsRefs = false,
                meetingsRefs = false,
                qaThreadsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectContextsRefs) db.projectContexts,
                    if (meetingsRefs) db.meetings,
                    if (qaThreadsRefs) db.qaThreads,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectContextsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ProjectContextRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._projectContextsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).projectContextsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (meetingsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          MeetingRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._meetingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).meetingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (qaThreadsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          QaThreadRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._qaThreadsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).qaThreadsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      ProjectRow,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (ProjectRow, $$ProjectsTableReferences),
      ProjectRow,
      PrefetchHooks Function({
        bool projectContextsRefs,
        bool meetingsRefs,
        bool qaThreadsRefs,
      })
    >;
typedef $$ProjectContextsTableCreateCompanionBuilder =
    ProjectContextsCompanion Function({
      required String id,
      required String projectId,
      required String overviewMarkdown,
      required DateTime updatedAt,
      Value<String> sourceMeetingIdsJson,
      Value<int> rowid,
    });
typedef $$ProjectContextsTableUpdateCompanionBuilder =
    ProjectContextsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> overviewMarkdown,
      Value<DateTime> updatedAt,
      Value<String> sourceMeetingIdsJson,
      Value<int> rowid,
    });

final class $$ProjectContextsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProjectContextsTable,
          ProjectContextRow
        > {
  $$ProjectContextsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('project_contexts__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProjectContextsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectContextsTable> {
  $$ProjectContextsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overviewMarkdown => $composableBuilder(
    column: $table.overviewMarkdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceMeetingIdsJson => $composableBuilder(
    column: $table.sourceMeetingIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectContextsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectContextsTable> {
  $$ProjectContextsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overviewMarkdown => $composableBuilder(
    column: $table.overviewMarkdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceMeetingIdsJson => $composableBuilder(
    column: $table.sourceMeetingIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectContextsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectContextsTable> {
  $$ProjectContextsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get overviewMarkdown => $composableBuilder(
    column: $table.overviewMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get sourceMeetingIdsJson => $composableBuilder(
    column: $table.sourceMeetingIdsJson,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectContextsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectContextsTable,
          ProjectContextRow,
          $$ProjectContextsTableFilterComposer,
          $$ProjectContextsTableOrderingComposer,
          $$ProjectContextsTableAnnotationComposer,
          $$ProjectContextsTableCreateCompanionBuilder,
          $$ProjectContextsTableUpdateCompanionBuilder,
          (ProjectContextRow, $$ProjectContextsTableReferences),
          ProjectContextRow,
          PrefetchHooks Function({bool projectId})
        > {
  $$ProjectContextsTableTableManager(
    _$AppDatabase db,
    $ProjectContextsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectContextsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectContextsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectContextsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> overviewMarkdown = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> sourceMeetingIdsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectContextsCompanion(
                id: id,
                projectId: projectId,
                overviewMarkdown: overviewMarkdown,
                updatedAt: updatedAt,
                sourceMeetingIdsJson: sourceMeetingIdsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String overviewMarkdown,
                required DateTime updatedAt,
                Value<String> sourceMeetingIdsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectContextsCompanion.insert(
                id: id,
                projectId: projectId,
                overviewMarkdown: overviewMarkdown,
                updatedAt: updatedAt,
                sourceMeetingIdsJson: sourceMeetingIdsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectContextsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable:
                                    $$ProjectContextsTableReferences
                                        ._projectIdTable(db),
                                referencedColumn:
                                    $$ProjectContextsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProjectContextsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectContextsTable,
      ProjectContextRow,
      $$ProjectContextsTableFilterComposer,
      $$ProjectContextsTableOrderingComposer,
      $$ProjectContextsTableAnnotationComposer,
      $$ProjectContextsTableCreateCompanionBuilder,
      $$ProjectContextsTableUpdateCompanionBuilder,
      (ProjectContextRow, $$ProjectContextsTableReferences),
      ProjectContextRow,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$MeetingsTableCreateCompanionBuilder =
    MeetingsCompanion Function({
      required String id,
      required String projectId,
      required String title,
      required DateTime createdAt,
      required String status,
      Value<String?> errorMessage,
      Value<bool> needsReanalysis,
      Value<int> rowid,
    });
typedef $$MeetingsTableUpdateCompanionBuilder =
    MeetingsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<String?> errorMessage,
      Value<bool> needsReanalysis,
      Value<int> rowid,
    });

final class $$MeetingsTableReferences
    extends BaseReferences<_$AppDatabase, $MeetingsTable, MeetingRow> {
  $$MeetingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('meetings__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RecordingsTable, List<RecordingRow>>
  _recordingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recordings,
    aliasName: 'meetings__id__recordings__meeting_id',
  );

  $$RecordingsTableProcessedTableManager get recordingsRefs {
    final manager = $$RecordingsTableTableManager(
      $_db,
      $_db.recordings,
    ).filter((f) => f.meetingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recordingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TranscriptsTable, List<TranscriptRow>>
  _transcriptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transcripts,
    aliasName: 'meetings__id__transcripts__meeting_id',
  );

  $$TranscriptsTableProcessedTableManager get transcriptsRefs {
    final manager = $$TranscriptsTableTableManager(
      $_db,
      $_db.transcripts,
    ).filter((f) => f.meetingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transcriptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeetingReportsTable, List<MeetingReportRow>>
  _meetingReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meetingReports,
    aliasName: 'meetings__id__meeting_reports__meeting_id',
  );

  $$MeetingReportsTableProcessedTableManager get meetingReportsRefs {
    final manager = $$MeetingReportsTableTableManager(
      $_db,
      $_db.meetingReports,
    ).filter((f) => f.meetingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_meetingReportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeetingMarkdownsTable, List<MeetingMarkdownRow>>
  _meetingMarkdownsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.meetingMarkdowns,
    aliasName: 'meetings__id__meeting_markdowns__meeting_id',
  );

  $$MeetingMarkdownsTableProcessedTableManager get meetingMarkdownsRefs {
    final manager = $$MeetingMarkdownsTableTableManager(
      $_db,
      $_db.meetingMarkdowns,
    ).filter((f) => f.meetingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _meetingMarkdownsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeetingsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsReanalysis => $composableBuilder(
    column: $table.needsReanalysis,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recordingsRefs(
    Expression<bool> Function($$RecordingsTableFilterComposer f) f,
  ) {
    final $$RecordingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recordings,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingsTableFilterComposer(
            $db: $db,
            $table: $db.recordings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transcriptsRefs(
    Expression<bool> Function($$TranscriptsTableFilterComposer f) f,
  ) {
    final $$TranscriptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transcripts,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TranscriptsTableFilterComposer(
            $db: $db,
            $table: $db.transcripts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> meetingReportsRefs(
    Expression<bool> Function($$MeetingReportsTableFilterComposer f) f,
  ) {
    final $$MeetingReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableFilterComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> meetingMarkdownsRefs(
    Expression<bool> Function($$MeetingMarkdownsTableFilterComposer f) f,
  ) {
    final $$MeetingMarkdownsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetingMarkdowns,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingMarkdownsTableFilterComposer(
            $db: $db,
            $table: $db.meetingMarkdowns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetingsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsReanalysis => $composableBuilder(
    column: $table.needsReanalysis,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingsTable> {
  $$MeetingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsReanalysis => $composableBuilder(
    column: $table.needsReanalysis,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recordingsRefs<T extends Object>(
    Expression<T> Function($$RecordingsTableAnnotationComposer a) f,
  ) {
    final $$RecordingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recordings,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingsTableAnnotationComposer(
            $db: $db,
            $table: $db.recordings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transcriptsRefs<T extends Object>(
    Expression<T> Function($$TranscriptsTableAnnotationComposer a) f,
  ) {
    final $$TranscriptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transcripts,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TranscriptsTableAnnotationComposer(
            $db: $db,
            $table: $db.transcripts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> meetingReportsRefs<T extends Object>(
    Expression<T> Function($$MeetingReportsTableAnnotationComposer a) f,
  ) {
    final $$MeetingReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> meetingMarkdownsRefs<T extends Object>(
    Expression<T> Function($$MeetingMarkdownsTableAnnotationComposer a) f,
  ) {
    final $$MeetingMarkdownsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meetingMarkdowns,
      getReferencedColumn: (t) => t.meetingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingMarkdownsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetingMarkdowns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingsTable,
          MeetingRow,
          $$MeetingsTableFilterComposer,
          $$MeetingsTableOrderingComposer,
          $$MeetingsTableAnnotationComposer,
          $$MeetingsTableCreateCompanionBuilder,
          $$MeetingsTableUpdateCompanionBuilder,
          (MeetingRow, $$MeetingsTableReferences),
          MeetingRow,
          PrefetchHooks Function({
            bool projectId,
            bool recordingsRefs,
            bool transcriptsRefs,
            bool meetingReportsRefs,
            bool meetingMarkdownsRefs,
          })
        > {
  $$MeetingsTableTableManager(_$AppDatabase db, $MeetingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<bool> needsReanalysis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingsCompanion(
                id: id,
                projectId: projectId,
                title: title,
                createdAt: createdAt,
                status: status,
                errorMessage: errorMessage,
                needsReanalysis: needsReanalysis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String title,
                required DateTime createdAt,
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                Value<bool> needsReanalysis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingsCompanion.insert(
                id: id,
                projectId: projectId,
                title: title,
                createdAt: createdAt,
                status: status,
                errorMessage: errorMessage,
                needsReanalysis: needsReanalysis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeetingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                recordingsRefs = false,
                transcriptsRefs = false,
                meetingReportsRefs = false,
                meetingMarkdownsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recordingsRefs) db.recordings,
                    if (transcriptsRefs) db.transcripts,
                    if (meetingReportsRefs) db.meetingReports,
                    if (meetingMarkdownsRefs) db.meetingMarkdowns,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$MeetingsTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$MeetingsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recordingsRefs)
                        await $_getPrefetchedData<
                          MeetingRow,
                          $MeetingsTable,
                          RecordingRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingsTableReferences
                              ._recordingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingsTableReferences(
                                db,
                                table,
                                p0,
                              ).recordingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transcriptsRefs)
                        await $_getPrefetchedData<
                          MeetingRow,
                          $MeetingsTable,
                          TranscriptRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingsTableReferences
                              ._transcriptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingsTableReferences(
                                db,
                                table,
                                p0,
                              ).transcriptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (meetingReportsRefs)
                        await $_getPrefetchedData<
                          MeetingRow,
                          $MeetingsTable,
                          MeetingReportRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingsTableReferences
                              ._meetingReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingsTableReferences(
                                db,
                                table,
                                p0,
                              ).meetingReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetingId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (meetingMarkdownsRefs)
                        await $_getPrefetchedData<
                          MeetingRow,
                          $MeetingsTable,
                          MeetingMarkdownRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingsTableReferences
                              ._meetingMarkdownsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingsTableReferences(
                                db,
                                table,
                                p0,
                              ).meetingMarkdownsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.meetingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MeetingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingsTable,
      MeetingRow,
      $$MeetingsTableFilterComposer,
      $$MeetingsTableOrderingComposer,
      $$MeetingsTableAnnotationComposer,
      $$MeetingsTableCreateCompanionBuilder,
      $$MeetingsTableUpdateCompanionBuilder,
      (MeetingRow, $$MeetingsTableReferences),
      MeetingRow,
      PrefetchHooks Function({
        bool projectId,
        bool recordingsRefs,
        bool transcriptsRefs,
        bool meetingReportsRefs,
        bool meetingMarkdownsRefs,
      })
    >;
typedef $$RecordingsTableCreateCompanionBuilder =
    RecordingsCompanion Function({
      required String id,
      required String meetingId,
      required int orderIndex,
      required String sourceFileName,
      required String localFilePath,
      required int fileSizeBytes,
      Value<int?> audioDurationSeconds,
      required String status,
      Value<int> chunkCount,
      Value<String?> errorMessage,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RecordingsTableUpdateCompanionBuilder =
    RecordingsCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<int> orderIndex,
      Value<String> sourceFileName,
      Value<String> localFilePath,
      Value<int> fileSizeBytes,
      Value<int?> audioDurationSeconds,
      Value<String> status,
      Value<int> chunkCount,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RecordingsTableReferences
    extends BaseReferences<_$AppDatabase, $RecordingsTable, RecordingRow> {
  $$RecordingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MeetingsTable _meetingIdTable(_$AppDatabase db) =>
      db.meetings.createAlias('recordings__meeting_id__meetings__id');

  $$MeetingsTableProcessedTableManager get meetingId {
    final $_column = $_itemColumn<String>('meeting_id')!;

    final manager = $$MeetingsTableTableManager(
      $_db,
      $_db.meetings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $RecordingTranscriptsTable,
    List<RecordingTranscriptRow>
  >
  _recordingTranscriptsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recordingTranscripts,
        aliasName: 'recordings__id__recording_transcripts__recording_id',
      );

  $$RecordingTranscriptsTableProcessedTableManager
  get recordingTranscriptsRefs {
    final manager = $$RecordingTranscriptsTableTableManager(
      $_db,
      $_db.recordingTranscripts,
    ).filter((f) => f.recordingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recordingTranscriptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecordingsTableFilterComposer
    extends Composer<_$AppDatabase, $RecordingsTable> {
  $$RecordingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chunkCount => $composableBuilder(
    column: $table.chunkCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingsTableFilterComposer get meetingId {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableFilterComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recordingTranscriptsRefs(
    Expression<bool> Function($$RecordingTranscriptsTableFilterComposer f) f,
  ) {
    final $$RecordingTranscriptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recordingTranscripts,
      getReferencedColumn: (t) => t.recordingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingTranscriptsTableFilterComposer(
            $db: $db,
            $table: $db.recordingTranscripts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecordingsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordingsTable> {
  $$RecordingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chunkCount => $composableBuilder(
    column: $table.chunkCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingsTableOrderingComposer get meetingId {
    final $$MeetingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableOrderingComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecordingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordingsTable> {
  $$RecordingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceFileName => $composableBuilder(
    column: $table.sourceFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localFilePath => $composableBuilder(
    column: $table.localFilePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get chunkCount => $composableBuilder(
    column: $table.chunkCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MeetingsTableAnnotationComposer get meetingId {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recordingTranscriptsRefs<T extends Object>(
    Expression<T> Function($$RecordingTranscriptsTableAnnotationComposer a) f,
  ) {
    final $$RecordingTranscriptsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordingTranscripts,
          getReferencedColumn: (t) => t.recordingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordingTranscriptsTableAnnotationComposer(
                $db: $db,
                $table: $db.recordingTranscripts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RecordingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordingsTable,
          RecordingRow,
          $$RecordingsTableFilterComposer,
          $$RecordingsTableOrderingComposer,
          $$RecordingsTableAnnotationComposer,
          $$RecordingsTableCreateCompanionBuilder,
          $$RecordingsTableUpdateCompanionBuilder,
          (RecordingRow, $$RecordingsTableReferences),
          RecordingRow,
          PrefetchHooks Function({
            bool meetingId,
            bool recordingTranscriptsRefs,
          })
        > {
  $$RecordingsTableTableManager(_$AppDatabase db, $RecordingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecordingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecordingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecordingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> sourceFileName = const Value.absent(),
                Value<String> localFilePath = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<int?> audioDurationSeconds = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> chunkCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordingsCompanion(
                id: id,
                meetingId: meetingId,
                orderIndex: orderIndex,
                sourceFileName: sourceFileName,
                localFilePath: localFilePath,
                fileSizeBytes: fileSizeBytes,
                audioDurationSeconds: audioDurationSeconds,
                status: status,
                chunkCount: chunkCount,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required int orderIndex,
                required String sourceFileName,
                required String localFilePath,
                required int fileSizeBytes,
                Value<int?> audioDurationSeconds = const Value.absent(),
                required String status,
                Value<int> chunkCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecordingsCompanion.insert(
                id: id,
                meetingId: meetingId,
                orderIndex: orderIndex,
                sourceFileName: sourceFileName,
                localFilePath: localFilePath,
                fileSizeBytes: fileSizeBytes,
                audioDurationSeconds: audioDurationSeconds,
                status: status,
                chunkCount: chunkCount,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecordingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({meetingId = false, recordingTranscriptsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recordingTranscriptsRefs) db.recordingTranscripts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (meetingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.meetingId,
                                    referencedTable: $$RecordingsTableReferences
                                        ._meetingIdTable(db),
                                    referencedColumn:
                                        $$RecordingsTableReferences
                                            ._meetingIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recordingTranscriptsRefs)
                        await $_getPrefetchedData<
                          RecordingRow,
                          $RecordingsTable,
                          RecordingTranscriptRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecordingsTableReferences
                              ._recordingTranscriptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecordingsTableReferences(
                                db,
                                table,
                                p0,
                              ).recordingTranscriptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recordingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecordingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordingsTable,
      RecordingRow,
      $$RecordingsTableFilterComposer,
      $$RecordingsTableOrderingComposer,
      $$RecordingsTableAnnotationComposer,
      $$RecordingsTableCreateCompanionBuilder,
      $$RecordingsTableUpdateCompanionBuilder,
      (RecordingRow, $$RecordingsTableReferences),
      RecordingRow,
      PrefetchHooks Function({bool meetingId, bool recordingTranscriptsRefs})
    >;
typedef $$RecordingTranscriptsTableCreateCompanionBuilder =
    RecordingTranscriptsCompanion Function({
      required String id,
      required String recordingId,
      required String content,
      Value<String?> language,
      Value<int> rowid,
    });
typedef $$RecordingTranscriptsTableUpdateCompanionBuilder =
    RecordingTranscriptsCompanion Function({
      Value<String> id,
      Value<String> recordingId,
      Value<String> content,
      Value<String?> language,
      Value<int> rowid,
    });

final class $$RecordingTranscriptsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecordingTranscriptsTable,
          RecordingTranscriptRow
        > {
  $$RecordingTranscriptsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecordingsTable _recordingIdTable(_$AppDatabase db) => db.recordings
      .createAlias('recording_transcripts__recording_id__recordings__id');

  $$RecordingsTableProcessedTableManager get recordingId {
    final $_column = $_itemColumn<String>('recording_id')!;

    final manager = $$RecordingsTableTableManager(
      $_db,
      $_db.recordings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recordingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecordingTranscriptsTableFilterComposer
    extends Composer<_$AppDatabase, $RecordingTranscriptsTable> {
  $$RecordingTranscriptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  $$RecordingsTableFilterComposer get recordingId {
    final $$RecordingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recordingId,
      referencedTable: $db.recordings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingsTableFilterComposer(
            $db: $db,
            $table: $db.recordings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecordingTranscriptsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordingTranscriptsTable> {
  $$RecordingTranscriptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecordingsTableOrderingComposer get recordingId {
    final $$RecordingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recordingId,
      referencedTable: $db.recordings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingsTableOrderingComposer(
            $db: $db,
            $table: $db.recordings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecordingTranscriptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordingTranscriptsTable> {
  $$RecordingTranscriptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  $$RecordingsTableAnnotationComposer get recordingId {
    final $$RecordingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recordingId,
      referencedTable: $db.recordings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordingsTableAnnotationComposer(
            $db: $db,
            $table: $db.recordings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecordingTranscriptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordingTranscriptsTable,
          RecordingTranscriptRow,
          $$RecordingTranscriptsTableFilterComposer,
          $$RecordingTranscriptsTableOrderingComposer,
          $$RecordingTranscriptsTableAnnotationComposer,
          $$RecordingTranscriptsTableCreateCompanionBuilder,
          $$RecordingTranscriptsTableUpdateCompanionBuilder,
          (RecordingTranscriptRow, $$RecordingTranscriptsTableReferences),
          RecordingTranscriptRow,
          PrefetchHooks Function({bool recordingId})
        > {
  $$RecordingTranscriptsTableTableManager(
    _$AppDatabase db,
    $RecordingTranscriptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecordingTranscriptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecordingTranscriptsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecordingTranscriptsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recordingId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordingTranscriptsCompanion(
                id: id,
                recordingId: recordingId,
                content: content,
                language: language,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recordingId,
                required String content,
                Value<String?> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordingTranscriptsCompanion.insert(
                id: id,
                recordingId: recordingId,
                content: content,
                language: language,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecordingTranscriptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recordingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recordingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recordingId,
                                referencedTable:
                                    $$RecordingTranscriptsTableReferences
                                        ._recordingIdTable(db),
                                referencedColumn:
                                    $$RecordingTranscriptsTableReferences
                                        ._recordingIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecordingTranscriptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordingTranscriptsTable,
      RecordingTranscriptRow,
      $$RecordingTranscriptsTableFilterComposer,
      $$RecordingTranscriptsTableOrderingComposer,
      $$RecordingTranscriptsTableAnnotationComposer,
      $$RecordingTranscriptsTableCreateCompanionBuilder,
      $$RecordingTranscriptsTableUpdateCompanionBuilder,
      (RecordingTranscriptRow, $$RecordingTranscriptsTableReferences),
      RecordingTranscriptRow,
      PrefetchHooks Function({bool recordingId})
    >;
typedef $$TranscriptsTableCreateCompanionBuilder =
    TranscriptsCompanion Function({
      required String id,
      required String meetingId,
      required String fullText,
      Value<String?> language,
      required int recordingCount,
      Value<int> rowid,
    });
typedef $$TranscriptsTableUpdateCompanionBuilder =
    TranscriptsCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<String> fullText,
      Value<String?> language,
      Value<int> recordingCount,
      Value<int> rowid,
    });

final class $$TranscriptsTableReferences
    extends BaseReferences<_$AppDatabase, $TranscriptsTable, TranscriptRow> {
  $$TranscriptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MeetingsTable _meetingIdTable(_$AppDatabase db) =>
      db.meetings.createAlias('transcripts__meeting_id__meetings__id');

  $$MeetingsTableProcessedTableManager get meetingId {
    final $_column = $_itemColumn<String>('meeting_id')!;

    final manager = $$MeetingsTableTableManager(
      $_db,
      $_db.meetings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TranscriptsTableFilterComposer
    extends Composer<_$AppDatabase, $TranscriptsTable> {
  $$TranscriptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordingCount => $composableBuilder(
    column: $table.recordingCount,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingsTableFilterComposer get meetingId {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableFilterComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptsTableOrderingComposer
    extends Composer<_$AppDatabase, $TranscriptsTable> {
  $$TranscriptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordingCount => $composableBuilder(
    column: $table.recordingCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingsTableOrderingComposer get meetingId {
    final $$MeetingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableOrderingComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranscriptsTable> {
  $$TranscriptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullText =>
      $composableBuilder(column: $table.fullText, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<int> get recordingCount => $composableBuilder(
    column: $table.recordingCount,
    builder: (column) => column,
  );

  $$MeetingsTableAnnotationComposer get meetingId {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranscriptsTable,
          TranscriptRow,
          $$TranscriptsTableFilterComposer,
          $$TranscriptsTableOrderingComposer,
          $$TranscriptsTableAnnotationComposer,
          $$TranscriptsTableCreateCompanionBuilder,
          $$TranscriptsTableUpdateCompanionBuilder,
          (TranscriptRow, $$TranscriptsTableReferences),
          TranscriptRow,
          PrefetchHooks Function({bool meetingId})
        > {
  $$TranscriptsTableTableManager(_$AppDatabase db, $TranscriptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranscriptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TranscriptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TranscriptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<String> fullText = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<int> recordingCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranscriptsCompanion(
                id: id,
                meetingId: meetingId,
                fullText: fullText,
                language: language,
                recordingCount: recordingCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required String fullText,
                Value<String?> language = const Value.absent(),
                required int recordingCount,
                Value<int> rowid = const Value.absent(),
              }) => TranscriptsCompanion.insert(
                id: id,
                meetingId: meetingId,
                fullText: fullText,
                language: language,
                recordingCount: recordingCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TranscriptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({meetingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (meetingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.meetingId,
                                referencedTable: $$TranscriptsTableReferences
                                    ._meetingIdTable(db),
                                referencedColumn: $$TranscriptsTableReferences
                                    ._meetingIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TranscriptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranscriptsTable,
      TranscriptRow,
      $$TranscriptsTableFilterComposer,
      $$TranscriptsTableOrderingComposer,
      $$TranscriptsTableAnnotationComposer,
      $$TranscriptsTableCreateCompanionBuilder,
      $$TranscriptsTableUpdateCompanionBuilder,
      (TranscriptRow, $$TranscriptsTableReferences),
      TranscriptRow,
      PrefetchHooks Function({bool meetingId})
    >;
typedef $$MeetingReportsTableCreateCompanionBuilder =
    MeetingReportsCompanion Function({
      required String id,
      required String meetingId,
      required String summary,
      required String rawJson,
      required String modelUsed,
      required DateTime generatedAt,
      Value<int> rowid,
    });
typedef $$MeetingReportsTableUpdateCompanionBuilder =
    MeetingReportsCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<String> summary,
      Value<String> rawJson,
      Value<String> modelUsed,
      Value<DateTime> generatedAt,
      Value<int> rowid,
    });

final class $$MeetingReportsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MeetingReportsTable, MeetingReportRow> {
  $$MeetingReportsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetingsTable _meetingIdTable(_$AppDatabase db) =>
      db.meetings.createAlias('meeting_reports__meeting_id__meetings__id');

  $$MeetingsTableProcessedTableManager get meetingId {
    final $_column = $_itemColumn<String>('meeting_id')!;

    final manager = $$MeetingsTableTableManager(
      $_db,
      $_db.meetings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReportProblemsTable, List<ProblemRow>>
  _reportProblemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reportProblems,
    aliasName: 'meeting_reports__id__report_problems__report_id',
  );

  $$ReportProblemsTableProcessedTableManager get reportProblemsRefs {
    final manager = $$ReportProblemsTableTableManager(
      $_db,
      $_db.reportProblems,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reportProblemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReportDecisionsTable, List<DecisionRow>>
  _reportDecisionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reportDecisions,
    aliasName: 'meeting_reports__id__report_decisions__report_id',
  );

  $$ReportDecisionsTableProcessedTableManager get reportDecisionsRefs {
    final manager = $$ReportDecisionsTableTableManager(
      $_db,
      $_db.reportDecisions,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reportDecisionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReportActionItemsTable, List<ActionItemRow>>
  _reportActionItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.reportActionItems,
        aliasName: 'meeting_reports__id__report_action_items__report_id',
      );

  $$ReportActionItemsTableProcessedTableManager get reportActionItemsRefs {
    final manager = $$ReportActionItemsTableTableManager(
      $_db,
      $_db.reportActionItems,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reportActionItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeetingReportsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingReportsTable> {
  $$MeetingReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelUsed => $composableBuilder(
    column: $table.modelUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingsTableFilterComposer get meetingId {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableFilterComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reportProblemsRefs(
    Expression<bool> Function($$ReportProblemsTableFilterComposer f) f,
  ) {
    final $$ReportProblemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportProblems,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportProblemsTableFilterComposer(
            $db: $db,
            $table: $db.reportProblems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reportDecisionsRefs(
    Expression<bool> Function($$ReportDecisionsTableFilterComposer f) f,
  ) {
    final $$ReportDecisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportDecisions,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportDecisionsTableFilterComposer(
            $db: $db,
            $table: $db.reportDecisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reportActionItemsRefs(
    Expression<bool> Function($$ReportActionItemsTableFilterComposer f) f,
  ) {
    final $$ReportActionItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportActionItems,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportActionItemsTableFilterComposer(
            $db: $db,
            $table: $db.reportActionItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeetingReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingReportsTable> {
  $$MeetingReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelUsed => $composableBuilder(
    column: $table.modelUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingsTableOrderingComposer get meetingId {
    final $$MeetingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableOrderingComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetingReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingReportsTable> {
  $$MeetingReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get rawJson =>
      $composableBuilder(column: $table.rawJson, builder: (column) => column);

  GeneratedColumn<String> get modelUsed =>
      $composableBuilder(column: $table.modelUsed, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  $$MeetingsTableAnnotationComposer get meetingId {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reportProblemsRefs<T extends Object>(
    Expression<T> Function($$ReportProblemsTableAnnotationComposer a) f,
  ) {
    final $$ReportProblemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportProblems,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportProblemsTableAnnotationComposer(
            $db: $db,
            $table: $db.reportProblems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reportDecisionsRefs<T extends Object>(
    Expression<T> Function($$ReportDecisionsTableAnnotationComposer a) f,
  ) {
    final $$ReportDecisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportDecisions,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportDecisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reportDecisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reportActionItemsRefs<T extends Object>(
    Expression<T> Function($$ReportActionItemsTableAnnotationComposer a) f,
  ) {
    final $$ReportActionItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reportActionItems,
          getReferencedColumn: (t) => t.reportId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReportActionItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.reportActionItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MeetingReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingReportsTable,
          MeetingReportRow,
          $$MeetingReportsTableFilterComposer,
          $$MeetingReportsTableOrderingComposer,
          $$MeetingReportsTableAnnotationComposer,
          $$MeetingReportsTableCreateCompanionBuilder,
          $$MeetingReportsTableUpdateCompanionBuilder,
          (MeetingReportRow, $$MeetingReportsTableReferences),
          MeetingReportRow,
          PrefetchHooks Function({
            bool meetingId,
            bool reportProblemsRefs,
            bool reportDecisionsRefs,
            bool reportActionItemsRefs,
          })
        > {
  $$MeetingReportsTableTableManager(
    _$AppDatabase db,
    $MeetingReportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> rawJson = const Value.absent(),
                Value<String> modelUsed = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingReportsCompanion(
                id: id,
                meetingId: meetingId,
                summary: summary,
                rawJson: rawJson,
                modelUsed: modelUsed,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required String summary,
                required String rawJson,
                required String modelUsed,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MeetingReportsCompanion.insert(
                id: id,
                meetingId: meetingId,
                summary: summary,
                rawJson: rawJson,
                modelUsed: modelUsed,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeetingReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                meetingId = false,
                reportProblemsRefs = false,
                reportDecisionsRefs = false,
                reportActionItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reportProblemsRefs) db.reportProblems,
                    if (reportDecisionsRefs) db.reportDecisions,
                    if (reportActionItemsRefs) db.reportActionItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (meetingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.meetingId,
                                    referencedTable:
                                        $$MeetingReportsTableReferences
                                            ._meetingIdTable(db),
                                    referencedColumn:
                                        $$MeetingReportsTableReferences
                                            ._meetingIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reportProblemsRefs)
                        await $_getPrefetchedData<
                          MeetingReportRow,
                          $MeetingReportsTable,
                          ProblemRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingReportsTableReferences
                              ._reportProblemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).reportProblemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reportId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reportDecisionsRefs)
                        await $_getPrefetchedData<
                          MeetingReportRow,
                          $MeetingReportsTable,
                          DecisionRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingReportsTableReferences
                              ._reportDecisionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).reportDecisionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reportId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reportActionItemsRefs)
                        await $_getPrefetchedData<
                          MeetingReportRow,
                          $MeetingReportsTable,
                          ActionItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$MeetingReportsTableReferences
                              ._reportActionItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MeetingReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).reportActionItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reportId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MeetingReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingReportsTable,
      MeetingReportRow,
      $$MeetingReportsTableFilterComposer,
      $$MeetingReportsTableOrderingComposer,
      $$MeetingReportsTableAnnotationComposer,
      $$MeetingReportsTableCreateCompanionBuilder,
      $$MeetingReportsTableUpdateCompanionBuilder,
      (MeetingReportRow, $$MeetingReportsTableReferences),
      MeetingReportRow,
      PrefetchHooks Function({
        bool meetingId,
        bool reportProblemsRefs,
        bool reportDecisionsRefs,
        bool reportActionItemsRefs,
      })
    >;
typedef $$ReportProblemsTableCreateCompanionBuilder =
    ReportProblemsCompanion Function({
      required String id,
      required String reportId,
      required int orderIndex,
      required String title,
      required String detail,
      Value<int> rowid,
    });
typedef $$ReportProblemsTableUpdateCompanionBuilder =
    ReportProblemsCompanion Function({
      Value<String> id,
      Value<String> reportId,
      Value<int> orderIndex,
      Value<String> title,
      Value<String> detail,
      Value<int> rowid,
    });

final class $$ReportProblemsTableReferences
    extends BaseReferences<_$AppDatabase, $ReportProblemsTable, ProblemRow> {
  $$ReportProblemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetingReportsTable _reportIdTable(_$AppDatabase db) => db
      .meetingReports
      .createAlias('report_problems__report_id__meeting_reports__id');

  $$MeetingReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<String>('report_id')!;

    final manager = $$MeetingReportsTableTableManager(
      $_db,
      $_db.meetingReports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReportProblemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportProblemsTable> {
  $$ReportProblemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingReportsTableFilterComposer get reportId {
    final $$MeetingReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableFilterComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportProblemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportProblemsTable> {
  $$ReportProblemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingReportsTableOrderingComposer get reportId {
    final $$MeetingReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableOrderingComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportProblemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportProblemsTable> {
  $$ReportProblemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  $$MeetingReportsTableAnnotationComposer get reportId {
    final $$MeetingReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportProblemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportProblemsTable,
          ProblemRow,
          $$ReportProblemsTableFilterComposer,
          $$ReportProblemsTableOrderingComposer,
          $$ReportProblemsTableAnnotationComposer,
          $$ReportProblemsTableCreateCompanionBuilder,
          $$ReportProblemsTableUpdateCompanionBuilder,
          (ProblemRow, $$ReportProblemsTableReferences),
          ProblemRow,
          PrefetchHooks Function({bool reportId})
        > {
  $$ReportProblemsTableTableManager(
    _$AppDatabase db,
    $ReportProblemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportProblemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportProblemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportProblemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reportId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> detail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportProblemsCompanion(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reportId,
                required int orderIndex,
                required String title,
                required String detail,
                Value<int> rowid = const Value.absent(),
              }) => ReportProblemsCompanion.insert(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReportProblemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reportId,
                                referencedTable: $$ReportProblemsTableReferences
                                    ._reportIdTable(db),
                                referencedColumn:
                                    $$ReportProblemsTableReferences
                                        ._reportIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReportProblemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportProblemsTable,
      ProblemRow,
      $$ReportProblemsTableFilterComposer,
      $$ReportProblemsTableOrderingComposer,
      $$ReportProblemsTableAnnotationComposer,
      $$ReportProblemsTableCreateCompanionBuilder,
      $$ReportProblemsTableUpdateCompanionBuilder,
      (ProblemRow, $$ReportProblemsTableReferences),
      ProblemRow,
      PrefetchHooks Function({bool reportId})
    >;
typedef $$ReportDecisionsTableCreateCompanionBuilder =
    ReportDecisionsCompanion Function({
      required String id,
      required String reportId,
      required int orderIndex,
      required String title,
      required String detail,
      Value<int> rowid,
    });
typedef $$ReportDecisionsTableUpdateCompanionBuilder =
    ReportDecisionsCompanion Function({
      Value<String> id,
      Value<String> reportId,
      Value<int> orderIndex,
      Value<String> title,
      Value<String> detail,
      Value<int> rowid,
    });

final class $$ReportDecisionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReportDecisionsTable, DecisionRow> {
  $$ReportDecisionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetingReportsTable _reportIdTable(_$AppDatabase db) => db
      .meetingReports
      .createAlias('report_decisions__report_id__meeting_reports__id');

  $$MeetingReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<String>('report_id')!;

    final manager = $$MeetingReportsTableTableManager(
      $_db,
      $_db.meetingReports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReportDecisionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportDecisionsTable> {
  $$ReportDecisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingReportsTableFilterComposer get reportId {
    final $$MeetingReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableFilterComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportDecisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportDecisionsTable> {
  $$ReportDecisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingReportsTableOrderingComposer get reportId {
    final $$MeetingReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableOrderingComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportDecisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportDecisionsTable> {
  $$ReportDecisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  $$MeetingReportsTableAnnotationComposer get reportId {
    final $$MeetingReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportDecisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportDecisionsTable,
          DecisionRow,
          $$ReportDecisionsTableFilterComposer,
          $$ReportDecisionsTableOrderingComposer,
          $$ReportDecisionsTableAnnotationComposer,
          $$ReportDecisionsTableCreateCompanionBuilder,
          $$ReportDecisionsTableUpdateCompanionBuilder,
          (DecisionRow, $$ReportDecisionsTableReferences),
          DecisionRow,
          PrefetchHooks Function({bool reportId})
        > {
  $$ReportDecisionsTableTableManager(
    _$AppDatabase db,
    $ReportDecisionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportDecisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportDecisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportDecisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reportId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> detail = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportDecisionsCompanion(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reportId,
                required int orderIndex,
                required String title,
                required String detail,
                Value<int> rowid = const Value.absent(),
              }) => ReportDecisionsCompanion.insert(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                title: title,
                detail: detail,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReportDecisionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reportId,
                                referencedTable:
                                    $$ReportDecisionsTableReferences
                                        ._reportIdTable(db),
                                referencedColumn:
                                    $$ReportDecisionsTableReferences
                                        ._reportIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReportDecisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportDecisionsTable,
      DecisionRow,
      $$ReportDecisionsTableFilterComposer,
      $$ReportDecisionsTableOrderingComposer,
      $$ReportDecisionsTableAnnotationComposer,
      $$ReportDecisionsTableCreateCompanionBuilder,
      $$ReportDecisionsTableUpdateCompanionBuilder,
      (DecisionRow, $$ReportDecisionsTableReferences),
      DecisionRow,
      PrefetchHooks Function({bool reportId})
    >;
typedef $$ReportActionItemsTableCreateCompanionBuilder =
    ReportActionItemsCompanion Function({
      required String id,
      required String reportId,
      required int orderIndex,
      required String task,
      Value<String?> owner,
      Value<String?> due,
      Value<int> rowid,
    });
typedef $$ReportActionItemsTableUpdateCompanionBuilder =
    ReportActionItemsCompanion Function({
      Value<String> id,
      Value<String> reportId,
      Value<int> orderIndex,
      Value<String> task,
      Value<String?> owner,
      Value<String?> due,
      Value<int> rowid,
    });

final class $$ReportActionItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReportActionItemsTable, ActionItemRow> {
  $$ReportActionItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetingReportsTable _reportIdTable(_$AppDatabase db) => db
      .meetingReports
      .createAlias('report_action_items__report_id__meeting_reports__id');

  $$MeetingReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<String>('report_id')!;

    final manager = $$MeetingReportsTableTableManager(
      $_db,
      $_db.meetingReports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReportActionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportActionItemsTable> {
  $$ReportActionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get task => $composableBuilder(
    column: $table.task,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingReportsTableFilterComposer get reportId {
    final $$MeetingReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableFilterComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportActionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportActionItemsTable> {
  $$ReportActionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get task => $composableBuilder(
    column: $table.task,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingReportsTableOrderingComposer get reportId {
    final $$MeetingReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableOrderingComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportActionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportActionItemsTable> {
  $$ReportActionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get task =>
      $composableBuilder(column: $table.task, builder: (column) => column);

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<String> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  $$MeetingReportsTableAnnotationComposer get reportId {
    final $$MeetingReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.meetingReports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetingReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportActionItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportActionItemsTable,
          ActionItemRow,
          $$ReportActionItemsTableFilterComposer,
          $$ReportActionItemsTableOrderingComposer,
          $$ReportActionItemsTableAnnotationComposer,
          $$ReportActionItemsTableCreateCompanionBuilder,
          $$ReportActionItemsTableUpdateCompanionBuilder,
          (ActionItemRow, $$ReportActionItemsTableReferences),
          ActionItemRow,
          PrefetchHooks Function({bool reportId})
        > {
  $$ReportActionItemsTableTableManager(
    _$AppDatabase db,
    $ReportActionItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportActionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportActionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportActionItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reportId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> task = const Value.absent(),
                Value<String?> owner = const Value.absent(),
                Value<String?> due = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportActionItemsCompanion(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                task: task,
                owner: owner,
                due: due,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reportId,
                required int orderIndex,
                required String task,
                Value<String?> owner = const Value.absent(),
                Value<String?> due = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportActionItemsCompanion.insert(
                id: id,
                reportId: reportId,
                orderIndex: orderIndex,
                task: task,
                owner: owner,
                due: due,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReportActionItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reportId,
                                referencedTable:
                                    $$ReportActionItemsTableReferences
                                        ._reportIdTable(db),
                                referencedColumn:
                                    $$ReportActionItemsTableReferences
                                        ._reportIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReportActionItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportActionItemsTable,
      ActionItemRow,
      $$ReportActionItemsTableFilterComposer,
      $$ReportActionItemsTableOrderingComposer,
      $$ReportActionItemsTableAnnotationComposer,
      $$ReportActionItemsTableCreateCompanionBuilder,
      $$ReportActionItemsTableUpdateCompanionBuilder,
      (ActionItemRow, $$ReportActionItemsTableReferences),
      ActionItemRow,
      PrefetchHooks Function({bool reportId})
    >;
typedef $$MeetingMarkdownsTableCreateCompanionBuilder =
    MeetingMarkdownsCompanion Function({
      required String id,
      required String meetingId,
      required String contentMarkdown,
      required DateTime generatedAt,
      Value<int> rowid,
    });
typedef $$MeetingMarkdownsTableUpdateCompanionBuilder =
    MeetingMarkdownsCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<String> contentMarkdown,
      Value<DateTime> generatedAt,
      Value<int> rowid,
    });

final class $$MeetingMarkdownsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MeetingMarkdownsTable,
          MeetingMarkdownRow
        > {
  $$MeetingMarkdownsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MeetingsTable _meetingIdTable(_$AppDatabase db) =>
      db.meetings.createAlias('meeting_markdowns__meeting_id__meetings__id');

  $$MeetingsTableProcessedTableManager get meetingId {
    final $_column = $_itemColumn<String>('meeting_id')!;

    final manager = $$MeetingsTableTableManager(
      $_db,
      $_db.meetings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meetingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeetingMarkdownsTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingMarkdownsTable> {
  $$MeetingMarkdownsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentMarkdown => $composableBuilder(
    column: $table.contentMarkdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MeetingsTableFilterComposer get meetingId {
    final $$MeetingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableFilterComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetingMarkdownsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingMarkdownsTable> {
  $$MeetingMarkdownsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentMarkdown => $composableBuilder(
    column: $table.contentMarkdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeetingsTableOrderingComposer get meetingId {
    final $$MeetingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableOrderingComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetingMarkdownsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingMarkdownsTable> {
  $$MeetingMarkdownsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentMarkdown => $composableBuilder(
    column: $table.contentMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  $$MeetingsTableAnnotationComposer get meetingId {
    final $$MeetingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meetingId,
      referencedTable: $db.meetings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeetingsTableAnnotationComposer(
            $db: $db,
            $table: $db.meetings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeetingMarkdownsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingMarkdownsTable,
          MeetingMarkdownRow,
          $$MeetingMarkdownsTableFilterComposer,
          $$MeetingMarkdownsTableOrderingComposer,
          $$MeetingMarkdownsTableAnnotationComposer,
          $$MeetingMarkdownsTableCreateCompanionBuilder,
          $$MeetingMarkdownsTableUpdateCompanionBuilder,
          (MeetingMarkdownRow, $$MeetingMarkdownsTableReferences),
          MeetingMarkdownRow,
          PrefetchHooks Function({bool meetingId})
        > {
  $$MeetingMarkdownsTableTableManager(
    _$AppDatabase db,
    $MeetingMarkdownsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingMarkdownsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingMarkdownsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingMarkdownsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<String> contentMarkdown = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingMarkdownsCompanion(
                id: id,
                meetingId: meetingId,
                contentMarkdown: contentMarkdown,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required String contentMarkdown,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MeetingMarkdownsCompanion.insert(
                id: id,
                meetingId: meetingId,
                contentMarkdown: contentMarkdown,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MeetingMarkdownsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({meetingId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (meetingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.meetingId,
                                referencedTable:
                                    $$MeetingMarkdownsTableReferences
                                        ._meetingIdTable(db),
                                referencedColumn:
                                    $$MeetingMarkdownsTableReferences
                                        ._meetingIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MeetingMarkdownsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingMarkdownsTable,
      MeetingMarkdownRow,
      $$MeetingMarkdownsTableFilterComposer,
      $$MeetingMarkdownsTableOrderingComposer,
      $$MeetingMarkdownsTableAnnotationComposer,
      $$MeetingMarkdownsTableCreateCompanionBuilder,
      $$MeetingMarkdownsTableUpdateCompanionBuilder,
      (MeetingMarkdownRow, $$MeetingMarkdownsTableReferences),
      MeetingMarkdownRow,
      PrefetchHooks Function({bool meetingId})
    >;
typedef $$UsageRecordsTableCreateCompanionBuilder =
    UsageRecordsCompanion Function({
      required String id,
      Value<String?> meetingId,
      Value<String?> projectId,
      required String operationType,
      required String model,
      Value<int?> audioSeconds,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      required double estimatedCostUsd,
      required DateTime timestamp,
      Value<int> rowid,
    });
typedef $$UsageRecordsTableUpdateCompanionBuilder =
    UsageRecordsCompanion Function({
      Value<String> id,
      Value<String?> meetingId,
      Value<String?> projectId,
      Value<String> operationType,
      Value<String> model,
      Value<int?> audioSeconds,
      Value<int?> inputTokens,
      Value<int?> outputTokens,
      Value<double> estimatedCostUsd,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

class $$UsageRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $UsageRecordsTable> {
  $$UsageRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get audioSeconds => $composableBuilder(
    column: $table.audioSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsageRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageRecordsTable> {
  $$UsageRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get audioSeconds => $composableBuilder(
    column: $table.audioSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsageRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageRecordsTable> {
  $$UsageRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meetingId =>
      $composableBuilder(column: $table.meetingId, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get audioSeconds => $composableBuilder(
    column: $table.audioSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedCostUsd => $composableBuilder(
    column: $table.estimatedCostUsd,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$UsageRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsageRecordsTable,
          UsageRecordRow,
          $$UsageRecordsTableFilterComposer,
          $$UsageRecordsTableOrderingComposer,
          $$UsageRecordsTableAnnotationComposer,
          $$UsageRecordsTableCreateCompanionBuilder,
          $$UsageRecordsTableUpdateCompanionBuilder,
          (
            UsageRecordRow,
            BaseReferences<_$AppDatabase, $UsageRecordsTable, UsageRecordRow>,
          ),
          UsageRecordRow,
          PrefetchHooks Function()
        > {
  $$UsageRecordsTableTableManager(_$AppDatabase db, $UsageRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> meetingId = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int?> audioSeconds = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<double> estimatedCostUsd = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsageRecordsCompanion(
                id: id,
                meetingId: meetingId,
                projectId: projectId,
                operationType: operationType,
                model: model,
                audioSeconds: audioSeconds,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                estimatedCostUsd: estimatedCostUsd,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> meetingId = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                required String operationType,
                required String model,
                Value<int?> audioSeconds = const Value.absent(),
                Value<int?> inputTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                required double estimatedCostUsd,
                required DateTime timestamp,
                Value<int> rowid = const Value.absent(),
              }) => UsageRecordsCompanion.insert(
                id: id,
                meetingId: meetingId,
                projectId: projectId,
                operationType: operationType,
                model: model,
                audioSeconds: audioSeconds,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                estimatedCostUsd: estimatedCostUsd,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsageRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsageRecordsTable,
      UsageRecordRow,
      $$UsageRecordsTableFilterComposer,
      $$UsageRecordsTableOrderingComposer,
      $$UsageRecordsTableAnnotationComposer,
      $$UsageRecordsTableCreateCompanionBuilder,
      $$UsageRecordsTableUpdateCompanionBuilder,
      (
        UsageRecordRow,
        BaseReferences<_$AppDatabase, $UsageRecordsTable, UsageRecordRow>,
      ),
      UsageRecordRow,
      PrefetchHooks Function()
    >;
typedef $$QaThreadsTableCreateCompanionBuilder =
    QaThreadsCompanion Function({
      required String id,
      required String projectId,
      required String title,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$QaThreadsTableUpdateCompanionBuilder =
    QaThreadsCompanion Function({
      Value<String> id,
      Value<String> projectId,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$QaThreadsTableReferences
    extends BaseReferences<_$AppDatabase, $QaThreadsTable, QaThreadRow> {
  $$QaThreadsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('qa_threads__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QaMessagesTable, List<QaMessageRow>>
  _qaMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.qaMessages,
    aliasName: 'qa_threads__id__qa_messages__thread_id',
  );

  $$QaMessagesTableProcessedTableManager get qaMessagesRefs {
    final manager = $$QaMessagesTableTableManager(
      $_db,
      $_db.qaMessages,
    ).filter((f) => f.threadId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_qaMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QaThreadsTableFilterComposer
    extends Composer<_$AppDatabase, $QaThreadsTable> {
  $$QaThreadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> qaMessagesRefs(
    Expression<bool> Function($$QaMessagesTableFilterComposer f) f,
  ) {
    final $$QaMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.qaMessages,
      getReferencedColumn: (t) => t.threadId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaMessagesTableFilterComposer(
            $db: $db,
            $table: $db.qaMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QaThreadsTableOrderingComposer
    extends Composer<_$AppDatabase, $QaThreadsTable> {
  $$QaThreadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QaThreadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QaThreadsTable> {
  $$QaThreadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> qaMessagesRefs<T extends Object>(
    Expression<T> Function($$QaMessagesTableAnnotationComposer a) f,
  ) {
    final $$QaMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.qaMessages,
      getReferencedColumn: (t) => t.threadId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.qaMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QaThreadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QaThreadsTable,
          QaThreadRow,
          $$QaThreadsTableFilterComposer,
          $$QaThreadsTableOrderingComposer,
          $$QaThreadsTableAnnotationComposer,
          $$QaThreadsTableCreateCompanionBuilder,
          $$QaThreadsTableUpdateCompanionBuilder,
          (QaThreadRow, $$QaThreadsTableReferences),
          QaThreadRow,
          PrefetchHooks Function({bool projectId, bool qaMessagesRefs})
        > {
  $$QaThreadsTableTableManager(_$AppDatabase db, $QaThreadsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QaThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QaThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QaThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QaThreadsCompanion(
                id: id,
                projectId: projectId,
                title: title,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String projectId,
                required String title,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => QaThreadsCompanion.insert(
                id: id,
                projectId: projectId,
                title: title,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QaThreadsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, qaMessagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (qaMessagesRefs) db.qaMessages],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$QaThreadsTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$QaThreadsTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (qaMessagesRefs)
                    await $_getPrefetchedData<
                      QaThreadRow,
                      $QaThreadsTable,
                      QaMessageRow
                    >(
                      currentTable: table,
                      referencedTable: $$QaThreadsTableReferences
                          ._qaMessagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$QaThreadsTableReferences(
                            db,
                            table,
                            p0,
                          ).qaMessagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.threadId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QaThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QaThreadsTable,
      QaThreadRow,
      $$QaThreadsTableFilterComposer,
      $$QaThreadsTableOrderingComposer,
      $$QaThreadsTableAnnotationComposer,
      $$QaThreadsTableCreateCompanionBuilder,
      $$QaThreadsTableUpdateCompanionBuilder,
      (QaThreadRow, $$QaThreadsTableReferences),
      QaThreadRow,
      PrefetchHooks Function({bool projectId, bool qaMessagesRefs})
    >;
typedef $$QaMessagesTableCreateCompanionBuilder =
    QaMessagesCompanion Function({
      required String id,
      required String threadId,
      required String role,
      required String content,
      required DateTime timestamp,
      Value<String> citedMeetingIdsJson,
      Value<String?> usageRecordId,
      Value<int> rowid,
    });
typedef $$QaMessagesTableUpdateCompanionBuilder =
    QaMessagesCompanion Function({
      Value<String> id,
      Value<String> threadId,
      Value<String> role,
      Value<String> content,
      Value<DateTime> timestamp,
      Value<String> citedMeetingIdsJson,
      Value<String?> usageRecordId,
      Value<int> rowid,
    });

final class $$QaMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $QaMessagesTable, QaMessageRow> {
  $$QaMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QaThreadsTable _threadIdTable(_$AppDatabase db) =>
      db.qaThreads.createAlias('qa_messages__thread_id__qa_threads__id');

  $$QaThreadsTableProcessedTableManager get threadId {
    final $_column = $_itemColumn<String>('thread_id')!;

    final manager = $$QaThreadsTableTableManager(
      $_db,
      $_db.qaThreads,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_threadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QaMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $QaMessagesTable> {
  $$QaMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get citedMeetingIdsJson => $composableBuilder(
    column: $table.citedMeetingIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usageRecordId => $composableBuilder(
    column: $table.usageRecordId,
    builder: (column) => ColumnFilters(column),
  );

  $$QaThreadsTableFilterComposer get threadId {
    final $$QaThreadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.qaThreads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaThreadsTableFilterComposer(
            $db: $db,
            $table: $db.qaThreads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QaMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $QaMessagesTable> {
  $$QaMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get citedMeetingIdsJson => $composableBuilder(
    column: $table.citedMeetingIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usageRecordId => $composableBuilder(
    column: $table.usageRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  $$QaThreadsTableOrderingComposer get threadId {
    final $$QaThreadsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.qaThreads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaThreadsTableOrderingComposer(
            $db: $db,
            $table: $db.qaThreads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QaMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QaMessagesTable> {
  $$QaMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get citedMeetingIdsJson => $composableBuilder(
    column: $table.citedMeetingIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usageRecordId => $composableBuilder(
    column: $table.usageRecordId,
    builder: (column) => column,
  );

  $$QaThreadsTableAnnotationComposer get threadId {
    final $$QaThreadsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.qaThreads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QaThreadsTableAnnotationComposer(
            $db: $db,
            $table: $db.qaThreads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QaMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QaMessagesTable,
          QaMessageRow,
          $$QaMessagesTableFilterComposer,
          $$QaMessagesTableOrderingComposer,
          $$QaMessagesTableAnnotationComposer,
          $$QaMessagesTableCreateCompanionBuilder,
          $$QaMessagesTableUpdateCompanionBuilder,
          (QaMessageRow, $$QaMessagesTableReferences),
          QaMessageRow,
          PrefetchHooks Function({bool threadId})
        > {
  $$QaMessagesTableTableManager(_$AppDatabase db, $QaMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QaMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QaMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QaMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> threadId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> citedMeetingIdsJson = const Value.absent(),
                Value<String?> usageRecordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QaMessagesCompanion(
                id: id,
                threadId: threadId,
                role: role,
                content: content,
                timestamp: timestamp,
                citedMeetingIdsJson: citedMeetingIdsJson,
                usageRecordId: usageRecordId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String threadId,
                required String role,
                required String content,
                required DateTime timestamp,
                Value<String> citedMeetingIdsJson = const Value.absent(),
                Value<String?> usageRecordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QaMessagesCompanion.insert(
                id: id,
                threadId: threadId,
                role: role,
                content: content,
                timestamp: timestamp,
                citedMeetingIdsJson: citedMeetingIdsJson,
                usageRecordId: usageRecordId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QaMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({threadId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (threadId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.threadId,
                                referencedTable: $$QaMessagesTableReferences
                                    ._threadIdTable(db),
                                referencedColumn: $$QaMessagesTableReferences
                                    ._threadIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QaMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QaMessagesTable,
      QaMessageRow,
      $$QaMessagesTableFilterComposer,
      $$QaMessagesTableOrderingComposer,
      $$QaMessagesTableAnnotationComposer,
      $$QaMessagesTableCreateCompanionBuilder,
      $$QaMessagesTableUpdateCompanionBuilder,
      (QaMessageRow, $$QaMessagesTableReferences),
      QaMessageRow,
      PrefetchHooks Function({bool threadId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$ProjectContextsTableTableManager get projectContexts =>
      $$ProjectContextsTableTableManager(_db, _db.projectContexts);
  $$MeetingsTableTableManager get meetings =>
      $$MeetingsTableTableManager(_db, _db.meetings);
  $$RecordingsTableTableManager get recordings =>
      $$RecordingsTableTableManager(_db, _db.recordings);
  $$RecordingTranscriptsTableTableManager get recordingTranscripts =>
      $$RecordingTranscriptsTableTableManager(_db, _db.recordingTranscripts);
  $$TranscriptsTableTableManager get transcripts =>
      $$TranscriptsTableTableManager(_db, _db.transcripts);
  $$MeetingReportsTableTableManager get meetingReports =>
      $$MeetingReportsTableTableManager(_db, _db.meetingReports);
  $$ReportProblemsTableTableManager get reportProblems =>
      $$ReportProblemsTableTableManager(_db, _db.reportProblems);
  $$ReportDecisionsTableTableManager get reportDecisions =>
      $$ReportDecisionsTableTableManager(_db, _db.reportDecisions);
  $$ReportActionItemsTableTableManager get reportActionItems =>
      $$ReportActionItemsTableTableManager(_db, _db.reportActionItems);
  $$MeetingMarkdownsTableTableManager get meetingMarkdowns =>
      $$MeetingMarkdownsTableTableManager(_db, _db.meetingMarkdowns);
  $$UsageRecordsTableTableManager get usageRecords =>
      $$UsageRecordsTableTableManager(_db, _db.usageRecords);
  $$QaThreadsTableTableManager get qaThreads =>
      $$QaThreadsTableTableManager(_db, _db.qaThreads);
  $$QaMessagesTableTableManager get qaMessages =>
      $$QaMessagesTableTableManager(_db, _db.qaMessages);
}
