ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Player you;
boolean shoot;

void setup(){
  size(800,600);
  background(244);
  you = new Player();
  shoot = false;
}

void draw(){
  background(244);
  if (shoot) bullets.add(new Bullet(you.px+30*cos(you.angle),you.py+30*sin(you.angle),mouseX,mouseY));
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
}

void mouseReleased(){
  shoot = false;
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
    strokeWeight(1);
    stroke(0);
    ellipse(px,py,30,30);
    translate(px,py);
    rotate(angle);
    rect(5,-5,20,10);
  }
}

class Ememy{
  float ve;//vemeny
  float sx;
  float sy;
  float angle;
  float health;
  
  
}
