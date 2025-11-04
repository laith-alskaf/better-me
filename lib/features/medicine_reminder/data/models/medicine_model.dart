import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

/// نموذج الدواء - متوافق مع GetX و JSON serialization
@JsonSerializable()
class MedicineModel {
  /// معرفات الإشعارات
  @JsonKey(name: 'ids')
  final List<int>? notificationIds;

  /// اسم الدواء
  @JsonKey(name: 'name')
  final String medicineName;

  /// الجرعة (بالملغ أو عدد الأقراص)
  @JsonKey(name: 'dosage')
  final int dosage;

  /// نوع الدواء (قرص، زجاجة، إلخ)
  @JsonKey(name: 'type')
  final String medicineType;

  /// الفترة الزمنية بين الجرعات (بالساعات)
  @JsonKey(name: 'interval')
  final int interval;

  /// وقت البدء
  @JsonKey(name: 'start')
  final String startTime;

  /// الملاحظات أو التعليقات
  @JsonKey(name: 'notes')
  final String? notes;

  /// تاريخ الإنشاء
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  /// آخر تحديث
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  /// معرف فريد للدواء
  @JsonKey(name: 'id')
  final String? id;

  const MedicineModel({
    this.notificationIds,
    required this.medicineName,
    required this.dosage,
    required this.medicineType,
    required this.interval,
    required this.startTime,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.id,
  });

  /// تحويل من JSON
  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() => _$MedicineModelToJson(this);

  /// Getter للاسم
  String get getName => medicineName;

  /// Getter للجرعة
  int get getDosage => dosage;

  /// Getter للنوع
  String get getType => medicineType;

  /// Getter للفترة الزمنية
  int get getInterval => interval;

  /// Getter لوقت البدء
  String get getStartTime => startTime;

  /// Getter لمعرفات الإشعارات
  List<int> get getIds => notificationIds ?? [];

  /// نسخ مع تعديلات
  MedicineModel copyWith({
    List<int>? notificationIds,
    String? medicineName,
    int? dosage,
    String? medicineType,
    int? interval,
    String? startTime,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) {
    return MedicineModel(
      notificationIds: notificationIds ?? this.notificationIds,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      medicineType: medicineType ?? this.medicineType,
      interval: interval ?? this.interval,
      startTime: startTime ?? this.startTime,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModel &&
          runtimeType == other.runtimeType &&
          medicineName == other.medicineName &&
          id == other.id;

  @override
  int get hashCode => medicineName.hashCode ^ id.hashCode;

  @override
  String toString() =>
      'MedicineModel(name: $medicineName, dosage: $dosage, type: $medicineType)';
}