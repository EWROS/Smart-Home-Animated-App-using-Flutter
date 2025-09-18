import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_home_animation/core/app/models/urunModel.dart';
import 'package:smart_home_animation/features/smart_room/screens/product_detail.dart';

import '../../../core/shared/domain/entities/smart_room.dart';

class RoomDetailsPageView extends StatelessWidget {
  const RoomDetailsPageView({
    required this.animation,
    required this.room,
    super.key,
  });

  final Animation<double> animation;
  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    final int roomCollectionId = (room.id is int) ? room.id as int : int.tryParse(room.id.toString()) ?? -1;

    final urunler = ornekUrunler.where((u) => u.collectionIds.contains(roomCollectionId)).toList();

    if (urunler.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Bu koleksiyonda ürün bulunamadı (room.id=$roomCollectionId).",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
      );
    }

    return PageView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            SlideTransition(
              position: Tween(
                begin: const Offset(-1, 1),
                end: Offset.zero,
              ).animate(animation),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_left),
                  label: const Text('BACK'),
                ),
              ),
            ),

            // 🔻 ürünler swipe ile geçiliyor
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: urunler.length,
                itemBuilder: (context, index) {
                  final urun = urunler[index];
                  return ProductDetailEmbedded(urun: urun);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProductDetailEmbedded extends StatelessWidget {
  const ProductDetailEmbedded({super.key, required this.urun});
  final UrunModel urun;

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      5,
      (i) => "https://picsum.photos/800/600?random=${urun.id + i}",
    )..[0] = urun.resimUrl;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        // 📌 Hero sadece ilk görselde çalışacak
        ParallaxGallery(
          images: images,
          aspectRatio: 1,
          heroTag: "urun_${urun.id}",
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                urun.ad,
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "${urun.fiyat.toStringAsFixed(0)} ₺",
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          "Modern çizgiler, dayanıklı iskelet ve kolay temizlenebilir kumaş. "
          "Salonunuza estetik ve fonksiyonellik katar.",
          style: GoogleFonts.montserrat(
            fontSize: 15,
            color: Colors.white,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  reverseTransitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, animation, __) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                        ),
                        child: UrunDetailScreen(urun: urun),
                      ),
                    );
                  },
                ),
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
                      "View All Details",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ParallaxGallery extends StatefulWidget {
  const ParallaxGallery({
    super.key,
    required this.images,
    this.aspectRatio = 1,
    this.borderRadius = 20,
    this.heroTag,
    this.onPageChanged, // 🔹 yeni callback
  });

  final List<String> images;
  final double aspectRatio;
  final double borderRadius;
  final String? heroTag; // Hero opsiyonel
  final ValueChanged<int>? onPageChanged; // 🔹 sayfa değiştiğinde

  @override
  State<ParallaxGallery> createState() => _ParallaxGalleryState();
}

class _ParallaxGalleryState extends State<ParallaxGallery> {
  late final PageController _controller;
  double page = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);
    _controller.addListener(() {
      setState(() => page = _controller.page ?? 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasAncestorHero = context.findAncestorWidgetOfExactType<Hero>() != null;

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: widget.onPageChanged, // 🔹 dışarıya bildir
            itemBuilder: (context, index) {
              final offset = (page - index).clamp(-1.0, 1.0);

              final imageWidget = CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 200),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade800,
                  highlightColor: Colors.grey.shade100,
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                ),
              );

              final content = ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: SizedBox.expand(child: imageWidget),
              );

              final canUseHero = widget.heroTag != null && widget.heroTag!.isNotEmpty && index == 0 && !hasAncestorHero;

              return Transform.translate(
                offset: Offset(offset * -40, 0), // parallax
                child: canUseHero ? Hero(tag: widget.heroTag!, child: content) : content,
              );
            },
          ),

          // 🔹 Dot indicator
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (i) {
                final isActive = (page.round() == i);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.orange : const Color.fromRGBO(255, 255, 255, 0.6).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
