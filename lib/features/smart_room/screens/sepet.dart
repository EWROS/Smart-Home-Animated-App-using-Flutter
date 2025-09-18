import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _BlurredCover(imagePath: "assets/images/sepet_background.png"),
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 16),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  children: const [
                    _CartCard.single(
                      title: "ELLİPSE DRESUAR",
                      desc: "Geniş depolama alanı, modern çizgiler",
                      price: 24580.00,
                      qty: 1,
                      imageUrl: "", // doldurursun
                    ),
                    SizedBox(height: 16),
                    _BundleCard(
                      bundleTitle: "ELLİPSE YEMEK ODASI",
                      total: 85500.00,
                      qty: 1,
                      items: [
                        _BundleItem(
                          title: "ELLİPSE KONSOL",
                          desc: "Geniş depolama alanı",
                          price: 31350.00,
                          qty: 1,
                          imageUrl: "",
                        ),
                        _BundleItem(
                          title: "ELLİPSE MASA",
                          desc: "6 kişilik yemek masası",
                          price: 37205.00,
                          qty: 1,
                          imageUrl: "",
                        ),
                        _BundleItem(
                          title: "ELLİPSE AYNA",
                          desc: "Dekoratif büyük ayna",
                          price: 16945.00,
                          qty: 1,
                          imageUrl: "",
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _CartCard.single(
                      title: "ELLİPSE TV ÜNİTESİ",
                      desc: "Kablolama için gizli bölmeler",
                      price: 27205.00,
                      qty: 1,
                      imageUrl: "",
                    ),
                    SizedBox(height: 16),
                    _CartCard.single(
                      title: "ELLİPSE DRESUAR",
                      desc: "Dar alanlara uygun ince tasarım",
                      price: 24580.00,
                      qty: 1,
                      imageUrl: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: const _CartBottomBar(total: 161865.00),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 32, // yanlardan boşluk bırak
        height: 80,
        child: _GlassActionBar(total: 161865.00),
      ),
    );
  }
}

// ----------------- WIDGETS -----------------

class _BlurredCover extends StatelessWidget {
  const _BlurredCover({required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(100, 30, 31, 35), // %80 opak koyu ton
                  Color.fromARGB(100, 37, 40, 45),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CartCard extends StatelessWidget {
  const _CartCard.single({
    required this.title,
    required this.desc,
    required this.price,
    required this.qty,
    required this.imageUrl,
    this.isCompact = false,
  });

  final String title;
  final String desc;
  final double price;
  final int qty;
  final String imageUrl;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final double h = isCompact ? 120 : 136;
    final double thumb = isCompact ? 84 : 92;

    final card = Container(
      // height: h,  // <-- sabit height kaldırıldı
      decoration: _cardDeco,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Thumb(imageUrl: imageUrl, size: thumb),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ÜST: Ad
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),

                // ORTA: Açıklama + kalem
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        desc,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.edit, size: 16, color: Colors.white.withOpacity(.8)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // ALT: Fiyat + Adet
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "₺ ${_money(price)}",
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF37C377),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Adt: $qty",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.edit, size: 16, color: Colors.white.withOpacity(.8)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: h),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.75, // iki butona uygun genişlik
          children: [
            _SlideActionButton(
              label: "Bilgi",
              icon: Icons.info_outline,
              fg: const Color(0xFF4CC6FF),
              bg: const Color(0xFF22303A),
              onPressed: (_) {
                // TODO: bilgi aksiyonu
              },
            ),
            _SlideActionButton(
              label: "Sil",
              icon: Icons.delete_outline,
              fg: const Color(0xFFFF6B6B),
              bg: const Color(0xFF3A2323),
              onPressed: (_) {
                // TODO: silme aksiyonu
              },
            ),
          ],
        ),
        child: card,
      ),
    );
  }
}

class _SlideActionButton extends StatelessWidget {
  const _SlideActionButton({
    required this.label,
    required this.icon,
    required this.fg,
    required this.bg,
    this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color fg;
  final Color bg;
  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      backgroundColor: Colors.transparent,
      flex: 1,
      onPressed: onPressed ?? (_) {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 22), // tam ortalanmış
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KARE THUMBNAIL (zaten kare ama garantiye alalım)
class _Thumb extends StatelessWidget {
  const _Thumb({required this.imageUrl, required this.size});
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl.isEmpty
            ? Container(
                color: Colors.white.withOpacity(.06),
                alignment: Alignment.center,
                child: Icon(Icons.image, color: Colors.white24, size: size * .5),
              )
            : Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

// ---- küçük yardımcı görünümler ----

class _NamePill extends StatelessWidget {
  const _NamePill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }
}

class _BundleCard extends StatelessWidget {
  const _BundleCard({
    required this.bundleTitle,
    required this.total,
    required this.qty,
    required this.items,
  });

  final String bundleTitle;
  final double total;
  final int qty;
  final List<_BundleItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDeco,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst başlık
          Row(
            children: [
              Expanded(
                child: Text(
                  bundleTitle,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Color(0xFFFF6B6B)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),

          // İç ürünler
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _CartCard.single(
                title: e.title,
                desc: e.desc, // açıklama
                price: e.price,
                qty: e.qty,
                imageUrl: e.imageUrl,
                isCompact: true,
              ),
            ),
          ),

          // Alt toplam
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total:  ₺ ${_money(total)}",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF37C377),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(Icons.edit, size: 16, color: Colors.white.withOpacity(.6)),
              const SizedBox(width: 4),
              Text(
                "Adt: $qty",
                style: GoogleFonts.montserrat(color: Colors.white70, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BundleItem {
  final String title;
  final String desc; // açıklama
  final double price;
  final int qty;
  final String imageUrl;

  const _BundleItem({
    required this.title,
    required this.desc,
    required this.price,
    required this.qty,
    required this.imageUrl,
  });
}

/// 🔹 Cam efektli action bar
class _GlassActionBar extends StatelessWidget {
  const _GlassActionBar({required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Expanded(
                child: _GlassButton(
                  text: "Teklif İste",
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GlassButton(
                  text: "Sipariş Oluştur",
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white.withOpacity(.08),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(
                  "₺ ${_money(total)}",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF37C377),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Cam efektli mini buton
class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [Color(0xff343941), Color(0xff424a53), Color(0xff505863)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: Colors.white.withOpacity(.12),
          highlightColor: Colors.white.withOpacity(.06),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GButton extends StatelessWidget {
  const _GButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Material(
        elevation: 6,
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xff343941), Color(0xff424a53), Color(0xff505863)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            splashColor: Colors.white.withOpacity(.12),
            highlightColor: Colors.white.withOpacity(.06),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1, // tipografik baseline sapmasını azaltır
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------- helpers -----------------

BoxDecoration get _cardDeco => BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(52, 57, 65, .22),
          Color.fromRGBO(66, 74, 83, .22),
          Color.fromRGBO(80, 88, 99, .22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: Colors.white10),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.28), blurRadius: 14, offset: Offset(0, 8)),
      ],
    );

String _money(double v) {
  final s = v.toStringAsFixed(2);
  final parts = s.split('.');
  final intPart = parts[0].replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');
  return "$intPart,${parts[1]}";
}
