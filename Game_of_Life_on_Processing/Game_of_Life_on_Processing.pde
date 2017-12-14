int grid[][];
int cols, rows, resolution = 5;
int fps = 60;

ControlPanel controlPanel;

int control_panel_height = 60;
void setup(){
  size(400,400);
  //fullScreen();
  controlPanel = new ControlPanel(); 

  cols = width / resolution;
  rows = (height) / resolution;
  
  grid = new int[cols][rows];
  for(int i=0; i<cols; i++){
    for(int j=0; j< rows; j++){
      grid[i][j] = floor(random(2));
    }
  }
}

void draw(){
  background(20);
  frameRate(fps);
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      int x = i * resolution;
      int y = j * resolution;
      
      if(grid[i][j] == 1){
        fill(255);
        stroke(0);
        rect(x,y,resolution-1, resolution-1);
      }
    }
  }
  
  int next[][] = new int[cols][rows];
  
  for(int i=0; i<cols; i++){
    for(int j=0; j< rows; j++){
      int state = grid[i][j];
      //cout neighbors
      int neighbors = countNeighbors(grid, i, j);
      
      if(state == 0 && neighbors == 3){
        next[i][j] = 1;
      }else if(state == 1 && (neighbors < 2 || neighbors > 3)){
        next[i][j] = 0;
      }else{
        next[i][j] = state;
      }
    }
  }
  
  grid = next;
  
  //top panel
  controlPanel.createButton(5,5,50,50);
  controlPanel.draw();
  
  
}

int countNeighbors(int[][] grid,int x, int y){
  int sum = 0;
  
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
      int col = (x + i + cols) % cols;
      int row = (y + j + rows) % rows;
      sum += grid[col][row];
    }
  }
  sum -= grid[x][y];
  return sum;
}

void mouseDragged(){
  changeCell();
}
void mousePressed(){
  changeCell();
}

void mouseClicked(){
  controlPanel.clicked();
}

void mouseWheel(MouseEvent e){
  float event = e.getCount();
  if(fps <= 1){
    fps++;
  }else{
    fps += -event;
  }
}

void changeCell(){
  int x = floor(mouseX / resolution);
  int y = floor((mouseY) / resolution);
  
  drawPoint(x,y);
}

//SHAPES
void drawPoint(int x,int y){
  grid[x][y] = (grid[x][y] == 1) ? 0 : 1;
}
//start from top left cell
void drawBlock(int x, int y){
  grid[x][y] = 1;
  grid[x+1][y] = 1;
  grid[x][y+1] = 1;
  grid[x+1][y+1] = 1;
}
void drawBeehive(int x, int y){
  grid[x+1][y] = 1;
  grid[x+2][y] = 1;
  
  grid[x+1][y+2] = 1;
  grid[x+2][y+2] = 1;
  
  grid[x][y+1] = 1;
  grid[x+3][y+1] = 1;
}
void drawBlinker(int x, int y){
  grid[x][y] = 1;
  grid[x+1][y] = 1;
  grid[x+2][y] = 1;
}
void drawToad(int x, int y){
  drawBlinker(x+1,y);
  drawBlinker(x,y+1);
}
void drawBeacon(int x, int y){
  drawBlock(x,y);
  drawBlock(x+2,y+2);
}