class Vehicle {
  float x;
  float y;
  float z;
  float w = 250;
  float h = 100;
  float d = 100;
  int speed;
  color paint;
  int type;
  PShape vehicle;
  
  Vehicle(float x, float y, float z, int type) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.type = type;
    //Sets a random speed
    speed = (int)random(5,18);
    chooseDimensions(type);
  }
  
  //Declare instance variables based on vehicle type
  void chooseDimensions(int type) {
    if (type==0) { //Police car
      policeSound.play();
      println("police");
      vehicle = loadShape("policeCar.obj");
      z-=130;
      paint = color0;
    }
    else if (type==1) { //Civilian car
      carSound.play();
      println("car");
      vehicle = loadShape("car.obj");
      y+=10;
      paint = color1;
    }
    else if (type==2) { //Firetruck
      firetruckSound.play();
      println("firetruck");
      vehicle = loadShape("fireTruck.obj");
      z-=260;
      w=300;
      paint = color2;
    }
    else { //Ice cream truck
      iceCreamTruckSound.play();
      println("ice cream");
      vehicle = loadShape("iceCreamTruck.obj");
      z-=390;
      w=300;
      paint = color3;
    }
  }
  
  //Method that moves vehicles by int speed
  void update() {
    x-=speed;
  }
  
  //Method that draws vehicle
  void display() {
    pushMatrix();
      translate(x, y, z);
      vehicle.setFill(paint);
      scale(0.2);
      //Rotate the .obj file so the vehicle faces perpendicular to the viewer
      rotateZ(PI);
      rotateY(3*PI/2);
      shape(vehicle, 0, 0);
    popMatrix();
  }
}
