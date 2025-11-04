// This file tests MedicineModel JSON serialization
import 'package:flutter_test/flutter_test.dart';
import 'package:BetterMe/features/medicine_reminder/data/models/medicine_model.dart';
import 'dart:convert';

void main() {
  group('MedicineModel JSON Serialization Tests', () {
    final now = DateTime(2024, 1, 15, 9, 0);
    
    final testMedicine = MedicineModel(
      id: 'medicine_1',
      medicineName: 'Aspirin',
      dosage: 500,
      medicineType: 'tablet',
      interval: 6,
      startTime: '09:00',
      notes: 'بعد الطعام',
      createdAt: now,
      updatedAt: now,
      notificationIds: [1, 2, 3],
    );

    test('✅ toJson() يحول Object إلى JSON', () {
      final json = testMedicine.toJson();
      
      expect(json, isNotNull);
      expect(json['name'], 'Aspirin');
      expect(json['dosage'], 500);
      expect(json['type'], 'tablet');
      expect(json['interval'], 6);
      expect(json['start'], '09:00');
      expect(json['notes'], 'بعد الطعام');
      expect(json['ids'], [1, 2, 3]);
    });

    test('✅ fromJson() يحول JSON إلى Object', () {
      final json = {
        'id': 'medicine_1',
        'name': 'Aspirin',
        'dosage': 500,
        'type': 'tablet',
        'interval': 6,
        'start': '09:00',
        'notes': 'بعد الطعام',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'ids': [1, 2, 3],
      };
      
      final medicine = MedicineModel.fromJson(json);
      
      expect(medicine.id, 'medicine_1');
      expect(medicine.medicineName, 'Aspirin');
      expect(medicine.dosage, 500);
      expect(medicine.medicineType, 'tablet');
      expect(medicine.interval, 6);
      expect(medicine.startTime, '09:00');
      expect(medicine.notes, 'بعد الطعام');
      expect(medicine.getIds, [1, 2, 3]);
    });

    test('✅ Serialization و Deserialization (دورة كاملة)', () {
      // تحويل إلى JSON
      final json = testMedicine.toJson();
      
      // تحويل إلى String
      final jsonString = jsonEncode(json);
      
      // تحويل من String إلى JSON
      final decodedJson = jsonDecode(jsonString);
      
      // تحويل من JSON إلى Object
      final recoveredMedicine = MedicineModel.fromJson(decodedJson);
      
      // التحقق
      expect(recoveredMedicine.medicineName, testMedicine.medicineName);
      expect(recoveredMedicine.dosage, testMedicine.dosage);
      expect(recoveredMedicine.medicineType, testMedicine.medicineType);
      expect(recoveredMedicine.interval, testMedicine.interval);
    });

    test('✅ copyWith() يعمل بشكل صحيح', () {
      final updated = testMedicine.copyWith(dosage: 1000);
      
      expect(updated.dosage, 1000);
      expect(updated.medicineName, testMedicine.medicineName);
      expect(updated.id, testMedicine.id);
    });

    test('✅ Equality Operator يعمل', () {
      final medicine2 = MedicineModel(
        id: 'medicine_1',
        medicineName: 'Aspirin',
        dosage: 500,
        medicineType: 'tablet',
        interval: 6,
        startTime: '09:00',
        notes: 'بعد الطعام',
        createdAt: now,
        updatedAt: now,
        notificationIds: [1, 2, 3],
      );
      
      expect(testMedicine == medicine2, true);
    });

    test('✅ Getters تعمل بشكل صحيح', () {
      expect(testMedicine.getName, 'Aspirin');
      expect(testMedicine.getDosage, 500);
      expect(testMedicine.getType, 'tablet');
      expect(testMedicine.getInterval, 6);
      expect(testMedicine.getStartTime, '09:00');
      expect(testMedicine.getIds, [1, 2, 3]);
    });

    test('✅ toString() يعود بـ String منطقي', () {
      final stringRep = testMedicine.toString();
      
      expect(stringRep, contains('MedicineModel'));
      expect(stringRep, contains('Aspirin'));
      expect(stringRep, contains('500'));
      expect(stringRep, contains('tablet'));
    });

    test('✅ Optional Fields (notes, id) يعملان مع null', () {
      final json = {
        'id': null,
        'name': 'Aspirin',
        'dosage': 500,
        'type': 'tablet',
        'interval': 6,
        'start': '09:00',
        'notes': null,
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };
      
      final medicine = MedicineModel.fromJson(json);
      
      expect(medicine.id, null);
      expect(medicine.notes, null);
      expect(medicine.notificationIds, null);
    });

    test('✅ List Serialization يعمل', () {
      final medicines = [testMedicine, testMedicine];
      final jsonList = medicines.map((m) => m.toJson()).toList();
      
      expect(jsonList, isNotNull);
      expect(jsonList.length, 2);
      expect(jsonList[0]['name'], 'Aspirin');
    });
  });
}