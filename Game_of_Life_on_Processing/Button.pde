class Button{
  PVector pos;
  PVector dimentions;
  
  int hoverColor = 200;
  int normalColor = 150;
  
  Button(int x, int y, int w, int l){
    pos = new PVector(x,y);
    dimentions = new PVector(w,l);
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
    println("lkfd"+mouseX);
    return true;
  }
  
}