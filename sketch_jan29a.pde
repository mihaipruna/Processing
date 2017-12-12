ball balls[];
float gravity=20;
int framerater=30;
int ballcount=0;
int timerer=60;
wall walls;
void setup()
{
    
  float[] xs = new float[4]; 
  
xs[0] = 100; 
xs[1] = 200; 
xs[2] = 300; 
xs[3]=250;
  float[] ys = new float[4]; 
  
ys[0] = 150; 
ys[1] = 100; 
ys[2] = 150; 
ys[3]=200;

walls=new wall(xs,ys,4);
  
  balls=new ball[1000];
  size(480,320);
   background(0);
   frameRate(framerater);
}

void draw()
{
   background(0);
  timerer=timerer-1;
  walls.render();
  if (timerer==0 && ballcount<20)
  {
   timerer=60; 
   ballcount++;
   balls[ballcount]=new ball(20+random(440),float(20),random(40),random(40),float(20),100+random(100));
   
  }
  for (int i=1;i<=ballcount;i++)
 
 {
   for (int k=0;k<walls.points-1;k++)
   
   {
   boolean linecol=balls[i].checkline(walls.x[k],walls.y[k],walls.x[k+1],walls.y[k+1]); 
   if (linecol==false)
   {
    boolean checkpt=balls[i].checkpt(walls.x[k],walls.y[k]);
    
    
   }
   }
   boolean linecol=balls[i].checkline(walls.x[walls.points-1],walls.y[walls.points-1],walls.x[0],walls.y[0]);
boolean checkpt=balls[i].checkpt(walls.x[walls.points-1],walls.y[walls.points-1]);
   balls[i].update(); 
   balls[i].render();
   
 }


 

 
 for (int i=1;i<ballcount;i++)
 
 {

  for (int j=i+1;j<=ballcount;j++)
  {
   if ((i!=j) && (sqrt(pow(balls[i].x-balls[j].x,2)+pow(balls[i].y-balls[j].y,2))<=40) && ((abs(balls[i].vx)>0) || (abs(balls[i].vy)>0) || (abs(balls[j].vx)>0) || (abs(balls[j].vy)>0)))
   {
     
    
      
     
     float tx=(balls[i].x-balls[j].x)/sqrt(pow(balls[i].x-balls[j].x,2)+pow(balls[i].y-balls[j].y,2));
    float ty=(balls[i].y-balls[j].y)/sqrt(pow(balls[i].x-balls[j].x,2)+pow(balls[i].y-balls[j].y,2));
    
    float dx=balls[i].x-balls[j].x;
    float dy=balls[i].y-balls[j].y;
    float d=sqrt(pow(dx,2)+pow(dy,2));
        
    
     
     float v1x1=balls[i].vx;
     float v2x1=balls[j].vx;
     float v1y1=balls[i].vy;
     float v2y1=balls[j].vy;
     float m1=balls[i].mass;
     float m2=balls[j].mass;
   
    
    
    float v1=sqrt(pow(v1x1,2)+pow(v1y1,2));
    //float vtx1=v1x1*(v1x1*dx+v1y1*dy)/pow(v1,2);
    //float vty1=v1y1*(v1x1*dx+v1y1*dy)/pow(v1,2);
    float vtx1=dx*(v1x1*dx+v1y1*dy)/pow(d,2);
    float vty1=dy*(v1x1*dx+v1y1*dy)/pow(d,2);
    
    float sgn=(vtx1*dx+vty1*dy)/abs(vtx1*dx+vty1*dy);
    
    float vt1=sgn*(sqrt(pow(vtx1,2)+pow(vty1,2)));
    
    float v2=sqrt(pow(v2x1,2)+pow(v2y1,2));
    //float vtx2=v2x1*(v2x1*dx+v2y1*dy)/pow(v2,2);
    //float vty2=v2y1*(v2x1*dx+v2y1*dy)/pow(v2,2);
    float vtx2=dx*(v2x1*dx+v2y1*dy)/pow(d,2);
    float vty2=dy*(v2x1*dx+v2y1*dy)/pow(d,2);
    
    float sgn1=(vtx2*dx+vty2*dy)/abs(vtx2*dx+vty2*dy);
    float vt2=sgn1*sqrt(pow(vtx2,2)+pow(vty2,2));
    
    
    if (!(sgn>0 && sgn1<0))
    {

    float vnx1=v1x1-vtx1;
    float vny1=v1y1-vty1;
    

    float vnx2=v2x1-vtx2;
    float vny2=v2y1-vty2;
    
    
    
    float vt12=(m1-m2)/(m1+m2)*vt1+2*m2/(m1+m2)*vt2;
    float vt22=(m2-m1)/(m1+m2)*vt2+2*m1/(m1+m2)*vt1;
     
     float vt12x=vt12*dx/(sqrt(pow(dx,2)+pow(dy,2)));
     float vt12y=vt12*dy/(sqrt(pow(dx,2)+pow(dy,2)));
     
      float vt22x=vt22*dx/(sqrt(pow(dx,2)+pow(dy,2)));
     float vt22y=vt22*dy/(sqrt(pow(dx,2)+pow(dy,2)));
     
     balls[i].vx=vt12x+vnx1;
     balls[i].vy=vt12y+vny1;
     
    balls[j].vx=vt22x+vnx2;
     balls[j].vy=vt22y+vny2;
 
     
    balls[i].x=balls[j].x+tx*40;
    balls[i].y=balls[j].y+ty*40;
    boolean colwall=balls[i].checkwall();
  if (colwall==true)
  
  {
   i=1;
 
}
else
{
    
  boolean jcolwal=balls[j].checkwall();
  if (jcolwal==true)
  {
   j=i+1; 
  }
  
} 
    } 
     
    

   }
     
   
   }

   
  }
     
 
  
 

  
  
}

