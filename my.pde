ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Chaser> chasers = new ArrayList<Chaser>();
ArrayList<Runner> runners = new ArrayList<Runner>();
ArrayList<Echo> echoes = new ArrayList<Echo>();
Player you;
boolean shoot,up,down,left,right;
int summonCount;
int shootCount;
int score;
int echohealth;

void setup(){
  size(800,600);
  background(244);
  you = new Player(5);
  shoot = false;
  summonCount = 0;
  shootCount = 0;
  score = 0;
  echohealth = 8;
  up = false;
  down = false;
  left = false;
  right = false;
}

void draw(){
  background(244);
  fill(0);
  text("score: " + score,0,10);
  if (summonCount == 100) {
    if (random(100)>50) chasers.add(new Chaser(random(width),random(height),1,20));
    if (random(100)>50) runners.add(new Runner(random(width),0             ,0.5,20,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(random(width),height        ,0.5,20,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(0            ,random(height),0.5,20,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(width        ,random(height),0.5,20,random(width),random(height)));
    if (random(100)>50) echoes.add(new Echo(random(width),random(height),0.5,echohealth,echohealth,random(width),random(height)));
    summonCount = 0;
  }
  else summonCount++;
  
  
  if (shoot){
    if (shootCount >= 0){
      bullets.add(new Bullet(you.px+30*cos(you.angle),you.py+30*sin(you.angle),mouseX,mouseY));
      //for(int i =0; i<10;i++) bullets.add(new Bullet(random(width),random(height),random(width),random(height)));
      shootCount = 0;
    }
    else shootCount++;
  }
  
  
  
  for(int i = 0; i< chasers.size();i++){
    boolean removed = false;
    for( int j = 0; j<bullets.size();j++){
      if ((abs(bullets.get(j).sx - chasers.get(i).sx)<10)&&(abs(bullets.get(j).sy - chasers.get(i).sy)<10)){
        chasers.get(i).health--;
        bullets.remove(j);
        if(chasers.get(i).health<0) chasers.get(i).health = 0;
      }
    }
    chasers.get(i).move();
    chasers.get(i).show();
    if((abs(chasers.get(i).sx - you.px)<20)&&(abs(chasers.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      chasers.remove(i);
      removed = true;
    }
    if((!removed)&&(chasers.get(i).health<=0)){
      chasers.remove(i);
      removed = true;
      score+=20;
    }
  }
  
  
  
  for(int i = 0; i< runners.size();i++){
    boolean removed = false;
    for( int j = 0; j<bullets.size();j++){
      if ((abs(bullets.get(j).sx - runners.get(i).sx)<10)&&(abs(bullets.get(j).sy - runners.get(i).sy)<10)){
        runners.get(i).health--;
        bullets.remove(j);
        if(runners.get(i).health<0) runners.get(i).health = 0;
      }
    }
    runners.get(i).move();
    runners.get(i).show();
    if((abs(runners.get(i).sx - you.px)<20)&&(abs(runners.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      runners.remove(i);
      removed = true;
    }
    if((!removed)&&(runners.get(i).health<=0)){
      runners.remove(i);
      removed = true;
      score+=10;
    }
    if((!removed)&&
    ((runners.get(i).sx>width)||(runners.get(i).sx<0)
    ||(runners.get(i).sy>height)||(runners.get(i).sy<0))){
      runners.remove(i);
      removed = true;
    }
  }
  
    for(int i = 0; i< bullets.size(); i++){
    bullets.get(i).move();
    bullets.get(i).show();
    if((bullets.get(i).sx>width)||(bullets.get(i).sx<0)
    ||(bullets.get(i).sy>height)||(bullets.get(i).sy<0)){
      bullets.remove(i);
    }
  }
  
  
  
    for(int i = 0; i< echoes.size();i++){
    boolean removed = false;
    for( int j = 0; j<bullets.size();j++){
      if ((abs(bullets.get(j).sx - echoes.get(i).sx)<10)&&(abs(bullets.get(j).sy - echoes.get(i).sy)<10)){
        echoes.get(i).health--;
        if(echoes.get(i).health>=1) echoes.add(new Echo(echoes.get(i).sx,echoes.get(i).sy,0.5,echohealth,echoes.get(i).health,random(width),random(height)));
        bullets.remove(j);
        if(echoes.get(i).health<0) echoes.get(i).health = 0;
      }
    }
    echoes.get(i).move();
    echoes.get(i).show();
    if((abs(echoes.get(i).sx - you.px)<20)&&(abs(echoes.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      echoes.remove(i);
      removed = true;
    }
    if((!removed)&&(echoes.get(i).health<=0)){
      echoes.remove(i);
      removed = true;
      score+=1;
    }
    if((!removed)&&
    ((echoes.get(i).sx>width)||(echoes.get(i).sx<0)
    ||(echoes.get(i).sy>height)||(echoes.get(i).sy<0))){
      echoes.remove(i);
      removed = true;
    }
  }
  
  
  
    for(int i = 0; i< bullets.size(); i++){
    bullets.get(i).move();
    bullets.get(i).show();
    if((bullets.get(i).sx>width)||(bullets.get(i).sx<0)
    ||(bullets.get(i).sy>height)||(bullets.get(i).sy<0)){
      bullets.remove(i);
    }
  }
  
  
  
  if(up)         you.py -= you.vp;
  else if(down)  you.py += you.vp;
  else if(left)  you.px -= you.vp;
  else if(right) you.px += you.vp;
  you.show();
  if (you.health<=0){
    score -=chasers.size()*20;
    score -=runners.size()*10;
    score -=echoes.size();
    //background(244);
    textSize(50);
    fill(0);
    text("YOU LOSE",width/2-200,height/2-25);
    text("YOUR SCORE: " + score,width/2-200,height/2+25);
    noLoop();
  }
}

void keyPressed(){
  if (key == 'w') up = true;
  else if (key == 's') down = true;
  else if (key == 'a') left = true;
  else if (key == 'd') right = true;
}

void keyReleased(){
  if (key == 'w') up = false;
  else if (key == 's') down = false;
  else if (key == 'a') left = false;
  else if (key == 'd') right = false;
}

void mousePressed(){
  shoot = true;
  you.vp = 2;
}

void mouseReleased(){
  shoot = false;
  you.vp = 3;
}


class Bullet{
  float vb = 3;//vbullet
  float sx;//startx
  float sy;//starty
  float dx;
  float dy;
  float angle;
  color col = color(random(255),random(255),random(255));
  
  public Bullet(float _sx, float _sy, float _dx, float _dy){
    sx = _sx;
    sy = _sy;
    dx = _dx;
    dy = _dy;
    float deltax = dx - sx;
    float deltay = dy - sy;
    angle = atan2(deltay,deltax);  
}
  
  public void move(){
    //float deltax = dx - sx;
    //float deltay = dy - sy;
    //angle = atan2(deltay,deltax);
    sx += vb*cos(angle);
    sy += vb*sin(angle);
  }
  
  public void show(){
    strokeWeight(5);
    stroke(col);
    line(sx-vb*cos(angle),sy-vb*sin(angle),sx+vb*cos(angle),sy+vb*sin(angle));
  }
  
}

class Player{
  float vp = 3;//vplayer
  float px;
  float py;
  float angle;
  int health;
  int maxhealth;
  
  public Player( int _maxhealth){
    px = random(width);
    py = random(height);
    health = _maxhealth;
    maxhealth = _maxhealth;
  }
  
  public void show(){
    float deltax = mouseX - px;
    float deltay = mouseY - py;
    angle = atan2(deltay,deltax);
    fill(255);
    strokeWeight(1);
    stroke(0);
    ellipse(px,py,30,30);
    rectMode(CORNER);
    pushMatrix();
    translate(px,py);
    fill(255);
    rect(-25,30,50,5);
    fill(0);
    rect(-25,30,50*health/maxhealth,5);
    rotate(angle);
    fill(255);
    rect(5,-5,20,10);
    popMatrix();
  }
  
}

class Chaser{
  float ve;//vChaser
  float sx;
  float sy;
  float angle;
  int health;
  int maxhealth;
  
  public Chaser(){}
  
  public Chaser(float _sx, float _sy, float _ve, int _maxhealth){
    sx = _sx;
    sy = _sy;
    ve = _ve;
    maxhealth = _maxhealth;
    health = _maxhealth;
  }
  
  public void move(){
    float deltax = you.px - sx;
    float deltay = you.py - sy;
    angle = atan2(deltay,deltax);
    sx += ve*cos(angle);
    sy += ve*sin(angle);
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    fill(255,0,0);
    pushMatrix();
    translate(sx,sy);
    rotate(angle);
    rect(0,0,20,20);
    popMatrix();
    rectMode(CORNER);
    fill(255);
    rect(sx-25,sy+15,50,5);
    fill(0);
    rect(sx-25,sy+15,50*health/maxhealth,5);
  }
  
}

class Runner extends Chaser{
  
  public Runner(){}
  
  public Runner(float _sx, float _sy, float _ve, int _maxhealth, float _angle){
    sx = _sx;
    sy = _sy;
    ve = _ve;
    maxhealth = _maxhealth;
    health = _maxhealth;
    angle = _angle;
  }
  
  public Runner(float _sx, float _sy, float _ve, int _maxhealth, float _dx, float _dy){
    float deltax = _dx - _sx;
    float deltay = _dy - _sy;
    sx = _sx;
    sy = _sy;
    ve = _ve;
    maxhealth = _maxhealth;
    health = _maxhealth;
    angle = atan2(deltay,deltax);
  }
  
  public void move(){
    sx += ve*cos(angle);
    sy += ve*sin(angle);
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    fill(0,0,255);
    pushMatrix();
    translate(sx,sy);
    rotate(angle);
    rect(0,0,20,20);
    popMatrix();
    rectMode(CORNER);
    fill(255);
    rect(sx-25,sy+15,50,5);
    fill(0);
    rect(sx-25,sy+15,50*health/maxhealth,5);
  }
}

class Echo extends Runner{
  
  public Echo(float _sx, float _sy, float _ve, int _maxhealth, int _health, float _dx, float _dy){
    float deltax = _dx - _sx;
    float deltay = _dy - _sy;
    sx = _sx;
    sy = _sy;
    ve = _ve;
    maxhealth = _maxhealth;
    health = _health;
    angle = atan2(deltay,deltax);
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    fill(0,255,0);
    pushMatrix();
    translate(sx,sy);
    rotate(angle);
    rect(0,0,20,20);
    popMatrix();
    rectMode(CORNER);
    fill(255);
    rect(sx-25,sy+15,50,5);
    fill(0);
    rect(sx-25,sy+15,50*health/maxhealth,5);
  }
  
}
