import 'widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class SearchHymnaryDesktop extends SearchDelegate<DiscipleshipHymnaryModel> {
  final List<DiscipleshipHymnaryModel> allHymnsDesktop;
  final List<DiscipleshipHymnaryModel> allHymnsDesktopSuggestions;
  final double _fontSizeDesktop = 14.0;

  SearchHymnaryDesktop(this.allHymnsDesktop, this.allHymnsDesktopSuggestions);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
        tooltip: "Clear",
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.stop),
      onPressed: () {
        Navigator.pop(context);
      },
      tooltip: "Cancel Operation",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<DiscipleshipHymnaryModel> desktopHymns =
        allHymnsDesktop.where((desktopDiscipleshipHymnary) {
      return desktopDiscipleshipHymnary.title
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          desktopDiscipleshipHymnary.id
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: desktopHymns.length,
      itemBuilder: (context, desktopIndex) {
        final desktopHymnSearch = desktopHymns[desktopIndex];
        return HymnCard(
          fontSize: _fontSizeDesktop,
          hymns: desktopHymnSearch,
          onTap: (value) {},
          fromHome: false,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<DiscipleshipHymnaryModel> desktopHymnsSuggestion =
        allHymnsDesktopSuggestions
            .where((desktopDiscipleshipHymnarySuggestions) {
      return desktopDiscipleshipHymnarySuggestions.title
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          desktopDiscipleshipHymnarySuggestions.id
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: desktopHymnsSuggestion.length,
      itemBuilder: (context, desktopIndex) {
        final desktopHymnSearch = desktopHymnsSuggestion[desktopIndex];
        return HymnCard(
          fontSize: _fontSizeDesktop,
          onTap: (value) {},
          hymns: desktopHymnSearch,
          fromHome: false,
        );
      },
    );
  }
}
