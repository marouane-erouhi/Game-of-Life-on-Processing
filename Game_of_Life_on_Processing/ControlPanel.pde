

class ControlPanel{
  int thickness;
  int defaultThickness = 60;
  PVector pos;
  boolean panelOpen = true;
  
  ArrayList<Button> buttons;
  
  Button openClose;
  
  ControlPanel(){
    this.thickness = 60;
    pos = new PVector(0,0);
    buttons = new ArrayList<Button>();
    openClose = new Button(width-20, 0, 20, 10, "togglePanel");
    
  }
  ControlPanel(int x, int y, int thickness){
    pos = new PVector(x,y);
    this.thickness = thickness;
    this.defaultThickness = thickness;
    buttons = new ArrayList<Button>();
  }
  
  void draw(){
    fill(200);
    rect(this.pos.x,this.pos.y,width, thickness);
    
    openClose.draw();//close button, always drawn
    
    //draw buttons
    if(panelOpen){
      for(Button btn : this.buttons){
        btn.draw();
      }
    }
    
    
  }
  //5,5,50,50
  void createButton(int x, int y, int w, int h, String buttonName){
    this.buttons.add(new Button(x,y,w,h,buttonName));
  }
  
  String clicked(){
    //click buttons
    if(panelOpen){
      for(Button btn : this.buttons){
        btn.clicked();
        return btn.name;
      }
    }
    
    //open close panel
    if(openClose.clicked()){
      this.dropDownBtn();
    }
    return "";
}
  
  void dropDownBtn(){
    this.thickness = (this.thickness != 0) ? 0 : 60;
    panelOpen = !panelOpen;
  }
  
  
}