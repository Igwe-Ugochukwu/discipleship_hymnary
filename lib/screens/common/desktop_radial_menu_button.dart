import 'dart:math';
import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:discipleship_hymnary/screens/widget.dart';
import 'package:discipleship_hymnary/screens/models/models.dart';
import 'package:vector_math/vector_math.dart' show radians;

class DesktopHymnRadialMenu extends StatefulWidget {
  final DiscipleshipHymnaryModel hymnaryModel;

  const DesktopHymnRadialMenu({super.key, required this.hymnaryModel});

  @override
  State<DesktopHymnRadialMenu> createState() => _DesktopHymnRadialMenuState();
}

class _DesktopHymnRadialMenuState extends State<DesktopHymnRadialMenu> with SingleTickerProviderStateMixin {
  late AnimationController desktopRadialController;

  @override
  void initState(){
    super.initState();
    desktopRadialController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(
      controller: desktopRadialController,
      hymnaryModel: widget.hymnaryModel,
    );
  }
}

class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final DiscipleshipHymnaryModel hymnaryModel;


  RadialAnimation({Key? key, required this.controller, required this.hymnaryModel}) :
    scale = Tween<double>(
      begin: 1,
      end: 0.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn
      ),
    ),
    translation = Tween<double>(
      begin: 0.0,
      end: 100.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    ),
  super(key: key);

  _open(){
    controller.forward();
  }

  _close(){
    controller.reverse();
  }

  _buildAnimationDesktopButton(double angle, Widget childWidget){
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()..translate(
        (translation.value)*cos(rad),
        (translation.value)*sin(rad)
      ),
      child: childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder){
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            _buildAnimationDesktopButton(
              180,
              HymnTune(hymnMusicPath: hymnaryModel.hymnMusic,)
            ),
            _buildAnimationDesktopButton(
              225,
              FloatingActionButton(
                onPressed: (){_onShare(context);},
                elevation: 10,
                backgroundColor: Styles.defaultBlueColor,
                foregroundColor: Colors.white,
                tooltip: "Share Hymn",
                child: const Icon(
                  Icons.share,
                  size: 14,
                ),
              ),
            ),
            Transform.scale(
              scale: scale.value - 1,
              child: FloatingActionButton(
                onPressed: _close,
                elevation: 10,
                backgroundColor: Styles.defaultBlueColor,
                foregroundColor: Colors.white,
                tooltip: "Close Options",
                child: const Icon(Icons.close),
              ),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                onPressed: _open,
                elevation: 10,
                backgroundColor: Styles.defaultBlueColor,
                foregroundColor: Colors.white,
                tooltip: "Open more options",
                child: const Icon(Icons.more_vert),
              ),
            )
          ],
        );
      }
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      hymnaryModel.verses,
      subject: hymnaryModel.title,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    );
  }
}