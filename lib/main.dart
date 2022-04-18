import 'package:flutter/material.dart';
import 'package:flutter_sample_fonts/gen/fonts.gen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// 選択中のフォントファミリー
  String _selectedFontFamily = 'Roboto';

  void _changeFontFamily(String fontFamily) {
    setState(() {
      _selectedFontFamily = fontFamily;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample Fonts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: _selectedFontFamily,
      ),
      home: SamplePage(
        fontFamily: _selectedFontFamily,
        onChangeFontFamily: _changeFontFamily,
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({
    Key? key,
    required this.fontFamily,
    required this.onChangeFontFamily,
  }) : super(key: key);

  /// 選択中のフォントファミリー
  final String fontFamily;

  /// 選択中のフォントファミリーを変更した
  final void Function(String) onChangeFontFamily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fontFamily),
        actions: [
          _ActionIcon(
            icon: Icons.font_download,
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) => _FontFamilySelectorDialog(
                  fontFamily: fontFamily,
                ),
              );
              if (selected != null) {
                onChangeFontFamily(selected);
              }
            },
          ),
        ],
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

  /// タイトル
  final String title;

  /// ウェイト
  final FontWeight fontWeight;

  /// スタイル
  final FontStyle fontStyle;

  /// プレビュー文字列
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

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    Key? key,
    required this.icon,
    this.size = 50.0,
    this.iconSize = 25.0,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(
              icon,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _FontFamilySelectorDialog extends StatelessWidget {
  const _FontFamilySelectorDialog({
    Key? key,
    required this.fontFamily,
  }) : super(key: key);

  final String fontFamily;

  /// フォントファミリー一覧
  static const fontFamilies = [
    'Roboto',
    FontFamily.notoSansJapanese,
    FontFamily.mPLUSRounded1c,
  ];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: fontFamilies
          .map(
            (ff) => ListTile(
              leading: Visibility(
                visible: ff == fontFamily,
                child: const Icon(Icons.check),
              ),
              title: Text(
                ff,
                style: TextStyle(
                  fontFamily: ff,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(ff);
              },
            ),
          )
          .toList(),
    );
  }
}
