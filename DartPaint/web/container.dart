library paint;

import 'dart:core';

part 'action.dart';
part 'draw_context.dart';
part 'surface.dart';

class Container {
  Container();
  
  List<Action> actions;
  DrawContext context;
  
  void drawSurface(Surface surface) {
    actions.forEach((e) => e.perform(surface, context));
  }
  
  undo() => actions.removeLast();
}