class ball 
{
  boolean nukeblow;
  float x, y;
float rad;

  float vx, vy;
  float mass;
 ball(float ix, float iy, float ivx, float ivy, float irad,float imass)
  
  {
   x=ix;
  y=iy;
 vx=ivx;
vy=ivy;
rad=irad;
mass=imass;
    
    
  }
  
  boolean checkline(float x1,float y1,float x2,float y2)
  
  {
    float ax=x-x1;
    float ay=y-y1;
    float bx=x2-x1;
    float by=y2-y1;
    float dotprod=ax*bx+ay*by;
    float maga=sqrt(pow(ax,2)+pow(ay,2));
    float magb=sqrt(pow(bx,2)+pow(by,2));
    boolean linecol=false;
    if ((dotprod/magb<=magb) && (dotprod/magb>=0))
    {
      
      float abx=x1+bx/magb*dotprod/magb;
      float aby=y1+by/magb*dotprod/magb;
      if (sqrt(pow(abx-x,2)+pow(aby-y,2))<=20)
      {
       float vmag=sqrt(pow(vx,2)+pow(vy,2));
        
       
       float xabx=abx-x;
       float yaby=aby-y;
       
       float vtx=bx*(vx*bx+vy*by)/pow(magb,2);
       float vty=by*(vx*bx+vy*by)/pow(magb,2);
       
       
       float vnx=vx-vtx;
       float vny=vy-vty;
       
       if (vnx*xabx+vny*yaby>0)
       {
       linecol=true;
       vx=vtx-vnx;
       vy=vty-vny;
       
       }
       
      }
      
    
  }
return linecol;  
}

  boolean checkpt(float x1,float y1)
  
  {
    boolean checkpt=false;
    float ax=x1-x;
    float ay=y1-y;
    float distance=sqrt(pow(ax,2)+pow(ay,2));
    if (distance<20)
    {
     float vprojx=(vx*ax+vy*ay)/pow(distance,2)*ax;
     float vprojy=(vx*ax+vy*ay)/pow(distance,2)*ay;
     float vnx=vx-vprojx;
     float vny=vy-vprojy;
     if (vprojx*ax+vprojy*ay>0)
     {
     vx=vnx-vprojx;
     vy=vny-vprojy;
     checkpt=true;
   }
    }
      
  
return checkpt;  
}
  boolean checkwall()
  {
   boolean walcol=false;
    if (y>320-rad)
 
 { if (vy>=0)
 
 {
   vy=-vy;
   y=320-rad;
   walcol=true;
 }
 }

 if (y<rad)
 
 { if (vy<0)
 
 {
   vy=-vy;
   y=rad;
   walcol=true;
 }
 }
  
  if (x>480-rad)
 
 { if (vx>=0)
 
 {
   vx=-vx;
   x=480-rad;
   walcol=true;
 }
 }


 if (x<rad)
 
 { if (vx<0)
 
 {
   vx=-vx;
   x=rad;
   walcol=true;
 }
 } 
  
return walcol;
}
  
  void update() 
  {
   vy=vy+gravity/framerater-vy*abs(vy)/10/mass;
   vx=vx-vx*abs(vx)/10/mass;
 
 if (y>320-rad)
 
 { if (vy>=0)
 
 {
   vy=-vy;
   y=320-rad;
 }
 }


 if (y<rad)
 
 { if (vy<0)
 
 {
   vy=-vy;
   y=rad;
 }
 }
  
  if (x>480-rad)
 
 { if (vx>=0)
 
 {
   vx=-vx;
   x=480-rad;
 }
 }


 if (x<rad)
 
 { if (vx<0)
 
 {
   vx=-vx;
   x=rad;
 }
 }
  
 y=y+vy/framerater;
  x=x+vx/framerater;
}
  
   void render()
  
  {
    noStroke();
   fill(mass,mass,mass);
   ellipse(x,y,rad*2,rad*2);
  } 
  }
  
  class wall 
{
  
  float x[], y[];
  int points;


 wall(float ix[], float iy[], int npoints)
  
  {
    points=npoints;
   x=new float[points];
   x=ix;
  y=new float[points];
  y=iy;
  
    
  }
  
  
  
   void render()
  
  {
    stroke(255,255,255); 
    
   for (int count=0; count<points-1;count++)
   {
    line(x[count],y[count],x[count+1],y[count+1]); 
   }
   line(x[points-1],y[points-1],x[0],y[0]);
    
  }
}
  

