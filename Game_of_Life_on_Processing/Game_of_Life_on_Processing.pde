import controlP5.*;
import java.util.*;
/*
TODO:
 resize the grid to not calculate for cells behind the tool bars
 */

int grid[][];
int cols, rows, resolution = 5;

boolean paused = false;
boolean topBarOpen = true;

int fps = 60;
String currentShape = "Point";

//ControlP5 cp5;
//ButtonBar bottomBar;
UI ui;

int buttonHight = 20;

void setup() {
  size(400, 400);
  //fullScreen();

  ui = new UI(this);

  cols = width / resolution;
  rows = (height) / resolution;

  grid = new int[cols][rows];
  for (int i=0; i<cols; i++) {
    for (int j=0; j< rows; j++) {
      grid[i][j] = floor(random(2));
    }
  }
}

void draw() {
  background(20);
  frameRate(fps);


  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      int x = i * resolution;
      int y = j * resolution;

      if (grid[i][j] == 1) {
        fill(255);
        stroke(0);
        rect(x, y, resolution-1, resolution-1);
      }
    }
  }

  if (!paused) {
    int next[][] = new int[cols][rows];

    for (int i=0; i<cols; i++) {
      for (int j=0; j< rows; j++) {
        int state = grid[i][j];
        //cout neighbors
        int neighbors = countNeighbors(grid, i, j);

        if (state == 0 && neighbors == 3) {
          next[i][j] = 1;
        } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
          next[i][j] = 0;
        } else {
          next[i][j] = state;
        }
      }
    }
    grid = next;
  }
}

void controlEvent(ControlEvent e) {
  ui.handdleEvents(e);
}

int countNeighbors(int[][] grid, int x, int y) {
  int sum = 0;

  for (int i=-1; i<2; i++) {
    for (int j=-1; j<2; j++) {
      int col = (x + i + cols) % cols;
      int row = (y + j + rows) % rows;
      sum += grid[col][row];
    }
  }
  sum -= grid[x][y];
  return sum;
}

void mousePressed() {
    changeCell();
}
void mouseWheel(MouseEvent e) {
  float event = e.getCount();
  if (fps <= 1) {
    fps++;
  } else {
    fps += -event;
  }
}

void changeCell() {
  int x = floor(mouseX / resolution);
  int y = floor((mouseY) / resolution);

  try {
    switch(currentShape) {
      //drawBlinker drawToad drawBeacon
    case "Point":
      drawPoint(x, y);
      break;
    case "Block":
      drawBlock(x, y);
      break;
    case "Beehive":
      drawBeehive(x, y);
      break;
    case "Blinker":
      drawBlinker(x, y);
      break;
    case "Toad":
      drawToad(x, y);
      break;
    case "Beacon":
      drawBeacon(x, y);
      break;
    case "Loaf":
      drawLoaf(x,y);
      break;
    case "Boat":
      drawBoat(x,y);
      break;
    case "Tub":
      drawTub(x,y);
      break;
    case "Glider":
      drawGlider(x,y);
      break;
    case "Lightweight spaceship":
      drawLightweightSpaceship(x,y);
      break;
    }
  }
  catch(Exception e) {//edges cause an out of bounds for larger objects
  }
}

//SHAPES
void drawPoint(int x, int y) {
  grid[x][y] = (grid[x][y] == 1) ? 0 : 1;
}
//start from top left cell
void drawBlock(int x, int y) {
  grid[x][y] = 1;
  grid[x+1][y] = 1;
  grid[x][y+1] = 1;
  grid[x+1][y+1] = 1;
}
void drawBeehive(int x, int y) {
  grid[x+1][y] = 1;
  grid[x+2][y] = 1;

  grid[x+1][y+2] = 1;
  grid[x+2][y+2] = 1;

  grid[x][y+1] = 1;
  grid[x+3][y+1] = 1;
}
void drawBlinker(int x, int y) {
  grid[x-1][y] = 1;
  grid[x][y] = 1;
  grid[x+1][y] = 1;
}
void drawToad(int x, int y) {
  drawBlinker(x+1, y);
  drawBlinker(x, y+1);
}
void drawBeacon(int x, int y) {
  drawBlock(x, y);
  drawBlock(x+2, y+2);
}
void drawLoaf(int x, int y){
  grid[x+1][y] = 1;
  grid[x+2][y] = 1;
  grid[x][y+1] = 1;
  grid[x+3][y+1] = 1;
  grid[x+1][y+2] = 1;
  grid[x+3][y+2] = 1;
  grid[x+2][y+3] = 1;
}

void drawBoat(int x, int y){
  drawBlock(x,y);
  grid[x+1][y+1] = 0;
  grid[x+2][y+1] = 1;
  grid[x+1][y+2] = 1;
}

void drawTub(int x, int y){
  drawBoat(x,y);
  grid[x][y] = 0;
}

void drawGlider(int x, int y){
  drawBlock(x+1,y+1);
  grid[x+1][y+1] = 0;
  grid[x][y+1] = 1;
  grid[x+2][y] = 1;
}

void drawLightweightSpaceship(int x, int y){
  grid[x+1][y] = 1;
  grid[x][y+1] = 1;
  grid[x+4][y] = 1;
  grid[x+4][y+2] = 1;
  
  drawBlock(x,y+2);
  grid[x+1][y+2] = 0;
  
  grid[x+2][y+3] = 1;
  grid[x+3][y+3] = 1;
}