import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart'; // PACOTE ADICIONADO

void main() {
  runApp(const BlueThermalApp());
}

class BlueThermalApp extends StatelessWidget {
  const BlueThermalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueThermal Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Roboto', color: Color(0xFF94A3B8)), // Slate 400
          headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  String _lang = 'pt'; // Padrão Português

  // Links
  final String _repoUrl = 'https://github.com/mateuspc/blue_thermal_plus';
  final String _pubDevUrl = 'https://pub.dev/packages/blue_thermal_plus/install'; // URL ADICIONADA
  final String _linkedinUrl = 'https://www.linkedin.com/in/mateusdesenvolvedorflutter/';
  final String _whatsappUrl = 'https://wa.me/5528999715663'; // HTTPS é preferível

  // Dicionário de Traduções
  final Map<String, Map<String, dynamic>> _translations = {
    'pt': {
      'nav_docs': 'Documentação',
      'nav_get': 'Baixar no Pub.dev',
      'hero_badge': 'v1.0.0 Versão Estável',
      'hero_title_pre': 'A Ponte que Faltava para\n',
      'hero_title_high': 'Bluetooth no Flutter.',
      'hero_subtitle': 'A maioria dos plugins obriga a escolher: BLE ou Classic. O BlueThermal Plus unifica tudo com suporte completo a iOS External Accessory e manuseio robusto de RFCOMM no Android.',
      'btn_arch': 'Ver Arquitetura',
      'feat_ios_title': 'iOS Classic (MFi)',
      'feat_ios_desc': "Pare de dizer aos clientes que 'iOS só suporta BLE'. Implementamos o framework ExternalAccessory completo.",
      'feat_hybrid_title': 'Transporte Híbrido',
      'feat_hybrid_desc': 'Uma única API Dart unificada que alterna entre BLE (GATT) e Classic (RFCOMM/SPP) instantaneamente.',
      'feat_rel_title': 'Confiabilidade Industrial',
      'feat_rel_desc': 'Nossa camada nativa lida com negociação de MTU e fragmentação inteligente para evitar perda de dados.',
      'arch_title': 'Arquitetura de Nível de Produção',
      'arch_subtitle': 'Inspecione a implementação nativa que lida com a ponte complexa.',
      'check_mem': 'Memória Segura',
      'check_mem_desc': 'Streams descartadas ao desconectar.',
      'check_thread': 'Otimização de Threads',
      'check_thread_desc': 'E/S movida para background.',
      'matrix_title': 'Matriz de Compatibilidade',
      'footer_built': 'Feito com precisão para a Comunidade Flutter.\nLançado sob Licença MIT.',
      // Tabela
      'tbl_feat': 'Funcionalidade',
      'tbl_native': 'Nativo',
      'tbl_native_core': 'Nativo (CoreBluetooth)',
      'tbl_socket': 'Socket RFCOMM',
      'tbl_mfi': 'External Accessory (MFi)',
      'tbl_auto': 'Automático',
      'tbl_os': 'Gerenciado pelo SO',
      'tbl_conf_ms': 'Configurável (ms)',
      'tbl_conf_us': 'Configurável (us)',
      // Sobre Mim
      'about_title': 'Sobre o Criador',
      'about_name': 'Mateus Polonini Cardoso',
      'about_role': 'Engenheiro de Software Mobile | Especialista Flutter & Nativo',
      'about_bio': 'Engenheiro de Software com sólida base em desenvolvimento nativo Android (Kotlin/Java) e Flutter. Especialista em resolver problemas complexos de integração de hardware, Clean Architecture e CI/CD. Minha experiência criando soluções robustas para o setor financeiro e de crédito garante que este plugin foi construído pensando em segurança e performance.',
      'btn_linkedin': 'Conectar no LinkedIn',
      'btn_whatsapp': 'Falar no WhatsApp',
    },
    'en': {
      'nav_docs': 'Documentation',
      'nav_get': 'Get it on Pub.dev',
      'hero_badge': 'v1.0.0 Stable Release',
      'hero_title_pre': 'The Missing Bridge for\n',
      'hero_title_high': 'Flutter Bluetooth.',
      'hero_subtitle': 'Most plugins force you to choose: BLE or Classic. BlueThermal Plus unifies the stack with full iOS External Accessory support and robust Android RFCOMM handling.',
      'btn_arch': 'See the Architecture',
      'feat_ios_title': 'iOS Classic (MFi)',
      'feat_ios_desc': "Stop telling clients 'iOS only supports BLE'. We implement the full ExternalAccessory framework.",
      'feat_hybrid_title': 'Hybrid Transport',
      'feat_hybrid_desc': 'A single unified Dart API that switches between BLE (GATT) and Classic (RFCOMM/SPP) instantly.',
      'feat_rel_title': 'Industrial Reliability',
      'feat_rel_desc': 'Our native layer handles MTU negotiation and intelligent chunking to prevent data loss.',
      'arch_title': 'Production-Grade Architecture',
      'arch_subtitle': 'Inspect the native implementation handling the complex bridging.',
      'check_mem': 'Memory Safe',
      'check_mem_desc': 'Streams disposed on disconnect.',
      'check_thread': 'Thread Optimized',
      'check_thread_desc': 'I/O offloaded to background.',
      'matrix_title': 'Protocol Compatibility Matrix',
      'footer_built': 'Built with precision for the Flutter Community.\nReleased under MIT License.',
      // Tabela
      'tbl_feat': 'Feature',
      'tbl_native': 'Native',
      'tbl_native_core': 'Native (CoreBluetooth)',
      'tbl_socket': 'RFCOMM Socket',
      'tbl_mfi': 'External Accessory (MFi)',
      'tbl_auto': 'Automatic',
      'tbl_os': 'OS Managed',
      'tbl_conf_ms': 'Configurable (ms)',
      'tbl_conf_us': 'Configurable (us)',
      // About Me
      'about_title': 'About the Creator',
      'about_name': 'Mateus Polonini Cardoso',
      'about_role': 'Mobile Software Engineer | Flutter & Native Specialist',
      'about_bio': 'Software Engineer with a strong foundation in native Android (Kotlin/Java) and Flutter. Specialist in solving complex hardware integration problems, Clean Architecture, and CI/CD. My experience building robust solutions for the financial and credit sectors ensures this plugin is built with security and performance in mind.',
      'btn_linkedin': 'Connect on LinkedIn',
      'btn_whatsapp': 'Chat on WhatsApp',
    }
  };

