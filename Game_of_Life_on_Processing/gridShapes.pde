//This class holdes all the shapes that can be drawn on a standard grid
public static class GridShapes {
  static void drawPoint(int x, int y, int[][]grid) {
    grid[x][y] = (grid[x][y] == 1) ? 0 : 1;
  }
  //start from top left cell
  static void drawBlock(int x, int y, int[][]grid) {
    grid[x][y] = 1;
    grid[x+1][y] = 1;
    grid[x][y+1] = 1;
    grid[x+1][y+1] = 1;
  }
  static void drawBeehive(int x, int y, int[][]grid) {
    grid[x+1][y] = 1;
    grid[x+2][y] = 1;

    grid[x+1][y+2] = 1;
    grid[x+2][y+2] = 1;

    grid[x][y+1] = 1;
    grid[x+3][y+1] = 1;
  }
  static void drawBlinker(int x, int y, int[][]grid) {
    grid[x-1][y] = 1;
    grid[x][y] = 1;
    grid[x+1][y] = 1;
  }
  static void drawToad(int x, int y, int[][]grid) {
    drawBlinker(x+1, y,grid);
    drawBlinker(x, y+1,grid);
  }
  static void drawBeacon(int x, int y, int[][]grid) {
    drawBlock(x, y,grid);
    drawBlock(x+2, y+2,grid);
  }
  static void drawLoaf(int x, int y, int[][]grid) {
    grid[x+1][y] = 1;
    grid[x+2][y] = 1;
    grid[x][y+1] = 1;
    grid[x+3][y+1] = 1;
    grid[x+1][y+2] = 1;
    grid[x+3][y+2] = 1;
    grid[x+2][y+3] = 1;
  }

  static void drawBoat(int x, int y, int[][]grid) {
    drawBlock(x, y,grid);
    grid[x+1][y+1] = 0;
    grid[x+2][y+1] = 1;
    grid[x+1][y+2] = 1;
  }

  static void drawTub(int x, int y, int[][]grid) {
    drawBoat(x, y,grid);
    grid[x][y] = 0;
  }

  static void drawGlider(int x, int y, int[][]grid) {
    drawBlock(x+1, y+1,grid);
    grid[x+1][y+1] = 0;
    grid[x][y+1] = 1;
    grid[x+2][y] = 1;
  }

  static void drawLightweightSpaceship(int x, int y, int[][]grid) {
    grid[x+1][y] = 1;
    grid[x][y+1] = 1;
    grid[x+4][y] = 1;
    grid[x+4][y+2] = 1;

    drawBlock(x, y+2,grid);
    grid[x+1][y+2] = 0;

    grid[x+2][y+3] = 1;
    grid[x+3][y+3] = 1;
  }
}