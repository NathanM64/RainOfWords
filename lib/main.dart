import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rainofwords/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  GameController gameController = GameController();
  runApp(gameController.widget);
}
