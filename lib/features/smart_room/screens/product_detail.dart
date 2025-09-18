import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_animation/features/smart_room/widgets/room_details_page_view.dart';

import '../../../core/app/models/urunModel.dart';

class UrunDetailScreen extends StatefulWidget {
  const UrunDetailScreen({super.key, required this.urun});
  final UrunModel urun;

  @override
  State<UrunDetailScreen> createState() => _UrunDetailScreenState();
}

class _UrunDetailScreenState extends State<UrunDetailScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      5,
      (i) => "https://picsum.photos/800/600?random=${widget.urun.id + i}",
    )..[0] = widget.urun.resimUrl;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: Colors.black45,
            ).copyWith(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${widget.urun.ad} sepete eklendi")),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff343941),
                    Color(0xff424a53),
                    Color(0xff505863),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sepete Ekle",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.shopping_cart_outlined, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 Blur arka plan (aktif resme göre)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: CachedNetworkImage(
              key: ValueKey(images[activeIndex]), // animasyon için önemli
              imageUrl: images[activeIndex],
              fit: BoxFit.cover, // 🔥 arka plan resmi tamamen kaplasın
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // 🔹 İçerik
          ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [
              ParallaxGallery(
                images: images,
                aspectRatio: 1,
                heroTag: "urun_${widget.urun.id}",
                onPageChanged: (i) {
                  setState(() => activeIndex = i);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 Ürün adı
                    Expanded(
                      child: Text(
                        widget.urun.ad,
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // 🔹 Toplam fiyat kutusu
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff343941),
                            Color(0xff424a53),
                            Color(0xff505863),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        "56.250 ₺", // hardcoded
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Ellipse TV Ünitesi, modern elips formu ve altın tonlu detaylarıyla "
                  "salonunuza şıklık katar. Fonksiyonel kullanım ve kaliteli malzeme ile uzun ömürlüdür.",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 📌 Expandable’lar
              _buildExpansionForAttributes(context, "Ürün Nitelikleri", const [
                {
                  "name": "ELLIPSE KONSOL",
                  "size": "235cm X 60cm X 86cm",
                  "material": "1. sınıf boyalı mdfden imal edilmiştir.",
                  "package": "Dopel karton kutular içinde 16 density kalıp strafor kullanılmaktadır.",
                  "paint": "Yüksek kalitede parlak ve mat boyalar kullanılmaktadır",
                },
                {
                  "name": "ELLIPSE MASA 230cm",
                  "size": "230cm X 110cm X 80cm",
                  "material": "1. sınıf boyalı mdf malzeme",
                  "package": "Dopel karton kutular içinde 16 density kalıp strafor kullanılmaktadır.",
                  "paint": "Yüksek kalitede parlak ve mat boyalar kullanılmaktadır",
                },
                {
                  "name": "ELLIPSE AYNA",
                  "size": "140cm X 6cm X 85cm",
                  "material": "1. sınıf boyalı mdf malzeme",
                  "package": "Dopel karton kutular içinde 16 density kalıp strafor kullanılmaktadır.",
                  "paint": "Yüksek kalitede parlak ve mat boyalar kullanılmaktadır",
                },
              ]),

              _buildExpansionForTeam(context, "Takım İçeriği", [
                {
                  "name": "ELLIPSE AYNA",
                  "image": "https://picsum.photos/200/200?1",
                  "price": 5625.00,
                  "count": 1,
                },
                {
                  "name": "ELLIPSE MASA 275cm",
                  "image": "https://picsum.photos/200/200?2",
                  "price": 34410.00,
                  "count": 0,
                },
                {
                  "name": "ELLIPSE MASA 200cm",
                  "image": "https://picsum.photos/200/200?3",
                  "price": 24255.00,
                  "count": 0,
                },
                {
                  "name": "ELLIPSE SANDALYE X2",
                  "image": "https://picsum.photos/200/200?4",
                  "price": 7980.00,
                  "count": 3,
                },
              ]),

              _buildExpansionForOptions(
                context,
                "Seçenekler",
                [
                  "ELLIPSE MASA ÜST TABLA",
                  "ELLIPSE MASA AYAK",
                  "Kumaş Rengi",
                ],
                onEdit: (option) {
                  debugPrint("Edit basıldı: $option");
                  // Burada bir modal bottom sheet veya dialog açabilirsin
                },
              ),

              _buildExpansionForPackages(context, "Paket Boyutları", [
                {
                  "name": "ELLIPSE KONSOL",
                  "packages": [
                    {"name": "Paket - 1", "size": "100X100X100", "volume": "1.00 M³"},
                    {"name": "Paket - 2", "size": "100X100X100", "volume": "1.00 M³"},
                  ],
                },
                {
                  "name": "ELLIPSE MASA 230cm",
                  "packages": [
                    {"name": "Paket - 1", "size": "100X100X100", "volume": "1.00 M³"},
                    {"name": "Paket - 2", "size": "100X100X100", "volume": "1.00 M³"},
                    {"name": "Paket - 3", "size": "100X100X100", "volume": "1.00 M³"},
                  ],
                },
                {
                  "name": "ELLIPSE AYNA",
                  "packages": [
                    {"name": "Paket - 1", "size": "100X100X100", "volume": "1.00 M³"},
                  ],
                },
              ]),

              _buildExpansionForTerms(context, "Satış Şartları", [
                "Teslimat: 3–7 iş günü içerisinde yapılır.",
                "Ürün 2 yıl üretici garantisi altındadır.",
                "Kurulum ücretsizdir (belirli bölgelerde).",
                "İade süresi 14 gündür, ambalaj açılmamış olmalıdır.",
              ]),
              _buildExpansionForOtherProducts(
                context,
                "Kategorideki Diğer Ürünler",
                [
                  {"name": "Modern Sofa", "image": "https://picsum.photos/200/200?1"},
                  {"name": "Köşe Takımı", "image": "https://picsum.photos/200/200?2"},
                  {"name": "Minimal Kanepe", "image": "https://picsum.photos/200/200?3"},
                  {"name": "Berjer", "image": "https://picsum.photos/200/200?4"},
                ],
              ),

              const SizedBox(height: 80),
            ],
          ),

          // 🔹 Geri butonu
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildExpansionForAttributes(
  BuildContext context,
  String title,
  List<Map<String, String>> products,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        // 👇 açılışta smooth animasyon
        children: [
          ...products.asMap().entries.map((entry) {
            final i = entry.key;
            final p = entry.value;
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 250 + (i * 100)),
              curve: Curves.easeOutCubic,
              builder: (context, t, child) => Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * 14),
                  child: child,
                ),
              ),
              child: _AttributeCard(p),
            );
          }),
        ],
      ),
    ),
  );
}

