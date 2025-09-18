import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 sepet sayfasındakiyle aynı arka plan
          const _BlurredCover(imagePath: "assets/images/fav_bg.png"),

          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 30),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  children: const [
                    _FavCard(
                      title: "ROMA & NAPOLY",
                      desc: "Modern tasarım, rahat oturum",
                      price: 45250.00,
                      imageUrl: "",
                    ),
                    SizedBox(height: 14),
                    _FavCard(
                      title: "ELLİPSE KONSOL",
                      desc: "Geniş depolama alanı",
                      price: 31350.00,
                      imageUrl: "",
                    ),
                    SizedBox(height: 14),
                    _FavCard(
                      title: "OPUS BERJER",
                      desc: "Yumuşak dokulu, kompakt",
                      price: 11890.00,
                      imageUrl: "",
                    ),
                    SizedBox(height: 14),
                    _FavCard(
                      title: "VERONA KOLTUK",
                      desc: "Şık ve fonksiyonel",
                      price: 38990.00,
                      imageUrl: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        height: 64,
        child: const _GlassFavBar(totalCount: 4),
      ),
    );
  }
}

class _GlassFavBar extends StatelessWidget {
  const _GlassFavBar({required this.totalCount});
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.transparent),
          ),
          child: Row(
            children: [
              Expanded(
                child: _GlassButton(
                  text: "Tümünü Sepete Ekle ($totalCount)",
                  onTap: () {
                    // TODO: toplu sepete ekle
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: Colors.white.withOpacity(.12),
          highlightColor: Colors.white.withOpacity(.06),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔹 Sepet ekranındakinin aynısı
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
                  Color.fromARGB(155, 30, 31, 35),
                  Color.fromARGB(155, 37, 40, 45),
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

// ----------------- FAVORI KARTI -----------------

class _FavCard extends StatelessWidget {
  const _FavCard({
    required this.title,
    required this.desc,
    required this.price,
    required this.imageUrl,
  });

  final String title;
  final String desc;
  final double price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const double thumb = 92;

    final card = Container(
      decoration: _cardDeco,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Thumb(imageUrl: imageUrl, size: thumb),
          const SizedBox(width: 12),

          // SAĞ BLOK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Üst: ad
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

                // Orta: açıklama + kalem
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
                const SizedBox(height: 10),

                // Alt: fiyat + sepete ekle
                Row(
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
                    const SizedBox(width: 8),
                    _MiniPrimaryButton(
                      text: "Sepete Ekle",
                      onTap: () {
                        // TODO: sepete ekle
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // 🔹 Slidable (şeffaf arka plan + kompakt butonlar)
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 120),
      child: Slidable(
        key: ValueKey(title),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.6,
          dragDismissible: false,
          children: [
            _SlideActionButton(
              label: "Bilgi",
              icon: Icons.info_outline,
              fg: const Color(0xFF4CC6FF),
              bg: const Color(0xFF22303A),
              onPressed: (_) {
                // TODO: bilgi
              },
            ),
            _SlideActionButton(
              label: "Kaldır",
              icon: CupertinoIcons.heart_slash,
              fg: const Color(0xFFFF6B6B),
              bg: const Color(0xFF3A2323),
              onPressed: (_) {
                // TODO: favoriden kaldır
              },
            ),
          ],
        ),
        child: card,
      ),
    );
  }
}

// ----------------- SLIDE ACTION BUTTON -----------------

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
      backgroundColor: Colors.transparent, // 🔸 panel arka planı şeffaf
      flex: 1,
      onPressed: onPressed ?? (_) {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 22),
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

// ----------------- ALT BAR -----------------

class _FavBottomBar extends StatelessWidget {
  const _FavBottomBar({required this.totalCount});
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _GButton(
                text: "Tümünü Sepete Ekle ($totalCount)",
                onTap: () {
                  // TODO: toplu sepete ekle
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- PAYLAŞILAN BİLEŞENLER -----------------

class _MiniPrimaryButton extends StatelessWidget {
  const _MiniPrimaryButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xff343941), Color(0xff424a53), Color(0xff505863)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        shadowColor: Colors.black45,
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
                    height: 1,
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
