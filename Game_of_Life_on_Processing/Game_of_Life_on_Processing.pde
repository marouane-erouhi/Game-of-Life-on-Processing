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

ControlP5 cp5;
ButtonBar topBar, bottomBar;

int buttonHight = 20;

void setup() {
  size(400, 400);
  //fullScreen();



  //UI *********************

  cp5 = new ControlP5(this);
  //String[] topBarButtons = {"Point", "Block", "Beehive", "Blinker", "Toad", "Beacon"};
  //topBar = cp5.addButtonBar("top-bar")
  //  .setPosition(0, 0)
  //  .setSize(width, buttonHight)
  //  .addItems(topBarButtons);

  String[] bottomBarButtons = {"Play/Pause", "Toggle Top-Bar"};
  bottomBar = cp5.addButtonBar("bottom-bar")
    .setPosition(0, height-buttonHight)
    .setSize(width-100, buttonHight)
    .addItems(bottomBarButtons);


  List stillLivesList = Arrays.asList("Point", "Block", "Beehive");
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Still lives")
    .setPosition(0, 0)
    .setSize(width/3, 100)
    .setBarHeight(buttonHight)
    .setItemHeight(buttonHight)
    .addItems(stillLivesList)
    .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  List oscillatorsList = Arrays.asList("Blinker", "Toad", "Beacon");
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Oscillators")
    .setPosition(width/3, 0)
    .setSize(width/3, 100)
    .setBarHeight(buttonHight)
    .setItemHeight(buttonHight)
    .addItems(oscillatorsList)
    .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  List spaceshipsList = Arrays.asList("Glider");
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("Spaceships")
    .setPosition(width/3*2, 0)
    .setSize(width/3, 100)
    .setBarHeight(buttonHight)
    .setItemHeight(buttonHight)
    .addItems(spaceshipsList)
    .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  //UI *********************


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
  if (e.isController()) {
    println(currentShape);
    //Still lives dropdown
    if (e.getController().getName().equals("Still lives")) {
      switch(floor(e.getController().getValue())) {
      case 0:
        currentShape = "Point";
        break;
      case 1:
        currentShape = "Block";
        break;
      case 2:
        currentShape = "Beehive";
        break;
      case 3:
        currentShape = "Blinker";
        break;
      case 4:
        currentShape = "Toad";
        break;
      case 5:
        currentShape = "Beacon";
        break;
      default:
        currentShape = "Point";
      }
    }//Still lives dropdown

    //Oscillators dropdown
    if (e.getController().getName().equals("Oscillators")) {
      switch(floor(e.getController().getValue())) {
      case 0:
        currentShape = "Blinker";
        break;
      case 1:
        currentShape = "Toad";
        break;
      case 2:
        currentShape = "Beacon";
        break;
      default:
        currentShape = "Point";
      }
    }    //Oscillators dropdown
    
    //Spaceships dropdown
    if (e.getController().getName().equals("Spaceships")) {
      switch(floor(e.getController().getValue())) {
      case 0:
        currentShape = "Glider";
        break;
      default:
        currentShape = "Point";
      }
    }    //Spaceships dropdown


    //bottom-bar logic
    if (e.getController().getName().equals("bottom-bar")) {
      switch(floor(e.getController().getValue())) {
      case 0:
        paused = !paused;
        break;
      case 1:
        if (topBarOpen) {
          topBarOpen = false;
          topBar.setPosition(0, -buttonHight);
        } else {
          topBar.setPosition(0, 0);
          topBarOpen = true;
        }
      }
    }


    print("control event from : "+e.getController().getName());
    println(", value : "+e.getController().getValue());
  }
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

void mouseDragged() {
  changeCell();
}
void mousePressed() {
  changeCell();
}

void mouseClicked() {//also in ControlPanel
  int x = floor(mouseX / resolution);
  int y = floor((mouseY) / resolution);
  //clickedButton = controlPanel.clicked();
  //currentShape = (clickedButton != "") ? clickedButton : "drawPoint";
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
    }
  }
  catch(Exception e) {
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
  grid[x][y] = 1;
  grid[x+1][y] = 1;
  grid[x+2][y] = 1;
}
void drawToad(int x, int y) {
  drawBlinker(x+1, y);
  drawBlinker(x, y+1);
}
void drawBeacon(int x, int y) {
  drawBlock(x, y);
  drawBlock(x+2, y+2);
}
void drawLoaf(int x, int y){//redo
  grid[x+1][y] = 1;
  drawPoint(x+2,y);
  drawPoint(x,y+1);
  drawPoint(x+3,y+1);
  drawPoint(x+1,y+2);
  drawPoint(x+3,y+2);
  drawPoint(x+2,y+3);
}

void drawBoat(int x, int y){//redo
  drawBlock(x,y);
  grid[x+1][y+1] = 0;
  
}

void drawTub(int x, int y){
  grid[x+1][y] = 1;
  grid[x][y+1] = 1;
  
}