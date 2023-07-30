import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/providers/theme.dart';
import '/providers/stage.dart';
import '/providers/auth.dart';
import 'pages/auth_page.dart';
import 'ios_bottom_navbar.dart';

class IOSMain extends StatefulWidget {
  const IOSMain({super.key});

  @override
  State<IOSMain> createState() => _IOSMainState();
}

class _IOSMainState extends State<IOSMain> {
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Auth>(context, listen: false).checkAuth().then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeDark = Provider.of<ThemeManager>(context).themeMode;
    final stage = Provider.of<StageManger>(context).stage;
    final theme = CupertinoThemeData(
      brightness: themeDark ? Brightness.dark : Brightness.light,
      textTheme: CupertinoTextThemeData(
        textStyle: GoogleFonts.inter(color: const Color(0xff1f1f1f)),
      ),
    );
    const String title = "Kids Zone";

    return CupertinoApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: stage == 'app'
          ? (_isLoading
              ? const CupertinoPageScaffold(
                  child: SafeArea(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 18,
                      ),
                    ),
                  ),
                )
              : const IOSBottonNavbar())
          : const AuthPage(),
      theme: theme,
    );
  }
}
