// collections.dart
// "collections" koleksiyonu için küçük model ve Firestore yardımcıları

import 'package:cloud_firestore/cloud_firestore.dart';

// -------------------- Utils (minimal) -------------------- //
DateTime? _toDateTime(dynamic v) {
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  return null;
}

Timestamp? _toTimestamp(DateTime? dt) => dt == null ? null : Timestamp.fromDate(dt);

Map<String, dynamic> _nn(Map<String, dynamic> m) {
  // Sadece null değerleri at; boş map/list kalsın
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    if (v != null) out[k] = v;
  });
  return out;
}

// -------------------- Model -------------------- //
class CollectionDoc {
  final String id;
  final String? nameTr;
  final String? nameEn;
  final String? descTr;
  final String? descEn;
  final int totalProductCount;
  final DateTime? createdAt;

  const CollectionDoc({
    required this.id,
    this.nameTr,
    this.nameEn,
    this.descTr,
    this.descEn,
    this.totalProductCount = 0,
    this.createdAt,
  });

  factory CollectionDoc.fromMap(String id, Map<String, dynamic> map) {
    final name = (map['name'] as Map?) ?? const {};
    final desc = (map['desc'] as Map?) ?? const {};
    return CollectionDoc(
      id: id,
      nameTr: name['tr'] as String?,
      nameEn: name['en'] as String?,
      descTr: desc['tr'] as String?,
      descEn: desc['en'] as String?,
      totalProductCount: (map['total_product_count'] as num?)?.toInt() ?? 0,
      createdAt: _toDateTime(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': _nn({'tr': nameTr, 'en': nameEn}),
        'desc': _nn({'tr': descTr, 'en': descEn}),
        'total_product_count': totalProductCount,
        'created_at': _toTimestamp(createdAt),
      };

  CollectionDoc copyWith({
    String? id,
    String? nameTr,
    String? nameEn,
    String? descTr,
    String? descEn,
    int? totalProductCount,
    DateTime? createdAt,
  }) =>
      CollectionDoc(
        id: id ?? this.id,
        nameTr: nameTr ?? this.nameTr,
        nameEn: nameEn ?? this.nameEn,
        descTr: descTr ?? this.descTr,
        descEn: descEn ?? this.descEn,
        totalProductCount: totalProductCount ?? this.totalProductCount,
        createdAt: createdAt ?? this.createdAt,
      );
}

// -------------------- Firestore Helpers -------------------- //
class CollectionsRefs {
  final FirebaseFirestore _db;
  const CollectionsRefs(this._db);

  CollectionReference<CollectionDoc> collections() => _db.collection('collections').withConverter<CollectionDoc>(
        fromFirestore: (s, _) => CollectionDoc.fromMap(s.id, s.data() ?? {}),
        toFirestore: (c, _) => c.toMap(),
      );

  DocumentReference<CollectionDoc> doc(String id) => collections().doc(id);

  // Listeleme (en yeni ilk)
  Stream<List<CollectionDoc>> watchAll() => collections().orderBy('created_at', descending: true).snapshots().map((qs) => qs.docs.map((d) => d.data()).toList());

  // Oluşturma (server timestamp ile)
  Future<void> create(CollectionDoc c) async {
    final raw = _db.collection('collections').doc(c.id);
    await raw.set({
      ...c.toMap(),
      'created_at': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Güncelleme (kısmi)
  Future<void> updatePartial(String id, Map<String, dynamic> patch) async {
    await doc(id).update(patch);
  }

  // Ürün sayacı (arttır/azalt)
  Future<void> incrementCount(String id, int by) async {
    await doc(id).update({'total_product_count': FieldValue.increment(by)});
  }

  Future<void> delete(String id) => doc(id).delete();
}
