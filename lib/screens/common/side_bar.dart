import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:discipleship_hymnary/screens/widget.dart';

class DiscipleshipSideBar extends StatefulWidget {
  const DiscipleshipSideBar({super.key});

  @override
  State<DiscipleshipSideBar> createState() => _DiscipleshipSideBarState();
}

class _DiscipleshipSideBarState extends State<DiscipleshipSideBar> {
  @override
  Widget build(BuildContext context) {
    double drawerIconSize = 24;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Styles.defaultBlueColor.withOpacity(0.2),
              Colors.white.withOpacity(0.5),],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [Styles.defaultBlueColor, Colors.black45],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage("assets/images/piano.jpeg",),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'discipleship hymnary'.toUpperCase(),
                    style: const TextStyle(fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined, size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text('home'.toUpperCase(), style: const TextStyle(fontSize: 17, color: Styles.defaultBlueColor),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscipleshipHymnaryHome()));},
            ),
            ListTile(
              leading: Icon(Icons.info_outline, size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text('preface'.toUpperCase(), style: const TextStyle(fontSize: 17, color: Styles.defaultBlueColor),),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PrefaceScreen()));},
            ),
            ListTile(
              leading: Icon(Icons.perm_device_information_outlined, size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text('about'.toUpperCase(), style: const TextStyle(fontSize: 17, color: Styles.defaultBlueColor),),
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny_outlined, size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text('dark theme'.toUpperCase(), style: const TextStyle(fontSize: 17, color: Styles.defaultBlueColor),),
              trailing: Switch(
                value: themeChange.darkTheme,
                onChanged: (value){
                  setState((){
                    themeChange.darkTheme = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}