import controlP5.*;
import java.util.*;

final int resolution = 5;
final int fps = 30;
final int buttonHight = 20;

Simulation simulation;
UI ui;

void setup() {
  size(400, 400);
  //fullScreen();
  simulation = new Simulation(resolution, fps);
  ui = new UI(this, buttonHight);
}

void draw() {
  background(20);
  frameRate(simulation.getFps());

  simulation.show();
  simulation.update();
  
  ui.setFpsDisplay(simulation.getFps());
}

void controlEvent(ControlEvent e) {
  ui.handdleEvents(e);
}

void mousePressed() {
  simulation.changeCell();
}
void mouseWheel(MouseEvent e) {
  float event = e.getCount();
  simulation.changeFps(event);
}
void keyReleased() {
  switch(keyCode){
    case 32://pause when space is pressed
      simulation.togglePaused();
      break;
  }
}