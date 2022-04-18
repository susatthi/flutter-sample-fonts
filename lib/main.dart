import 'package:flutter/material.dart';
import 'package:flutter_sample_fonts/gen/fonts.gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fontFamily = FontFamily.notoSansJapanese;
    final themeData = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: fontFamily,
    );
    return MaterialApp(
      title: 'Flutter Sample Fonts',
      theme: themeData,
      home: const SamplePage(title: fontFamily),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _PreviewTextRow(
              title: 'Thin (Font Weight w100)',
              fontWeight: FontWeight.w100,
            ),
            _PreviewTextRow(
              title: 'Normal (Font Weight w400)',
              fontWeight: FontWeight.normal,
            ),
            _PreviewTextRow(
              title: 'Bold (Font Weight w700)',
              fontWeight: FontWeight.bold,
            ),
            _PreviewTextRow(
              title: 'Italic',
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewTextRow extends StatelessWidget {
  const _PreviewTextRow({
    Key? key,
    required this.title,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
  }) : super(key: key);

  final String title;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  static const previewText =
      '彼らの機器や装置はすべて生命体だ。ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz木林山川土空田天生花草虫犬人名女男子目耳口手足見音力気円入来行帰歩走止活店買売午汽弓回会組船明社切電毎合当台楽公引科歌刀番用何1234567890‘?’“!”(%)[#]{@}/&<-+÷×=>®©€£¥¢:;,.*';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            previewText,
            style: TextStyle(
              fontWeight: fontWeight,
              fontStyle: fontStyle,
            ),
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
