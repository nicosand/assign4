PImage bg1Img, bg2Img, treasureImg, fighterImg, enemyImg, hpImg, start1Img, start2Img;
int width = 640;
int x_bg1, x_bg2, x_treasure, y_treasure, x_hp;
int speed_bg = 3, speed_fighter = 5, speed_enemy = 8;
float x_fighter, y_fighter, x1_enemy, y1_enemy, x2_1_enemy, y2_1_enemy, x2_2_enemy, y2_2_enemy, x3_enemy, y3_enemy;
float spacingX = 70, spacingY = 50, x, y;
final int COUNT = 5;

int gameState;
final int GAME_START = 0, GAME_RUN = 1;

boolean upPressed, downPressed, leftPressed, rightPressed = false;

void setup () {
  size(640, 480) ;
  bg1Img = loadImage("img/bg1.png");
  bg2Img = loadImage("img/bg2.png");
  treasureImg = loadImage("img/treasure.png");
  fighterImg = loadImage("img/fighter.png");
  enemyImg = loadImage("img/enemy.png");
  hpImg = loadImage("img/hp.png");
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png");
  
  gameState = GAME_START;
}

void draw() {
  switch(gameState){ 
    case GAME_START:
      image(start2Img, 0, 0);
      x_bg1 = 0;
      x_bg2 = -width;
      x_fighter = 590;
      y_fighter = 215;
      x_treasure = floor(random(600));
      y_treasure = floor(random(440));
      x1_enemy = -COUNT*spacingX;
      y1_enemy = random(420); 
      x2_1_enemy = -(width+2*COUNT*spacingX);
      y2_1_enemy = random(200, 420);
      x2_2_enemy = -(4*width+5*COUNT*spacingX);
      y2_2_enemy = random(220);
      x3_enemy = -(2*width+3*COUNT*spacingX);
      y3_enemy = random(100, 320);
      x_hp = 200*1/5;
            
      //mouse action
      if(mouseX >= 208 && mouseX <= 453 && mouseY >= 379 && mouseY <= 412){
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(start1Img, 0, 0);
        }
      }
      break;
        
      case GAME_RUN:
        //bg
        image(bg1Img, x_bg1, 0);
        x_bg1 += speed_bg;
        if(x_bg1 >= width){
          x_bg1 = -width;
        }
        image(bg2Img, x_bg2, 0);
        x_bg2 += speed_bg;
        if(x_bg2 >= width){
          x_bg2 = -width;
        }
        
        //treasure
        image(treasureImg, x_treasure, y_treasure);
        if(x_treasure <= (x_fighter+50) && (x_treasure+40) >= x_fighter && (y_treasure+40) >= y_fighter && y_treasure <= (y_fighter+50)){
          x_treasure = floor(random(600));
          y_treasure = floor(random(440));
          if(x_hp == 200){
            x_hp += 0;
          }else{
          x_hp += 200*1/10;
          }
        }
     
        //fighter
        image(fighterImg, x_fighter, y_fighter);
        if(x_fighter >= 590){
          x_fighter = 590;
        }
        if(x_fighter <= 0){
          x_fighter = 0;
        }
        if(y_fighter >= 430){
          y_fighter = 430;
        }
        if(y_fighter <= 0){
          y_fighter = 0;
        }
        
        //fighter action
        if(upPressed){
          y_fighter -= speed_fighter;
        }
        if(downPressed){
          y_fighter += speed_fighter;
        }
        if(leftPressed){
          x_fighter -= speed_fighter;
        }
        if(rightPressed){
          x_fighter += speed_fighter;
        }
        
        //enemy
        pushMatrix();
        //first
        translate(x1_enemy, y1_enemy);
        for(int i=0; i<COUNT; i++){
          x = i*spacingX;
          y = 0;
          image(enemyImg,x,y);
        }
        x1_enemy += speed_enemy;
        if(x1_enemy >= width){
          x1_enemy = -(2*width+3*COUNT*spacingX);
          y1_enemy = random(420);
        };
        popMatrix();
        
        pushMatrix();
        //second
        translate(x2_1_enemy, y2_1_enemy);
        for(int i=0; i<COUNT; i++){
          x = i*spacingX;
          y = -i*spacingY;
          image(enemyImg,x,y);
        }
        x2_1_enemy += speed_enemy;
        if(x2_1_enemy >= width){
          x2_1_enemy = -(5*width+6*COUNT*spacingX);
          y2_1_enemy = random(200,420);
        };
        popMatrix();
        
        pushMatrix();
        //second
        translate(x2_2_enemy, 220);
        for(int i=0; i<COUNT; i++){
          x = i*spacingX;
          y = i*spacingY;
          image(enemyImg,x,y);
        }
        x2_2_enemy += speed_enemy;
        if(x2_2_enemy >= width){
          x2_2_enemy = -(5*width+6*COUNT*spacingX);
          y2_2_enemy = random(220);
        };
        popMatrix();
        
        pushMatrix();
        //third
        translate(x3_enemy, y3_enemy);
        for(int i=0; i<COUNT; i++){
          x = i*spacingX;
          if(i %2 != 0){
          y = -spacingY;
        }
        else if(i == 2){
          y = -2*spacingY;
        }else{
          y=0;
        }
        image(enemyImg,x,y);
        }
  
        for(int i=0; i<COUNT; i++){
          x = i*spacingX;
          if(i %2 != 0){
          y = spacingY;
        }
        else if(i == 2){
          y = 2*spacingY;
        }else{
          y=0;
        }
          image(enemyImg,x,y);
        }
        x3_enemy += speed_enemy;
        if(x3_enemy >= width){
          x3_enemy = -(2*width+3*COUNT*spacingX);
          y3_enemy = random(100,320);
        };
        popMatrix();
  
        //hp
        fill(#ff0000);
        rect(20, 12, x_hp, 20, 12);
        image(hpImg, 10, 10);
        break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  } 
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
