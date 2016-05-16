ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Emeny> emenys = new ArrayList<Emeny>();
Player you;
boolean shoot;
int summonCount;
int shootCount;

void setup(){
  size(800,600);
  background(244);
  you = new Player();
  shoot = false;
  summonCount = 0;
  shootCount = 0;
}

void draw(){
  background(244);
  if (summonCount == 100) {
    emenys.add(new Emeny(random(width),random(height),1,5));
    summonCount = 0;
  }
  else summonCount++;
  if (shoot){
    if (shootCount == 8){
      bullets.add(new Bullet(you.px+30*cos(you.angle),you.py+30*sin(you.angle),mouseX,mouseY));
      shootCount = 0;
    }
    else shootCount++;
  }
  for(int i = 0; i< emenys.size();i++){
    for( int j = 0; j<bullets.size();j++){
      if ((abs(bullets.get(j).sx - emenys.get(i).sx)<10)&&(abs(bullets.get(j).sy - emenys.get(i).sy)<10)){
        emenys.get(i).health--;
        bullets.remove(j);
      }
    }
    emenys.get(i).move();
    emenys.get(i).show();
    if(emenys.get(i).health<=0) emenys.remove(i);
  }
  
    for(int i = 0; i< bullets.size(); i++){
    bullets.get(i).move();
    bullets.get(i).show();
    if((bullets.get(i).sx>width)||(bullets.get(i).sx<0)
    ||(bullets.get(i).sy>height)||(bullets.get(i).sy<0)){
      bullets.remove(i);
    }
  }
  
  you.show();
}

void keyPressed(){
  if (key == 'w') you.py -= you.vp;
  if (key == 's') you.py += you.vp;
  if (key == 'a') you.px -= you.vp;
  if (key == 'd') you.px += you.vp;
}

void mousePressed(){
  shoot = true;
  you.vp = 3;
}

void mouseReleased(){
  shoot = false;
  you.vp = 5;
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
  
  public Player(){
    px = random(width);
    py = random(height);
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
    translate(px,py);
    rotate(angle);
    rect(5,-5,20,10);
  }
}

class Emeny{
  float ve;//vemeny
  float sx;
  float sy;
  float angle;
  int health;
  int maxhealth;
  
  public Emeny(float _sx, float _sy, float _ve, int _maxhealth){
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
    //translate(sx,sy);
    //rotate(angle);
    fill(255);
    rect(sx,sy,20,20);
    //rect(sx,sy+20,50,10);
    rectMode(CORNER);
    rect(sx-25,sy+15,50,10);
    fill(0);
    rect(sx-25,sy+15,50*health/maxhealth,10);
  }
  
}
