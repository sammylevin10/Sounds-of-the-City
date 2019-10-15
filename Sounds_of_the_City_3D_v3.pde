//Add the sound library
import processing.sound.*;
//Set up the array of buildings and vehicles
Building[] buildings = new Building[0];
Vehicle[] vehicles = new Vehicle[0];
//Various sounds for vehicles
SoundFile carSound;
SoundFile firetruckSound;
SoundFile iceCreamTruckSound;
SoundFile policeSound;
SoundFile ambientSound;
SoundFile honk;
//Numbers 0-3 in this sketch represent each pair of buildings and vehicles
//0 represents police stations or police cars
//1 represents parking garages or civillian cars
//2 represents fire stations or fire trucks
//3 represents ice cream shops or ice cream trucks
//Here those numbers are used to correspond to particular colors
color color0;
color color1;
color color2;
color color3;
//lastClick is used to prevent spam clicking
int lastClick;

void setup() {
  fullScreen(P3D);
  colorMode(HSB,360,100,100);
  //Declare the instance variables
  firetruckSound = new SoundFile(this, "firetruck_sound.mp3");
  carSound = new SoundFile(this, "car_sound.mp3");
  iceCreamTruckSound = new SoundFile(this, "icecreamtruck_sound.mp3");
  policeSound = new SoundFile(this, "police_sound.mp3");
  ambientSound = new SoundFile(this, "ambient_sound.mp3");
  honk = new SoundFile(this, "honk.mp3");
  honk.amp(0.5);
  color0 = color(213,67,100);
  color1 = color(42,76,100);
  color2 = color(358,53,100);
  color3 = color(129,59,100);
  //Build the first building on the road
  Building firstBuilding = new Building(0, height / 2, -100);
  buildings = (Building[])append(buildings, firstBuilding);
  //Play the ambient city noise in the background
  ambientSound.play();
}

void draw() {
  background(230, 100, 50);
  lights();
  noStroke();
  
  //If leftmost building reaches scren edge, build new building
  Building lastBuilding = buildings[buildings.length - 1];
  if (lastBuilding.x >= 150) {
    Building newBuilding = new Building(-lastBuilding.x - 30, height / 2, -100);
    buildings = (Building[])append(buildings, newBuilding);
  }
  
  //Remove rightmost building if it passes screen edge
  for (int i = buildings.length - 1; i >= 0; i--) {
    if (buildings[i].x > width + buildings[i].w) {
      buildings = remove(buildings, i);
    }
  }
  
  //Remove rightmost vehicle if it passes screen edge
  for (int i = vehicles.length - 1; i >= 0; i--) {
    if (vehicles[i].x < (-1)*vehicles[i].w-400) {
      vehicles = remove(vehicles, i);
    }
  }
  
  //Move every building by int speed then display
  for (int i = 0; i < buildings.length; i++) {
    buildings[i].update();
    buildings[i].display();
  }
  
  //Move every vehicle by int speed then display
  for (int i = 0; i < vehicles.length; i++) {
    vehicles[i].update();
    vehicles[i].display();
  }
  checkTraffic();
  drawRoad();
}

//Function for truncating array of buildings
Building[] remove(Building[] array, int index) {
  Building[] leftHandSide = (Building[])subset(array, 0, index);
  Building[] rightHandSide = (Building[])subset(array, index + 1);
  return (Building[])concat(leftHandSide, rightHandSide);
}

//Function for truncating array of vehicles
Vehicle[] remove(Vehicle[] array, int index) {
  Vehicle[] leftHandSide = (Vehicle[])subset(array, 0, index);
  Vehicle[] rightHandSide = (Vehicle[])subset(array, index + 1);
  return (Vehicle[])concat(leftHandSide, rightHandSide);
}

//Draw sidewalk and road beneath buildings
void drawRoad() {
  pushMatrix();
    translate(700, 600, -100);
    fill(80);
    box(2000,30,500);
    translate(0, 50, 200);
    fill(40);
    box(1500,30,1000);
  popMatrix();
}

//If vehicles are x distance apart, rear vehicle speed becomes front vehicle speed
void checkTraffic() {
  if (vehicles.length!=0) {
    for (int i = 1; i<vehicles.length; i++) {
      int maxWidth = (int)vehicles[i].w;
      if(maxWidth<(int)vehicles[i-1].w) {
        maxWidth = (int)vehicles[i-1].w;
      }
      if (vehicles[i].x-vehicles[i-1].x<maxWidth+10) {
        vehicles[i].speed=vehicles[i-1].speed;
        vehicles[i].x+=1;
        honk.play();
      }
    }
  }
}

//Depending on the building clicked, create the corresponding vehicle
void mousePressed() {
  if(frameCount-lastClick>40) {
    for (int i = 0; i<buildings.length; i++) {
      int center = (int)buildings[i].x;
      int half = (int)buildings[i].w/2;
      if (mouseX>center-half&&mouseX<center+half) {
        Vehicle newVehicle = new Vehicle(width + 50, 600, 330, buildings[i].type);
        vehicles = (Vehicle[])append(vehicles, newVehicle);
      }
      lastClick=frameCount;
    }
  }
}
