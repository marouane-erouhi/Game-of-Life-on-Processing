//This class is resposible for all the UI components and there behaviour
public class UI {
  private ControlP5 cp5;
  private int buttonHight;
  private Textlabel fpsDisplay;

  //private Label 
  UI(processing.core.PApplet screen, int buttonHight) {
    this.buttonHight = buttonHight;
    cp5 = new ControlP5(screen);


    //bottom controll bar
    String[] fpsControll = {"-", "+"};
    cp5.addButtonBar("fpsControlls")
      .setPosition(width-50, height-buttonHight)
      .setSize(50, buttonHight)
      .addItems(fpsControll);
    //fps label
    fpsDisplay = cp5.addLabel("fpsLabel")
      .setPosition(width-35, height-(buttonHight/2))
      .setSize(50, 20)
      ;

    //bottom controll bar
    String[] bottomBarButtons = {"Play/Pause", "Clear"};
    cp5.addButtonBar("bottom-bar")
      .setPosition(0, height-buttonHight)
      .setSize(width-50, buttonHight)
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
          simulation.setCurrentShape("Point");
          break;
        case 1:
          simulation.setCurrentShape("Block");
          break;
        case 2:
          simulation.setCurrentShape("Beehive");
          break;
        case 3:
          simulation.setCurrentShape("Loaf");
          break;
        case 4:
          simulation.setCurrentShape("Boat");
          break;
        case 5:
          simulation.setCurrentShape("Tub");
          break;
        default:
          simulation.setCurrentShape("Point");
        }
      }//Still lives dropdown

      //Oscillators dropdown
      if (e.getController().getName().equals("Oscillators")) {
        switch(floor(e.getController().getValue())) {
        case 0:
          simulation.setCurrentShape("Blinker");
          break;
        case 1:
          simulation.setCurrentShape("Toad");
          break;
        case 2:
          simulation.setCurrentShape("Beacon");
          break;
        default:
          simulation.setCurrentShape("Point");
        }
      }    //Oscillators dropdown

      //Spaceships dropdown
      if (e.getController().getName().equals("Spaceships")) {
        switch(floor(e.getController().getValue())) {
        case 0:
          simulation.setCurrentShape("Glider");
          break;
        case 1:
          simulation.setCurrentShape("Lightweight spaceship");
          break;
        default:
          simulation.setCurrentShape("Point");
        }
      }    //Spaceships dropdown


      //bottom-bar logic
      if (e.getController().getName().equals("bottom-bar")) {
        switch(floor(e.getController().getValue())) {
        case 0://works
          simulation.togglePaused();
          break;
        case 1://clear
          for (int[] row : simulation.grid)
            Arrays.fill(row, 0);
          break;
        }
      }

      //fpsControlls
      if (e.getController().getName().equals("fpsControlls")) {
        switch(floor(e.getController().getValue())) {
        case 0://-
          simulation.changeFps(1);
          break;
        case 1://+
          simulation.changeFps(-1);
          break;
        }
      }


      print("control event from : "+e.getController().getName());
      println(", value : "+e.getController().getValue());
    }
  }

  void setButtonHight(int h) {
    this.buttonHight = h;
  }
  void setFpsDisplay(int f) {
    fpsDisplay.setText("" + f);
  }
}