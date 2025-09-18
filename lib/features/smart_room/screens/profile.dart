import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scroll = ScrollController();
  double _t = 0; // collapse progress [0,1]

  // Demo veriler
  final String coverUrl = "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1200";
  final String avatarUrl = "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=800";
  final String displayName = "Tolga Ocaktaner";
  final String mail = "tolga@example.com";

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final offset = _scroll.offset.clamp(0, 180);
      setState(() => _t = offset / 180.0);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  LinearGradient get _g => const LinearGradient(
        colors: [Color(0xff343941), Color(0xff424a53), Color(0xff505863)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  @override
  Widget build(BuildContext context) {
    final titleOpacity = CurvedAnimation(parent: AlwaysStoppedAnimation(_t), curve: Curves.easeOut).value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _BlurredCover(imageUrl: coverUrl),
          CustomScrollView(
            controller: _scroll,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  avatarUrl: avatarUrl,
                  displayName: displayName,
                  mail: mail,
                  t: _t,
                  gradient: _g,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                sliver: SliverToBoxAdapter(child: _StatsRow(gradient: _g)),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                sliver: SliverToBoxAdapter(child: _SectionTitle("Hesabım")),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.list(
                  children: [
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.shopping_bag_outlined,
                      title: "Siparişlerim",
                      subtitle: "Geçmiş ve güncel siparişler",
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.favorite_border,
                      title: "Favorilerim",
                      subtitle: "Kaydettiğin ürünler",
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.shopping_cart_outlined,
                      title: "Sepetim",
                      subtitle: "Bekleyen ürünler",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                sliver: SliverToBoxAdapter(child: _SectionTitle("Ayarlar")),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.list(
                  children: [
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.location_on_outlined,
                      title: "Adreslerim",
                      subtitle: "Teslimat & Fatura adresleri",
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.lock_outline,
                      title: "Gizlilik",
                      subtitle: "Şifre & güvenlik",
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.notifications_none,
                      title: "Bildirimler",
                      subtitle: "E-posta & push tercihleri",
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _GlassTile(
                      gradient: _g,
                      icon: Icons.help_outline,
                      title: "Yardım",
                      subtitle: "Sık sorulan sorular",
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ========= Widgets =========

// ========= Blurred Cover =========
class _BlurredCover extends StatelessWidget {
  const _BlurredCover({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.55),
                  Colors.black.withOpacity(.35),
                  Colors.black.withOpacity(.2),
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

class _Header extends StatelessWidget {
  const _Header({
    required this.avatarUrl,
    required this.displayName,
    required this.mail,
    required this.t,
    required this.gradient,
  });

  final String avatarUrl;
  final String displayName;
  final String mail;
  final double t; // collapse progress
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final maxTextWidth = w - 64; // sağ-sol güvenli boşluk
    const double bottomSafe = 8; // taşma payı
    final height = lerpDouble(260, 200, t)! + bottomSafe; // dinamik + güvenlik
    final avatarSize = lerpDouble(108, 64, t)!;
    final topPad = lerpDouble(96, 64, t)!;
    final nameSize = lerpDouble(22, 18, t)!;
    final nameOpacity = (1 - (t * 0.35)).clamp(0.0, 1.0);

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          // üst degrade bant
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(.35), Colors.black.withOpacity(.05), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          // avatar + isim
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: topPad),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: 1 - (t * .06),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _Avatar(url: avatarUrl, size: avatarSize),
                  ),
                  const SizedBox(height: 8),
                  Opacity(
                    opacity: nameOpacity,
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxTextWidth),
                          child: Text(
                            displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: nameSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxTextWidth),
                          child: Text(
                            mail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Not: “Profili Düzenle” butonu kaldırıldı.
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.size});
  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 450),
          placeholder: (context, _) => Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade100,
            child: Container(color: Colors.grey.shade800),
          ),
          errorWidget: (context, _, __) => Container(
            color: Colors.black26,
            alignment: Alignment.center,
            child: const Icon(Icons.person, color: Colors.white54, size: 32),
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.gradient});
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _StatCard(icon: Icons.shopping_bag_outlined, label: "Orders", value: "12")),
        SizedBox(width: 12),
        Expanded(child: _StatCard(icon: Icons.favorite_border, label: "Favorites", value: "35")),
        SizedBox(width: 12),
        Expanded(child: _StatCard(icon: Icons.shopping_cart_outlined, label: "Cart", value: "3")),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      height: 88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(52, 57, 65, .20),
            Color.fromRGBO(66, 74, 83, .20),
            Color.fromRGBO(80, 88, 99, .20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.orangeAccent, size: 20),
                const SizedBox(width: 6),
                Text(
                  value,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}

class _GlassTile extends StatelessWidget {
  const _GlassTile({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final Gradient gradient;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(52, 57, 65, .18),
                Color.fromRGBO(66, 74, 83, .18),
                Color.fromRGBO(80, 88, 99, .18),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white10, width: 1),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.16), blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Icon(icon, color: Colors.orangeAccent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
