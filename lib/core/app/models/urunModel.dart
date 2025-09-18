/// Koleksiyon id sabitleri
class Collections {
  static const int all = 13; // "All Collections"
  static const int sofaSets = 1; // SOFA SETS
  static const int cornerSofaSets = 2; // CORNER SOFA SETS
  static const int armchairs = 3; // ARMCHAIRS
  static const int tvUnits = 4; // TV UNITS
  static const int diningRoom = 5; // DINING ROOM
  static const int consoles = 6; // CONSOLES
  static const int diningTable = 7; // DINING TABLE
  static const int chairs = 8; // CHAIRS
  static const int bedroom = 9; // BEDROOM
  static const int coffeeTables = 10; // COFFEE TABLES
  static const int poufs = 11; // POUFS
  static const int bookshelf = 12; // BOOKSHELF
}

class UrunModel {
  final int id;
  final String ad;
  final double fiyat; // Tasarım için şimdilik 0.0 bırakıldı
  final String resimUrl;
  final List<int> collectionIds; // 🔹 Artık liste

  const UrunModel({
    required this.id,
    required this.ad,
    required this.fiyat,
    required this.resimUrl,
    required this.collectionIds,
  });

  /// Koleksiyon üyeliği için yardımcı
  bool belongsTo(int collectionId) => collectionIds.contains(collectionId);
}

/// Sofa Sets (id:1) + All (id:13)
final List<UrunModel> ornekUrunler = [
  //  sofa sets
  UrunModel(
    id: 1,
    ad: "Roma&Napoly",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/roma-napoli/roma-napoli-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 2,
    ad: "Puffy",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/puffy/puffy-44.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 3,
    ad: "Deep Puffy",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/deep-puffy/deep-puffy-3.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 4,
    ad: "Siena",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/siena/siena-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 5,
    ad: "Orca",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/orca/orca-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 6,
    ad: "Orca Box",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/orca-box/orca-box-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 7,
    ad: "Verona",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/verona/yeni/verona-2.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 8,
    ad: "Opus",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/opus/opus-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 9,
    ad: "Petra",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/petra/petra-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 10,
    ad: "Domino",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/domino/domino-5.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 11,
    ad: "Harmony",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/harmony/harmony-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 12,
    ad: "Vera",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/vera/vera-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 13,
    ad: "Deep Bubble",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/bubble/bubble-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 14,
    ad: "Soho",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/soho/soho-16.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 15,
    ad: "Tokyo",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/tokyo/tokyo-23.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 16,
    ad: "Boston",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/boston/boston-4.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 17,
    ad: "Oslo",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/oslo/oslo-2.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 18,
    ad: "Merlin",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/merlin/merlin-15.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),
  UrunModel(
    id: 19,
    ad: "Valencia",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/valencia/valencia-1.jpg",
    collectionIds: [Collections.all, Collections.sofaSets],
  ),

// korner sofa sets

  UrunModel(
    id: 20,
    ad: "Puffy",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/puffy-corner/puffy-corner-3.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 21,
    ad: "Orca",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/orca/orca-2.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 22,
    ad: "Verona",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/verona/yeni/verona-3.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 23,
    ad: "Opus",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/opus/opus-2.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 24,
    ad: "Petra",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/petra/petra-4.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 25,
    ad: "Domino",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/domino/domino-2.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  UrunModel(
    id: 26,
    ad: "Deep Bubble",
    fiyat: 0.0,
    resimUrl: "https://caliform.furniture/assets/img/bubble/bubble-14.jpg",
    collectionIds: [Collections.all, Collections.cornerSofaSets],
  ),
  // 🪑 Armchairs
  UrunModel(id: 27, ad: "Roma&Napoly", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 28, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 29, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 30, ad: "Siena", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 31, ad: "Verona", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 32, ad: "Opus", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 33, ad: "Petra", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 34, ad: "Domino", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 35, ad: "Harmony", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 36, ad: "Vera", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 37, ad: "Deep Bubble", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 38, ad: "Soho", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 39, ad: "Tokyo", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 40, ad: "Boston", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 41, ad: "Oslo", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 42, ad: "Merlin", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),
  UrunModel(id: 43, ad: "Valencia", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.armchairs]),

  // 📺 TV Units
  UrunModel(id: 44, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.tvUnits]),
  UrunModel(id: 45, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.tvUnits]),

  // 🍽 Dining Room
  UrunModel(id: 46, ad: "Roma&Napoly", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.diningRoom]),
  UrunModel(id: 47, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.diningRoom]),
  UrunModel(id: 48, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.diningRoom]),

  // 🪞 Consoles
  UrunModel(id: 49, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.consoles]),
  UrunModel(id: 50, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.consoles]),

  // 🍽 Dining Tables
  UrunModel(id: 51, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.diningTable]),
  UrunModel(id: 52, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.diningTable]),

  // 🪑 Chairs
  UrunModel(id: 53, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.chairs]),
  UrunModel(id: 54, ad: "Siena", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.chairs]),
  UrunModel(id: 55, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.chairs]),
  UrunModel(id: 56, ad: "Verona", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.chairs]),
  UrunModel(id: 57, ad: "Opus", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.chairs]),

  // ☕ Coffee Tables
  UrunModel(id: 58, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.coffeeTables]),
  UrunModel(id: 59, ad: "Siena", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.coffeeTables]),
  UrunModel(id: 60, ad: "Orca", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.coffeeTables]),
  UrunModel(id: 61, ad: "Verona", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.coffeeTables]),
  UrunModel(id: 62, ad: "Opus", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.coffeeTables]),

  // 🛋 Poufs
  UrunModel(id: 63, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.poufs]),
  UrunModel(id: 64, ad: "Siena", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.poufs]),
  UrunModel(id: 65, ad: "Verona", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.poufs]),
  UrunModel(id: 66, ad: "Opus", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.poufs]),

  // 🛏 Bedroom
  UrunModel(id: 67, ad: "Puffy", fiyat: 0.0, resimUrl: "", collectionIds: [Collections.all, Collections.bedroom]),
];

/// Yardımcı: koleksiyona göre ürünleri getir
List<UrunModel> urunleriKoleksiyonaGoreGetir(int collectionId) {
  return ornekUrunler.where((u) => u.collectionIds.contains(collectionId)).toList();
}
