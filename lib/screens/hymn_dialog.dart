import 'widget.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'models/discipleship_hymnary_model.dart';

class HymnDialog extends StatelessWidget {
  final double _iconSize = 30.0;
  final DiscipleshipHymnaryModel hymnaryModel;
  final double _height = 60.0;
  final double _fontSize = 14.0;

  const HymnDialog({Key? key, required this.hymnaryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          focusColor: Styles.defaultWhiteColor,
          tooltip: 'Back',
          icon: Icon(
            Icons.arrow_left,
            size: _iconSize,
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                '${hymnaryModel.id.toString()}. ${hymnaryModel.title}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _onShare(context);
            },
            iconSize: _iconSize,
            tooltip: 'Share',
          ),
        ],
      ),
      floatingActionButton: HymnTune(hymnMusicPath: hymnaryModel.hymnMusic),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        hymnaryModel.id.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Styles.defaultBlueColor,
                          fontSize: 40.0,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              hymnaryModel.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              hymnaryModel.bibleText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            hymnaryModel.key,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Styles.defaultBlueColor, thickness: 2),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text(
                      hymnaryModel.verses,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Text(
                              'Text: ${hymnaryModel.text}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Music: ${hymnaryModel.music}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          children: [
                            Text(
                              hymnaryModel.hymnTune,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              hymnaryModel.meter,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(hymnaryModel.verses,
        subject: hymnaryModel.title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
