
class Simulation {

  private int[][] grid;
  private int[][] nextGen;

  private int cols, rows, resolution;
  private boolean paused = false;

  private String currentShape = "Point";

  private int fps = 30;

  public Simulation(int resolution, int fps) {
    this.resolution = resolution;
    this.fps = fps;

    cols = width / resolution;
    rows = height / resolution;

    grid = new int[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j< rows; j++) {
        grid[i][j] = floor(random(2));
      }
    }
  }

  public void show() {
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
  }

  public void update() {

    if (paused) return;
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

  void togglePaused() {
    paused = !paused;
  }

  String getCurrentShape() {
    return currentShape;
  }
  void setCurrentShape(String shape) {
    this.currentShape = shape;
  }
  int getFps() {
    return fps;
  }
  int[][] getGrid() {
    return this.grid;
  }
  void changeFps(float n) {
    if (n<=0)  this.fps++;
    else 
    if (this.fps <= 1)  fps++;
    else                fps--;
  }

  void changeCell() {
    int x = floor(mouseX / resolution);
    int y = floor((mouseY) / resolution);

    try {
      switch(simulation.getCurrentShape()) {
        //drawBlinker drawToad drawBeacon
      case "Point":
        GridShapes.drawPoint(x, y, grid);
        break;
      case "Block":
        GridShapes.drawBlock(x, y, grid);
        break;
      case "Beehive":
        GridShapes.drawBeehive(x, y, grid);
        break;
      case "Blinker":
        GridShapes.drawBlinker(x, y, grid);
        break;
      case "Toad":
        GridShapes.drawToad(x, y, grid);
        break;
      case "Beacon":
        GridShapes.drawBeacon(x, y, grid);
        break;
      case "Loaf":
        GridShapes.drawLoaf(x, y, grid);
        break;
      case "Boat":
        GridShapes.drawBoat(x, y, grid);
        break;
      case "Tub":
        GridShapes.drawTub(x, y, grid);
        break;
      case "Glider":
        GridShapes.drawGlider(x, y, grid);
        break;
      case "Lightweight spaceship":
        GridShapes.drawLightweightSpaceship(x, y, grid);
        break;
      }
    }
    catch(Exception e) {//edges cause an out of bounds for larger objects
    }
  }
}