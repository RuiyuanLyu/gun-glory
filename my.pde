ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Chaser> chasers = new ArrayList<Chaser>();
ArrayList<Runner> runners = new ArrayList<Runner>();
ArrayList<Echo> echoes = new ArrayList<Echo>();
ArrayList<Summoner> summoners = new ArrayList<Summoner>();
Player you;
boolean shoot,boom,up,down,left,right;
int generateCount;
int shootCount;
int boomCount;
int boomSize;
int immuneCount;
int immunetime;
int summontime;
int score;
int level;
boolean level3release;
int echohealth;
int difficulty;
float echospeed;

void setup(){
  size(800,600);
  background(244);
  you = new Player(5);
  shoot = false;
  boom = false;
  generateCount = 0;
  shootCount = 0;
  boomCount = 0;
  boomSize = 500;
  summontime = 20;
  immuneCount = 0;
  immunetime = 100;
  score = 0;
  level = 1;
  level3release = false;
  difficulty = 1;
  echohealth = 5;
  echospeed = 0.5;
  up = false;
  down = false;
  left = false;
  right = false;
}

void draw(){
  background(244);
  if ((score >= 2000)&&(score < 4000)) level = 2;
  else if ((score >= 4000)&&(score < 6000)) difficulty = 2;
  else if ((score >= 6000)&&(score < 8000)) level = 3;
  else if ((score >= 8000)&&(score < 10000)){
    difficulty = 3;
    echohealth = 6;
    if (!level3release){
      for(int i = 0 ; i < 5; i++){
        float adjustx = random(width);
        float adjusty = random(height);
        while ((abs(you.px - adjustx)<100)&&(abs(you.py - adjusty)<100)){
        adjustx = random(width);
        adjusty = random(height);
        }
        summoners.add(new Summoner(adjustx,adjusty,0.1,200*difficulty,random(width),random(height),summontime));
      }
      level3release = true;
    }
  }
  
  if (generateCount == 100) {
    if (random(100)>50){
      float adjustx = random(width);
      float adjusty = random(height);
      while ((abs(you.px - adjustx)<100)&&(abs(you.py - adjusty)<100)){
      adjustx = random(width);
      adjusty = random(height);
      }
      chasers.add(new Chaser(adjustx,adjusty,1,50*difficulty));
    }
    if (random(100)>50) runners.add(new Runner(random(width),0             ,0.5,20*difficulty,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(random(width),height        ,0.5,20*difficulty,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(0            ,random(height),0.5,20*difficulty,random(width),random(height)));
    if (random(100)>50) runners.add(new Runner(width        ,random(height),0.5,20*difficulty,random(width),random(height)));
    if (random(100)>90) {
      float adjustx = random(width);
      float adjusty = random(height);
      while ((abs(you.px - adjustx)<100)&&(abs(you.py - adjusty)<100)){
      adjustx = random(width);
      adjusty = random(height);
      }
      summoners.add(new Summoner(adjustx,adjusty,0.1,200*difficulty,random(width),random(height),summontime));
    }
    
    if (random(100)>50) {
      float adjustx = random(width);
      float adjusty = random(height);
      while ((abs(you.px - adjustx)<100)&&(abs(you.py - adjusty)<100)){
      adjustx = random(width);
      adjusty = random(height);
      }
      echoes.add(new Echo(adjustx,adjusty,echospeed,echohealth,echohealth,random(width),random(height)));
    }
    generateCount = 0;
  }
  else generateCount++;
  
  
  if (shoot){
    if (shootCount >= 0){
      //bullets.add(new Bullet(you.px+30*cos(you.angle),you.py+30*sin(you.angle),mouseX,mouseY)); 
      if(level == 1)bullets.add(new Bullet(you.px+40*cos(you.angle)-10*sin(you.angle),you.py+40*sin(you.angle)+10*cos(you.angle),mouseX-10*sin(you.angle),mouseY+10*cos(you.angle)));
      if(level == 2)bullets.add(new Bullet(you.px+40*cos(you.angle)-5*sin(you.angle),you.py+40*sin(you.angle)+5*cos(you.angle),mouseX-5*sin(you.angle),mouseY+5*cos(you.angle))); 
      if(level == 1||level == 3)bullets.add(new Bullet(you.px+40*cos(you.angle),you.py+40*sin(you.angle),mouseX,mouseY)); 
      if(level == 2)bullets.add(new Bullet(you.px+40*cos(you.angle)+5*sin(you.angle),you.py+40*sin(you.angle)-5*cos(you.angle),mouseX+5*sin(you.angle),mouseY-5*cos(you.angle))); 
      if(level == 1)bullets.add(new Bullet(you.px+40*cos(you.angle)+10*sin(you.angle),you.py+40*sin(you.angle)-10*cos(you.angle),mouseX+10*sin(you.angle),mouseY-10*cos(you.angle))); 
      //for(int i =0; i<10;i++) bullets.add(new Bullet(random(width),random(height),random(width),random(height)));
      shootCount = 0;
    }
    shootCount++;
  }
  
  if (boom) {
    if (boomCount >= boomSize){
      for(int k = 0; k <500; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      boomCount -= boomSize;
    }
  }
  boomCount++;
  
  
  
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
    if((immuneCount >= immunetime)&&(abs(chasers.get(i).sx - you.px)<20)&&(abs(chasers.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      chasers.remove(i);
      immuneCount = 0;
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
    if((immuneCount >= immunetime)&&(abs(runners.get(i).sx - you.px)<20)&&(abs(runners.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      runners.remove(i);
      immuneCount = 0;
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
        if(echoes.get(i).health>=1){
          echoes.get(i).ve+=echospeed;
          for(int k = 0; k < 2  ; k++){
            echoes.add(new Echo(echoes.get(i).sx,echoes.get(i).sy,echoes.get(i).ve+echospeed,echohealth,echoes.get(i).health,random(width),random(height)));
            //runners.add(new Runner(echoes.get(i).sx,echoes.get(i).sy,2,echoes.get(i).health,random(width),random(height)));
          }
        }
        bullets.remove(j);
        if(echoes.get(i).health<0) echoes.get(i).health = 0;
      }
    }
    echoes.get(i).move();
    echoes.get(i).show();
    if((immuneCount >= immunetime)&&(abs(echoes.get(i).sx - you.px)<20)&&(abs(echoes.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      echoes.remove(i);
      immuneCount = 0;
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
  
  
  for(int i = 0; i< summoners.size();i++){
    boolean removed = false;
    for( int j = 0; j<bullets.size();j++){
      if ((abs(bullets.get(j).sx - summoners.get(i).sx)<10)&&(abs(bullets.get(j).sy - summoners.get(i).sy)<10)){
        summoners.get(i).health--;
        bullets.remove(j);
        if(summoners.get(i).health<0) summoners.get(i).health = 0;
      }
    }
    summoners.get(i).move();
    summoners.get(i).show();
    summoners.get(i).summon();
    if((immuneCount >= immunetime)&&(abs(summoners.get(i).sx - you.px)<20)&&(abs(summoners.get(i).sy - you.py)<20)){
      you.health --;
      for(int k = 0; k < 1000; k++){
        bullets.add(new Bullet(you.px,you.py,random(width),random(height)));
      }
      summoners.remove(i);
      immuneCount = 0;
      removed = true;
    }
    if((!removed)&&(summoners.get(i).health<=0)){
      summoners.remove(i);
      removed = true;
      score+=500;
    }
    if((!removed)&&
    ((summoners.get(i).sx>width)||(summoners.get(i).sx<0)
    ||(summoners.get(i).sy>height)||(summoners.get(i).sy<0))){
      summoners.remove(i);
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
  immuneCount++;
  you.show();
  
  fill(0);
  text("score: " + score,0,10);
  text("Bomb(s): " + (boomCount-boomCount%boomSize)/boomSize,you.px-28,you.py+5);
  
  if (you.health<=0){
    //score -=chasers.size()*20;
    //score -=runners.size()*10;
    //score -=echoes.size();
    //background(244);
    textSize(50);
    fill(0);
    text("YOU LOSE",width/2-200,height/2-25);
    text("YOUR SCORE: " + score,width/2-200,height/2+25);
    noLoop();
  }
  
  if (score >= 10000){
    textSize(50);
    fill(0);
    text("YOU WIN!",width/2-125,height/2+10);
    noLoop();   
  }
}

void keyPressed(){
  if (key == 'w') up = true;
  else if (key == 's') down = true;
  else if (key == 'a') left = true;
  else if (key == 'd') right = true;
  if (key == ' ') boom = true;
}

void keyReleased(){
  if (key == 'w') up = false;
  else if (key == 's') down = false;
  else if (key == 'a') left = false;
  else if (key == 'd') right = false;
  if (key == ' ') boom = false;
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
    if ((immuneCount > immunetime)||(immuneCount%10 < 5)){
      if(level == 1||level == 2) ellipse(px,py,40,40);
      else ellipse(px,py,30,30);
    }
    rectMode(CORNER);
    pushMatrix();
    translate(px,py);
    fill(255);
    rect(-25,30,50,5);
    fill(0);
    rect(-25,30,50*health/maxhealth,5);
    rotate(angle);
    fill(255);
    if ((immuneCount > immunetime)||(immuneCount%10 < 5)){
      if(level == 1||level == 2) rect(5,-10,30,20);
      else rect(5,-5,30,10);
    }
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

class Summoner extends Runner{
  
  int summonCount;
  int summonTime;
  
  public Summoner(float _sx, float _sy, float _ve, int _maxhealth, float _dx, float _dy, int _summonTime){
    float deltax = _dx - _sx;
    float deltay = _dy - _sy;
    sx = _sx;
    sy = _sy;
    ve = _ve;
    maxhealth = _maxhealth;
    health = _maxhealth;
    summonTime = _summonTime;
    summonCount = 0;
    angle = atan2(deltay,deltax);
  }
  
  public void summon(){
    if(summonCount >= summonTime){
      for(int j = 0; j < 1; j++){
        runners.add(new Runner(sx,sy,2.5,20*difficulty,random(width),random(height)));
      }
      summonCount = 0;
    }
    else summonCount++;
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    fill(255,255,0);
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
