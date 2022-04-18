import 'package:flutter/material.dart';
import 'package:flutter_sample_fonts/gen/fonts.gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 選択中のフォントファミリー
  String _selectedFontFamily = 'Roboto';

  void changeFontFamily(String fontFamily) {
    setState(() {
      _selectedFontFamily = fontFamily;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: _selectedFontFamily,
    );
    return MaterialApp(
      title: 'Flutter Sample Fonts',
      theme: themeData,
      home: SamplePage(
        fontFamily: _selectedFontFamily,
        onChangeFontFamily: changeFontFamily,
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

  final String fontFamily;
  final void Function(String) onChangeFontFamily;

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).textTheme.bodyText1?.fontFamily);
    return Scaffold(
      appBar: AppBar(
        title: Text(fontFamily),
        actions: [
          _ActionIcon(
            icon: Icons.font_download,
            onTap: () async {
              final selected = await showDialog<String>(
                context: context,
                builder: (context) {
                  return _FontFamilyPickerDialog(
                    fontFamily: fontFamily,
                  );
                },
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

class _FontFamilyPickerDialog extends StatelessWidget {
  const _FontFamilyPickerDialog({
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
    return AlertDialog(
      content: SizedBox(
        width: 500,
        height: fontFamilies.length * 55,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: fontFamilies.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Visibility(
                visible: fontFamilies[index] == fontFamily,
                child: const Icon(Icons.check),
              ),
              title: Text(
                fontFamilies[index],
                style: TextStyle(
                  fontFamily: fontFamilies[index],
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(fontFamilies[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
