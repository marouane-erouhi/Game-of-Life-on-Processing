class Button{
  PVector pos;
  PVector dimentions;
  int hoverColor = 200;
  int normalColor = 150;
  private String name;
  
  Button(int x, int y, int w, int l, String name){
    pos = new PVector(x,y);
    dimentions = new PVector(w,l);
    this.name = name;
  }
  
  void draw(){
    fill( hover() ? hoverColor : normalColor );
    rect(pos.x, pos.y, dimentions.x, dimentions.y);
  }
  
  boolean hover(){
    if (mouseX >= pos.x && mouseX <= pos.x+dimentions.x && 
        mouseY >= pos.y && mouseY <= pos.y+dimentions.y) {
      return true;
    } else {
      return false;
    }
  }
  
  public boolean clicked(){
    if(!hover())  return false;
    println(this.name);
    return true;
  }
  
  public String getName(){return this.name;}
}