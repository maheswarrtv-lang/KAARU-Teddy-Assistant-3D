import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(const KaaruApp());

class KaaruApp extends StatelessWidget {
  const KaaruApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'KAARU Teddy',
    theme: ThemeData.dark(useMaterial3: true),
    home: const TeddyHome(),
  );
}

class TeddyHome extends StatefulWidget {
  const TeddyHome({super.key});
  @override
  State<TeddyHome> createState() => _TeddyHomeState();
}

class _TeddyHomeState extends State<TeddyHome> with SingleTickerProviderStateMixin {
  late final AnimationController glow = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 1700))..repeat(reverse: true);
  final input = TextEditingController();
  final messages = <String>['வணக்கம்! நான் KAARU Teddy. என்ன உதவி வேண்டும்?'];

  @override
  void dispose() { glow.dispose(); input.dispose(); super.dispose(); }

  void send() {
    final value = input.text.trim();
    if (value.isEmpty) return;
    setState(() {
      messages.add('நீங்கள்: $value');
      messages.add('KAARU: AI இணைப்பு அமைத்த பிறகு பதில் தருவேன்.');
      input.clear();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFF080D25), Color(0xFF29134E), Color(0xFF080A18)])),
      child: SafeArea(child: Column(children: [
        const Padding(padding: EdgeInsets.all(18), child: Row(children: [
          Icon(Icons.auto_awesome, color: Color(0xFFFFD36E)),
          SizedBox(width: 10),
          Text('KAARU TEDDY', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, letterSpacing: 2)),
          Spacer(),
          Text('3D AI', style: TextStyle(color: Color(0xFFFFD36E))),
        ])),
        Expanded(flex: 6, child: AnimatedBuilder(
          animation: glow,
          builder: (_, __) => Stack(alignment: Alignment.center, children: [
            Container(width: 260 + glow.value*22, height: 260 + glow.value*22,
              decoration: BoxDecoration(shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: const Color(0xFF9A6BFF).withOpacity(.20 + glow.value*.16),
                  blurRadius: 55, spreadRadius: 16)])),
            const ModelViewer(src: 'assets/kaaru_teddy.glb', alt: '3D KAARU Teddy',
              autoRotate: true, cameraControls: true, disableZoom: true,
              backgroundColor: Colors.transparent, cameraOrbit: '0deg 75deg 3.4m'),
            Positioned(top: 24, right: 35, child: Icon(Icons.auto_awesome,
              color: Color.lerp(Colors.white, const Color(0xFFFFD36E), glow.value), size: 24)),
            const Positioned(bottom: 32, left: 34, child: Icon(Icons.star, color: Color(0xFFFFD36E), size: 18)),
          ]))),
        const Text('உங்கள் நண்பன் • உங்கள் AI உதவியாளர்',
          style: TextStyle(color: Color(0xFFD9CCFF))),
        const SizedBox(height: 12),
        Expanded(flex: 3, child: Container(
          margin: const EdgeInsets.fromLTRB(15,0,15,12), padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(color: Colors.white.withOpacity(.07),
            borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white12)),
          child: Column(children: [
            Expanded(child: ListView(children: messages.map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Align(alignment: Alignment.centerLeft, child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF7955C8).withOpacity(.28),
                  borderRadius: BorderRadius.circular(13)),
                child: Text(m, style: const TextStyle(fontSize: 13)))))).toList())),
            Row(children: [
              Expanded(child: TextField(controller: input, onSubmitted: (_) => send(),
                decoration: InputDecoration(hintText: 'தமிழில் கேளுங்கள்...',
                  filled: true, fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(26), borderSide: BorderSide.none)))),
              const SizedBox(width: 7),
              IconButton.filled(onPressed: send, icon: const Icon(Icons.send_rounded)),
            ]),
          ]))),
        const Padding(padding: EdgeInsets.only(bottom: 7),
          child: Text('3D preview • Backend / Voice இன்னும் இணைக்கப்படவில்லை',
            style: TextStyle(color: Colors.white54, fontSize: 10))),
      ]))),
  );
}
