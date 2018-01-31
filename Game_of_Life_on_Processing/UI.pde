//This class is resposible for all the UI components and there behaviour
public class UI {
  private ControlP5 cp5;
  private ButtonBar bottomBar;
  private int buttonHight;

  UI(processing.core.PApplet screen, int buttonHight) {
    this.buttonHight = buttonHight;
    cp5 = new ControlP5(screen);

    //bottom controll bar
    String[] bottomBarButtons = {"Play/Pause", "Clear"};
    bottomBar = cp5.addButtonBar("bottom-bar")
      .setPosition(0, height-buttonHight)
      .setSize(width, buttonHight)
      .addItems(bottomBarButtons);

    //still lives dropdown button
    String[] stillLivesList = {"Point", "Block", "Beehive", "Loaf", "Boat", "Tub"};
    cp5.addScrollableList("Still lives")
      .setPosition(0, 0)
      .setSize(width/3, 100)
      .setBarHeight(buttonHight)
      .setItemHeight(buttonHight)
      .addItems(stillLivesList)
      .setType(ScrollableList.LIST)
      .setOpen(false)
      ;

    //oscillators dropdown button
    String[] oscillatorsList = {"Blinker", "Toad", "Beacon", "Pulsar", "Pentadecathlon"};
    cp5.addScrollableList("Oscillators")
      .setPosition(width/3, 0)
      .setSize(width/3, 100)
      .setBarHeight(buttonHight)
      .setItemHeight(buttonHight)
      .addItems(oscillatorsList)
      .setType(ScrollableList.LIST)
      .setOpen(false)  
      ;

    //spaceships dropdown button
    String[] spaceshipsList = {"Glider", "Lightweight spaceship"};
    cp5.addScrollableList("Spaceships")
      .setPosition(width/3*2, 0)
      .setSize(width/3, 100)
      .setBarHeight(buttonHight)
      .setItemHeight(buttonHight)
      .addItems(spaceshipsList)
      .setType(ScrollableList.LIST)
      .setOpen(false)  
      ;
  }

  void handdleEvents(ControlEvent e) {
    if (e.isController()) {
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
          currentShape = "Loaf";
          break;
        case 4:
          currentShape = "Boat";
          break;
        case 5:
          currentShape = "Tub";
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
        case 1:
          currentShape = "Lightweight spaceship";
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
        case 1://clear
          for (int[] row : grid)
            Arrays.fill(row, 0);
          break;
        }
      }


      print("control event from : "+e.getController().getName());
      println(", value : "+e.getController().getValue());
    }
  }

  void getButtonHight(int h) {
    this.buttonHight = h;
  }
}