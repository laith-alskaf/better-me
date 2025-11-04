/// أنواع الأدوية المتاحة
enum MedicineType {
  bottle('زجاجة', 'bottle'),
  pill('قرص', 'pill'),
  syringe('محقن', 'syringe'),
  tablet('قرص', 'tablet'),
  powder('مسحوق', 'powder'),
  cream('كريم', 'cream'),
  liquid('سائل', 'liquid'),
  capsule('كبسولة', 'capsule'),
  unknown('غير محدد', 'unknown');

  /// الاسم العربي
  final String arabicName;

  /// المعرف الإنجليزي
  final String identifier;

  const MedicineType(this.arabicName, this.identifier);

  /// الحصول على النوع من المعرف
  static MedicineType fromIdentifier(String? identifier) {
    if (identifier == null) return MedicineType.unknown;
    try {
      return MedicineType.values.firstWhere(
        (type) => type.identifier == identifier.toLowerCase(),
        orElse: () => MedicineType.unknown,
      );
    } catch (e) {
      return MedicineType.unknown;
    }
  }

  /// الحصول على جميع الأنواع المتاحة
  static List<MedicineType> get availableTypes {
    return MedicineType.values.where((type) => type != MedicineType.unknown).toList();
  }

  /// دعم JSON serialization
  String toJson() => identifier;

  /// دعم JSON deserialization
  static MedicineType fromJson(String? json) => fromIdentifier(json);

  @override
  String toString() => arabicName;
}