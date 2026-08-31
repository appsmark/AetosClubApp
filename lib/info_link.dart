import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'data_info.dart';
import 'sizes.dart';

class DocView extends StatefulWidget {
  const DocView({super.key, required this.url});

  final String url;

  @override
  State<DocView> createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  Future<void> _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ongeldige link')));
      }
      return;
    }

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('De link kon niet worden geopend')),
        );
      }
      return;
    }

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchURL(widget.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class InfoLink extends StatefulWidget {
  const InfoLink({super.key, required this.file, required this.title});
  final String file;
  final String title;

  @override
  State<InfoLink> createState() => _InfoLinkState();
}

class _InfoLinkState extends State<InfoLink> {
  DataInfo dataInfo = DataInfo.instance;
  Sizes sizes = Sizes.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: Constants().colorBackground,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Constants().colorAetosAmber,
            fontSize: sizes.sizeFontTitle,
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Constants().colorAetosBlue,
            size: 0.04 * sizes.screenHeight,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Constants().colorAetosAmber,
        child: DocView(url: widget.file),
      ),
    );
  }
}
