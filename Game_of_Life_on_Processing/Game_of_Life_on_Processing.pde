int grid[][];
int cols, rows, resolution = 5;
int fps = 60;
void setup(){
  //size(600,600);
  fullScreen();
  
  fill(255);
  stroke(0);

  cols = width / resolution;
  rows = height / resolution;
  
  grid = new int[cols][rows];
  for(int i=0; i<cols; i++){
    for(int j=0; j< rows; j++){
      grid[i][j] = floor(random(2));
    }
  }
}

void draw(){
  background(0);
  frameRate(fps);
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      int x = i * resolution;
      int y = j * resolution;
      
      if(grid[i][j] == 1){
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
  int i = floor(mouseX / resolution);
  int j = floor(mouseY / resolution);
  grid[i][j] = (grid[i][j] == 1) ? 0 : 1;
}

void mousePressed(){
  int i = floor(mouseX / resolution);
  int j = floor(mouseY / resolution);
  grid[i][j] = (grid[i][j] == 1) ? 0 : 1;
}

void mouseWheel(MouseEvent e){
  float event = e.getCount();
  if(fps <= 1){
    fps++;
  }else{
    fps += -event;
  }
}