class _AttributeCard extends StatelessWidget {
  const _AttributeCard(this.data);
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['name'] ?? '',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 8),
          _buildAttrRow("Genişlik/Derinlik/Yükseklik", data['size'] ?? ''),
          _buildAttrRow("Kullanılan Malzeme", data['material'] ?? ''),
          _buildAttrRow("Paket Özelliği", data['package'] ?? ''),
          _buildAttrRow("Boya", data['paint'] ?? ''),
        ],
      ),
    );
  }
}

Widget _buildAttrRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Colors.orangeAccent,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildExpansionForTeam(BuildContext context, String title, List<Map<String, dynamic>> items) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        children: [
          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 250 + (i * 100)),
              curve: Curves.easeOutCubic,
              builder: (context, t, child) => Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * 14),
                  child: child,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item["image"],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Bilgi kısmı
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${item["price"].toStringAsFixed(2)} ₺ X ${item["count"]}",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Adet kontrol
                    Row(
                      children: [
                        _circleButton(Icons.remove, () {
                          // TODO: azaltma işlemi
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "${item["count"]}",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _circleButton(Icons.add, () {
                          // TODO: artırma işlemi
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

Widget _circleButton(IconData icon, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.orangeAccent, width: 1),
      ),
      child: Icon(icon, size: 18, color: Colors.orangeAccent),
    ),
  );
}

Widget _buildExpansionForPackages(
  BuildContext context,
  String title,
  List<Map<String, dynamic>> products,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        children: [
          ...products.asMap().entries.map((entry) {
            final i = entry.key;
            final product = entry.value;

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 250 + (i * 100)),
              curve: Curves.easeOutCubic,
              builder: (context, t, child) => Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * 14),
                  child: child,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ürün adı
                    Text(
                      product["name"],
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // tablo başlığı
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Paket",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.orangeAccent,
                              )),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text("(YxGxD) cm",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.orangeAccent,
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("Hacim",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.orangeAccent,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Divider(color: Colors.white.withOpacity(0.3)),

                    // satırlar
                    ...List.generate((product["packages"] as List).length, (j) {
                      final pkg = product["packages"][j];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(pkg["name"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  )),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(pkg["size"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(pkg["volume"],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  )),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

Widget _buildExpansionForTerms(
  BuildContext context,
  String title,
  List<String> terms,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        children: [
          ...terms.asMap().entries.map((entry) {
            final i = entry.key;
            final term = entry.value;

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 250 + (i * 100)),
              curve: Curves.easeOutCubic,
              builder: (context, t, child) => Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * 10),
                  child: child,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("✦ ", style: TextStyle(color: Colors.orangeAccent, fontSize: 14)),
                    Expanded(
                      child: Text(
                        term,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

Widget _buildExpansionForOptions(
  BuildContext context,
  String title,
  List<String> options, {
  void Function(String option)? onEdit,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        children: [
          ...options.map((option) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orangeAccent),
                    onPressed: () => onEdit?.call(option),
                  )
                ],
              ),
            );
          })
        ],
      ),
    ),
  );
}

Widget _buildExpansionForOtherProducts(
  BuildContext context,
  String title,
  List<Map<String, String>> products,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .2),
          Color.fromRGBO(66, 74, 83, .2),
          Color.fromRGBO(80, 88, 99, .2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white70,
        iconColor: Colors.orangeAccent,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        children: [
          SizedBox(
            height: 150, // kartların yüksekliği
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          product["image"]!,
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          product["name"]!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
