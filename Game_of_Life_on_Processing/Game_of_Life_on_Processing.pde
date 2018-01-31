import controlP5.*;
import java.util.*;

int resolution = 5;

int fps = 30;

Simulation simulation;

UI ui;
int buttonHight = 20;

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