  String t(String key) => _translations[_lang]![key] ?? key;

  void _toggleLang() {
    setState(() {
      _lang = _lang == 'pt' ? 'en' : 'pt';
    });
  }

  // --- IMPLEMENTAÇÃO REAL DO URL LAUNCHER ---
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Não foi possível abrir o link: $url'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir link: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isDesktop),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100,
            left: size.width / 2 - 400,
            child: Container(
              width: 800,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.15),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: const SizedBox(),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 120),
                _buildHeroSection(context, isDesktop),
                _buildFeaturesSection(context, isDesktop),
                _buildCodeShowcaseSection(context, isDesktop),
                _buildCompatibilityTable(context, isDesktop),
                const SizedBox(height: 80),
                _buildAboutMeSection(context, isDesktop),
                const SizedBox(height: 80),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDesktop) {
    return AppBar(
      backgroundColor: const Color(0xFF0F172A).withOpacity(0.8),
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(left: isDesktop ? 40 : 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bluetooth, color: Colors.blue),
            const SizedBox(width: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                children: [
                  TextSpan(text: 'BlueThermal'),
                  TextSpan(text: 'Plus', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: isDesktop
          ? [
        TextButton(
          onPressed: _toggleLang,
          child: Row(
            children: [
              const Icon(Icons.language, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(_lang.toUpperCase(), style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () => _launchUrl(_repoUrl),
          child: Text(t('nav_docs'), style: const TextStyle(color: Color(0xFF94A3B8))),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => _launchUrl(_repoUrl),
          icon: const Icon(Icons.code, color: Color(0xFF94A3B8)),
        ),
        const SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: () => _launchUrl(_pubDevUrl), // URL ATUALIZADA AQUI
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              shape: const StadiumBorder(),
            ),
            child: Text(t('nav_get'), style: const TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 40),
      ]
          : [
        IconButton(onPressed: _toggleLang, icon: Icon(Icons.language, color: Colors.blue[200])),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(t('hero_badge'), style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFF60A5FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: t('hero_title_pre'),
                    style: TextStyle(fontSize: isDesktop ? 64 : 40, fontWeight: FontWeight.bold, height: 1.1, color: Colors.white),
                  ),
                  TextSpan(
                    text: t('hero_title_high'),
                    style: TextStyle(fontSize: isDesktop ? 64 : 40, fontWeight: FontWeight.bold, height: 1.1, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 700,
            child: Text(
              t('hero_subtitle'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isDesktop ? 20 : 16, color: const Color(0xFF94A3B8), height: 1.5),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildTerminalButton(),
              ElevatedButton(
                onPressed: () => _launchUrl(_repoUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  shadowColor: Colors.blue.withOpacity(0.5),
                  elevation: 8,
                ),
                child: Text(t('btn_arch'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalButton() {
    return InkWell(
      onTap: () {
        Clipboard.setData(const ClipboardData(text: 'flutter pub add blue_thermal_plus'));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copiado!')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          border: Border.all(color: const Color(0xFF334155)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('\$', style: TextStyle(color: Colors.blue, fontFamily: 'Courier')),
            SizedBox(width: 8),
            Text('flutter pub add blue_thermal_plus', style: TextStyle(color: Color(0xFFCBD5E1), fontFamily: 'Courier')),
            SizedBox(width: 16),
            Icon(Icons.copy, size: 16, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureCard(icon: Icons.bolt, title: t('feat_ios_title'), description: t('feat_ios_desc'), width: isDesktop ? 350 : double.infinity),
              _buildFeatureCard(icon: Icons.layers, title: t('feat_hybrid_title'), description: t('feat_hybrid_desc'), width: isDesktop ? 350 : double.infinity),
              _buildFeatureCard(icon: Icons.memory, title: t('feat_rel_title'), description: t('feat_rel_desc'), width: isDesktop ? 350 : double.infinity),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String description, required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[400], size: 32),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Color(0xFF94A3B8), height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildAboutMeSection(BuildContext context, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF1E293B), const Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.blue.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 40, offset: const Offset(0, 10)),
              ],
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar / Initials
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      "MP",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: isDesktop ? 40 : 0, height: isDesktop ? 0 : 32),

                // Bio
                Expanded(
                  child: Column(
                    crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                    children: [
                      Text(t('about_title').toUpperCase(), style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      const SizedBox(height: 8),
                      Text(t('about_name'), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(t('about_role'), style: TextStyle(fontSize: 16, color: Colors.blue[200])),
                      const SizedBox(height: 16),
                      Text(
                        t('about_bio'),
                        textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                        style: const TextStyle(color: Color(0xFF94A3B8), height: 1.6, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => _launchUrl(_linkedinUrl),
                            icon: const Icon(Icons.link, size: 18),
                            label: Text(t('btn_linkedin')),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF475569)),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(_whatsappUrl),
                            icon: const Icon(Icons.chat_bubble_outline, size: 18),
                            label: Text(t('btn_whatsapp')),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeShowcaseSection(BuildContext context, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: CodeShowcaseWidget(lang: _lang, translations: _translations),
        ),
      ),
    );
  }

  Widget _buildCompatibilityTable(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(t('matrix_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF334155)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFF1E293B)),
                    dataRowColor: WidgetStateProperty.all(const Color(0xFF0F172A)),
                    columnSpacing: isDesktop ? 100 : 20,
                    columns: [
                      DataColumn(label: Text(t('tbl_feat'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                      DataColumn(label: Text('Android', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                      DataColumn(label: Text('iOS', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                    ],
                    rows: [
                      _buildDataRow('BLE (GATT)', t('tbl_native'), '${t('tbl_native')} (CoreBluetooth)', Colors.greenAccent),
                      _buildDataRow('Classic (SPP)', t('tbl_socket'), t('tbl_mfi'), Colors.blueAccent),
                      _buildDataRow('MTU Negotiation', t('tbl_auto'), t('tbl_os'), Colors.grey),
                      _buildDataRow('Chunking', t('tbl_conf_ms'), t('tbl_conf_us'), Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(String feature, String android, String ios, Color highlightColor) {
    return DataRow(cells: [
      DataCell(Text(feature, style: const TextStyle(color: Color(0xFFCBD5E1)))),
      DataCell(Row(children: [
        if (highlightColor != Colors.grey) Icon(Icons.check, size: 16, color: highlightColor),
        const SizedBox(width: 8),
        Text(android, style: TextStyle(color: highlightColor == Colors.grey ? const Color(0xFF64748B) : highlightColor)),
      ])),
      DataCell(Row(children: [
        if (highlightColor != Colors.grey) Icon(Icons.check, size: 16, color: highlightColor),
        const SizedBox(width: 8),
        Text(ios, style: TextStyle(color: highlightColor == Colors.grey ? const Color(0xFF64748B) : highlightColor, fontWeight: highlightColor == Colors.blueAccent ? FontWeight.bold : FontWeight.normal)),
      ])),
    ]);
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1E293B))),
      ),
      child: Column(
        children: [
          const Icon(Icons.bluetooth, color: Color(0xFF475569)),
          const SizedBox(height: 16),
          const Text('BlueThermal Plus', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(t('footer_built'), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF475569), fontSize: 12)),
        ],
      ),
    );
  }
}

class CodeShowcaseWidget extends StatefulWidget {
  final String lang;
  final Map<String, Map<String, dynamic>> translations;
  const CodeShowcaseWidget({super.key, required this.lang, required this.translations});
  @override
  State<CodeShowcaseWidget> createState() => _CodeShowcaseWidgetState();
}

class _CodeShowcaseWidgetState extends State<CodeShowcaseWidget> {
  String _activeTab = 'ios';
  String get t => widget.translations[widget.lang]![_activeTab == 'ios' ? 'feat_ios_desc' : _activeTab == 'android' ? 'feat_rel_desc' : 'feat_hybrid_desc'];
  String get title => widget.translations[widget.lang]!['arch_title'];
  String get subtitle => widget.translations[widget.lang]!['arch_subtitle'];
  String get memSafe => widget.translations[widget.lang]!['check_mem'];
  String get memSafeDesc => widget.translations[widget.lang]!['check_mem_desc'];
  String get thread => widget.translations[widget.lang]!['check_thread'];
  String get threadDesc => widget.translations[widget.lang]!['check_thread_desc'];

  final Map<String, dynamic> _snippets = {
    'ios': {'title': 'Swift (External Accessory)', 'code': '''// EAClassicTransport.swift\nfunc connect(deviceId: String) {\n  guard let accessory = store.classicAccessory(idString: deviceId) else { return }\n  let protocolToUse = preferredProtocol ?? accessory.protocolStrings.first!\n  guard let s = EASession(accessory: accessory, forProtocol: protocolToUse) else { return }\n  session = s\n  outStream?.schedule(in: .main, forMode: .common)\n  outStream?.open()\n}'''},
    'android': {'title': 'Kotlin (BLE + Classic)', 'code': '''// BleTransport.kt\noverride fun printRaw(data: ByteArray) {\n    Thread {\n        var offset = 0\n        while (offset < data.size) {\n            val length = min(chunkSize, data.size - offset)\n            val chunk = Arrays.copyOfRange(data, offset, offset + length)\n            writeCharacteristic?.value = chunk\n            Thread.sleep(chunkDelayMs)\n        }\n    }.start()\n}'''},
    'dart': {'title': 'Dart (Unified API)', 'code': '''// blue_thermal_plus.dart\nfinal blue = BlueThermalPlus();\nawait blue.configure(PrinterConfig(\n  ble: BleConfig(chunkSize: 100),\n  classic: ClassicConfig(preferredProtocol: "com.zebra.rawport")\n));\nawait blue.connect(deviceId: "AA:BB...", transport: PrinterTransport.classic);\nawait blue.printRawBytes(data);'''}
  };

  @override
  Widget build(BuildContext context) {
    final activeData = _snippets[_activeTab];
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Column(
      children: [
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(color: Color(0xFF94A3B8))),
            ]),
            SizedBox(height: isDesktop ? 0 : 20),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF334155))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _snippets.keys.map((key) {
                  final isActive = _activeTab == key;
                  return GestureDetector(
                    onTap: () => setState(() => _activeTab = key),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: isActive ? Colors.blue[600] : Colors.transparent, borderRadius: BorderRadius.circular(6)),
                      child: Text(_snippets[key]['title'].split(' ')[0], style: TextStyle(color: isActive ? Colors.white : const Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), border: Border.all(color: Colors.blue.withOpacity(0.2)), borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [const Icon(Icons.code, color: Colors.blue), const SizedBox(width: 8), Text(activeData['title'], style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold))]),
                    const SizedBox(height: 12),
                    Text(t, style: const TextStyle(color: Color(0xFFCBD5E1), height: 1.5)),
                  ]),
                ),
                const SizedBox(height: 24),
                _buildCheckItem(memSafe, memSafeDesc),
                _buildCheckItem(thread, threadDesc),
              ]),
            ),
            SizedBox(width: isDesktop ? 40 : 0, height: isDesktop ? 0 : 40),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))], border: Border.all(color: const Color(0xFF334155))),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), border: Border(bottom: BorderSide(color: Color(0xFF334155)))),
                    child: Row(children: [
                      Row(children: [Colors.red, Colors.amber, Colors.green].map((c) => Container(margin: const EdgeInsets.only(right: 8), width: 12, height: 12, decoration: BoxDecoration(color: c.withOpacity(0.8), shape: BoxShape.circle))).toList()),
                      const Spacer(),
                      Text(_activeTab.toUpperCase(), style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, letterSpacing: 1.5)),
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Text(activeData['code'], style: const TextStyle(fontFamily: 'Courier', color: Color(0xFFE2E8F0), height: 1.6, fontSize: 13)),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.check_circle, size: 16, color: Colors.greenAccent)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12))])),
      ]),
    );
  }
}