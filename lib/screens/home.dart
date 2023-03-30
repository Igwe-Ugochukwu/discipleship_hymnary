import 'models/models.dart';
import 'dart:convert';
import 'widget.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';

class DiscipleshipHymnaryHome extends StatefulWidget {
  const DiscipleshipHymnaryHome({super.key});

  @override
  State<DiscipleshipHymnaryHome> createState() =>
      _DiscipleshipHymnaryHomeState();
}

class _DiscipleshipHymnaryHomeState extends State<DiscipleshipHymnaryHome> {
  final double _fontSize = 14.0;
  final double _height = 60.0;
  late Future<List<DiscipleshipHymnaryModel>> hymnFuture;
  List<DiscipleshipHymnaryModel>? selectHymn;
  String? selectedHymn;

  @override
  void initState() {
    super.initState();
    hymnFuture = readJsonData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/piano.jpeg'),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                'discipleship hymnary'.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              iconSize: 20.0,
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: SearchHymnary(
                      allHymns: selectHymn!, allHymnsSuggestion: selectHymn!),
                );
              },
              tooltip: 'Search hymnary'),
        ],
      ),
      drawer: const DiscipleshipSideBar(),
      body: FutureBuilder(
          future: readJsonData(context),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text('${data.error}'));
            } else if (data.hasData) {
              var hymnItems = data.data as List<DiscipleshipHymnaryModel>;
              selectHymn = hymnItems.toList();
              return ListView.builder(
                  itemCount: hymnItems.length,
                  itemBuilder: (context, index) {
                    final hymns = hymnItems[index];
                    return selectedHymn == ""
                        ? Container()
                        : HymnCard(hymns: hymns, fontSize: _fontSize);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          }),
    );
  }

  Future<List<DiscipleshipHymnaryModel>> readJsonData(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data =
        await assetBundle.loadString('assets/json/discipleship_hymnary.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => DiscipleshipHymnaryModel.fromJson(e)).toList();
  }
}

class HymnCard extends StatelessWidget {
  const HymnCard({
    super.key,
    required this.hymns,
    required double fontSize,
  }) : _fontSize = fontSize;

  final DiscipleshipHymnaryModel hymns;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HymnDialog(hymnaryModel: hymns)));
      },
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Styles.defaultBlueColor,
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            child: Text(
              hymns.id.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(
            hymns.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Styles.defaultBlueColor,
              fontSize: 15.0,
            ),
          ),
          subtitle: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              hymns.verses,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _fontSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
