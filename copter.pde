float size = 30;
float x = 150;
float y = 50;
float speedY = 0;
int hazards = 1;
FloatList hazFull;
int time = 0;
int timeDif = 0;
int score;
boolean dead = false;
int health = 5;
int hurtTime = 0;

void setup() 
{
  size(600, 400);
  speedY = 0;
  hazFull = new FloatList();
  score = time + (hazards-1)*400;
  
  for(int i = 0; i < hazards; i++)
  {
    // 0 is x, 1 is y, 2 is x speed
    hazFull.append(width + size);
    hazFull.append(random(size / 2, height - size / 2));
    hazFull.append(random(-5,-2));
  }
  
}

void draw() 
{
  noStroke();
  fill(180, 0, 0);
  background(255);
  for(int i = 0; i < health; i++)
  {
    ellipse(width-10-35*i,10,16,16);
    ellipse(width-25-35*i,10,16,16);
    triangle(width-2-35*i,12,width-33-35*i, 12,width-17.5-35*i, 28);
  }

  //player
  fill(0, 0, 0);
  ellipse(x, y, size, size);
  if(hurtTime > 0)
  {
    fill(random(255),random(255),random(255), 80);
    ellipse(x, y, size*1.5, size*1.5);
  }
  y += speedY;

  //gravity
  if (y + size / 2 < 350) 
  {
    speedY += 0.1;
  }

  //colisoin upper and lower
  if (y + size / 2 > height) 
  {
    y = height - size/2;
    speedY = 0;
  }
  else if(y - size / 2 < 0)
  {
    y = 0 + size/2;
    speedY = 0;
  }

  //speed max
  if(speedY > 4)
  {
    speedY = 4;
  }
  else if(speedY < -5)
  {
    speedY = -5;
  }
  
  fill(170,0,0);
  for(int i = 0; i < hazards; i++)
  {
    hazFull.add(i*3,hazFull.get(i*3+2));
    if(hazFull.get(i*3) < 0 -size/2)
    {
      hazFull.set(i*3,width+size/2);
      hazFull.set(i*3+1,random(size / 2, height - size / 2));
      hazFull.set(i*3+2,random(-5,-2));
    }
    
    drawing(hazFull.get(i*3),hazFull.get(i*3+1));
    if(dist(x,y,hazFull.get(i*3),hazFull.get(i*3+1)) < size * .75 && hurtTime <= 0)
    {
      hurtTime = 200;
      health --;
    }
  }
  if(time >= 600+timeDif)
  {
    hazards ++;
    hazFull.append(width + size);
    hazFull.append(random(size / 2, height - size / 2));
    hazFull.append(random(-5,-2));
    timeDif = time;
  }
  else
  {
    time ++;
  }
  if(health <= 0)
  {
    dead = true;
  }
  if(dead == false)
  {
    score = time + (hazards-1)*400;
    textSize(15);
    fill(0, 0, 170);
    text("Score: "+ score,3,13);
  }
  else
  {
    fill(0);
    rect(0,0,width,height);
    textSize(100);
    fill(0, 0, 170);
    text("Score: "+ score,0,300);
    text("Game Over",55,200);
  } 
  hurtTime --;
}

void keyPressed() 
{
  //jump
  if (key == 'w') 
  {
    speedY -= 2;
    if(speedY > 3)
    {
      speedY --;
    }
  }
}
