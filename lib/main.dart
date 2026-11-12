import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

const navy = Color(0xFF091843);
const orange = Color(0xFFE8631A);
const gold = Color(0xFFF5A623);
const cream = Color(0xFFFFF8F0);
const ink = Color(0xFF2A1F2D);
const muted = Color(0xFF6B5B6E);
const silver = Color(0xFFE3E6EC);

const whatsappNumber = '966536669944';
const whatsappDisplay = '0536669944';
const tiktokUrl = 'https://www.tiktok.com/@m9a9f';

String waUrl([String text = '']) =>
    'https://wa.me/$whatsappNumber${text.isEmpty ? '' : '?text=${Uri.encodeComponent(text)}'}';

Future<void> openLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

void main() => runApp(const SilverOrbitApp());

class SilverOrbitApp extends StatelessWidget {
  const SilverOrbitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المدار الفضي للسفر والسياحة',
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        scaffoldBackgroundColor: cream,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final servicesKey = GlobalKey();
  static final howKey = GlobalKey();
  static final contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        titleSpacing: 12,
        title: Row(
          children: [
            const CircleLogo(size: 38),
            const SizedBox(width: 10),
            Text('المدار الفضي',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          PopupMenuButton<GlobalKey>(
            icon: const Icon(Icons.menu),
            onSelected: _scrollTo,
            itemBuilder: (_) => [
              PopupMenuItem(value: servicesKey, child: const Text('خدماتنا')),
              PopupMenuItem(value: howKey, child: const Text('كيف تحجز')),
              PopupMenuItem(value: contactKey, child: const Text('تواصل')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        onPressed: () => openLink(waUrl()),
        child: const Icon(Icons.chat),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(onBook: () => openLink(waUrl('أريد حجز رحلة'))),
            Section(
              key: servicesKey,
              title: 'خدماتنا',
              subtitle: 'المدار الفضي للسفر والسياحة، وجهتك لرحلة بلا عناء',
              children: const [
                InfoCard(icon: '🎫', title: 'تذاكر الطيران', text: 'أفضل الأسعار على مختلف الخطوط الجوية'),
                InfoCard(icon: '🏨', title: 'حجز الفنادق', text: 'إقامة مريحة تناسب ميزانيتك'),
                InfoCard(icon: '🧳', title: 'باقات سياحية', text: 'برامج متكاملة للأفراد والعائلات'),
                InfoCard(icon: '🛂', title: 'التأشيرات', text: 'مساعدة في إجراءات الفيزا والمستندات'),
              ],
            ),
            Section(
              key: howKey,
              title: 'كيف تحجز؟',
              subtitle: 'ثلاث خطوات بسيطة',
              children: const [
                InfoCard(step: 1, title: 'تواصل معنا', text: 'عبر الواتساب وأخبرنا بوجهتك'),
                InfoCard(step: 2, title: 'اختر العرض', text: 'نرسل لك أنسب الخيارات والأسعار'),
                InfoCard(step: 3, title: 'سافر', text: 'نؤكد الحجز وتستمتع برحلتك'),
              ],
            ),
            ContactBanner(key: contactKey),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class CircleLogo extends StatelessWidget {
  final double size;
  final bool fancy;
  const CircleLogo({super.key, required this.size, this.fancy = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: fancy ? Border.all(color: silver, width: 4) : null,
        boxShadow: fancy
            ? const [
                BoxShadow(color: Color(0x47E2E5EC), spreadRadius: 7),
                BoxShadow(color: Color(0x1FE2E5EC), spreadRadius: 14),
                BoxShadow(
                    color: Color(0x59282D46),
                    blurRadius: 32,
                    offset: Offset(0, 12)),
              ]
            : null,
      ),
      child: ClipOval(
        child: Image.asset('assets/logo.jpg', fit: BoxFit.cover),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onBook;
  const HeroSection({super.key, required this.onBook});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: h * 0.85),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF5B6F9A),
            Color(0xFFC98A7A),
            Color(0xFFF2A65A),
            Color(0xFFD9B8A0),
          ],
          stops: [0, 0.45, 0.7, 1],
        ),
      ),
      child: Stack(
        children: [
          // الشمس
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 0.5),
                  radius: 0.6,
                  colors: [Color(0xFFFFF3B0), Color(0xCCFFB347), Color(0x00E8631A)],
                  stops: [0, 0.25, 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleLogo(size: 140, fancy: true),
                  const SizedBox(height: 28),
                  Text('وقت السفر',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.w900)),
                  const Text('Travel time',
                      style: TextStyle(
                          fontFamily: 'cursive',
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFFFE28A),
                          fontSize: 44)),
                  const SizedBox(height: 10),
                  Text('إجازة الصيف هي الوقت المثالي للسفر',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 14),
                  Transform.rotate(
                    angle: -0.35,
                    child: const Icon(Icons.flight, color: Colors.white, size: 64),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: navy,
                      elevation: 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 38, vertical: 14),
                      shape: const StadiumBorder(),
                    ),
                    child: Text('احجز رحلتك الآن!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  const Section(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: ink)),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: muted)),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String? icon;
  final int? step;
  final String title;
  final String text;
  const InfoCard(
      {super.key, this.icon, this.step, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0E0CC)),
      ),
      child: Column(
        children: [
          if (icon != null) Text(icon!, style: const TextStyle(fontSize: 36)),
          if (step != null)
            CircleAvatar(
              radius: 17,
              backgroundColor: gold,
              child: Text('$step',
                  style: const TextStyle(
                      color: navy, fontWeight: FontWeight.w900)),
            ),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: ink)),
          const SizedBox(height: 4),
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: muted)),
        ],
      ),
    );
  }
}

class ContactBanner extends StatelessWidget {
  const ContactBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [gold, orange]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text('جاهز لإجازة الصيف؟',
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
          Text('راسلنا الآن وابدأ التخطيط لرحلتك',
              style: TextStyle(color: navy)),
          const SizedBox(height: 18),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton(
                style: style,
                onPressed: () => openLink(waUrl()),
                child: Text('واتساب $whatsappDisplay',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                style: style,
                onPressed: () => openLink(tiktokUrl),
                child: Text('تيك توك @m9a9f',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: Column(
        children: [
          const CircleLogo(size: 64),
          const SizedBox(height: 8),
          Text('© المدار الفضي للسفر والسياحة',
              style: TextStyle(color: muted, fontSize: 14)),
        ],
      ),
    );
  }
}
