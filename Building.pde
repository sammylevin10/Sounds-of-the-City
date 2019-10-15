class Building {
  float x;
  float y;
  float z;
  float w = 300;
  float h = 0;
  float d = 300;
  int speed = 3;
  int type = 0;
  color paint;
  PShape building;
  int calibrator;
  
  Building(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    //randomize the type of building
    type = floor(random(0,4));
    chooseDimensions(type);
  }
  
  //Declare instance variables based on building type
  void chooseDimensions(int type) {
    if (type==0) { //Police station
      paint = color0;
      building = loadShape("policeStation.obj");
      calibrator = 300;
    }
    else if (type==1) { //Parking garage
      paint = color1;
      building = loadShape("parkingLot.obj");
    }
    else if (type==2) { //Fire station
      paint = color2;
      building = loadShape("fireStation.obj");
      calibrator = 600;
    }
    else { //Ice cream parlor
      paint = color3;
      building = loadShape("iceCreamParlor.obj");
      calibrator = 900;
    }
  }
  
  //Method that moves building by int speed
  void update() {
    x += speed;
  }
  
  //Method that draws building
  void display() {
    pushMatrix();
      translate(x, y, z);
      //Calibrator is used to account for inconsistent origins between .obj files
      translate(140+calibrator, 180, -100);
      building.setFill(paint);
      //Rotate the .obj file so the building faces the viewer
      rotateX(PI);
      rotateY(3*PI/2);
      scale(0.25);
      shape(building, 0, 0);
    popMatrix();
  }
}
