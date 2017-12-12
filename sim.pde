//Copyright (C) 2013  Mihai Pruna,Joshua Gibson

//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU General Public License
//as published by the Free Software Foundation; either version 2
//of the License, or (at your option) any later version.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//http://www.gnu.org/licenses/gpl.html

//You should have received a copy of the GNU General Public License
//along with this program; if not, write to the Free Software
//Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

ball balls[];
float gravity=100;
int framerater=120;
int ballcount=1;
int timerer=0;
float wheel_radius=10;
float bottomdisp=5;
wall walls;
boolean wheel_on_ground=false;
  boolean stuck=false;
  float[] xs;
  float[] ys;
void newstart()
{
  stroke(255,255,255);
     strokeWeight(1);
  timerer=0;
  xs = new float[8]; 
  wheel_on_ground=false;
  stuck=false;
  xs[0] = 0; 
  xs[1] = 100; 
  xs[2] = 150; 
  xs[3]=200;
  xs[4]=250;
  xs[5]=300;
  xs[6]=350;
  xs[7]=400;
  ys = new float[8]; 
  
  ys[0] = 320-random(20); 
  ys[1] = ys[0]; 
  ys[2] = 320-random(20); 
    ys[3] = 320-random(20); 
  ys[4] = 320-random(20); 
  ys[5] = 320-random(20); 
  ys[6] = 320-random(20); 
  ys[7] = 320; 
  

  }
void setup()
{
    
  newstart();
 
   // ball(float ix, float iy, float ivx, float ivy, float irad,float imass)
   
   
    size(600,320);
   background(0);
   frameRate(framerater);
}

void draw()
{
   background(0);
   if  (timerer==0)
   {
     newstart();
 walls=new wall(xs,ys,8);
  
  balls=new ball[2];
 
     balls[0]=new ball(115,walls.y[0]-15,10,0,wheel_radius,255);
     balls[1]=new ball(15,walls.y[0]-15,10,0,wheel_radius,255);
   }
   //the drive wheel
   if (wheel_on_ground==true)
   {    vertex dv=new vertex(balls[0].vx,balls[0].vy);
        vertex scaleddv=dv.mult_scalar(20/dv.mag);
        balls[0].vx=scaleddv.x;
        balls[0].vy=scaleddv.y;
        if (balls[0].vx<0)
        {
           balls[0].vx=-balls[0].vx;
          //balls[0].vy=balls[0].vy; 
        }
   }
   wheel_on_ground=false;
  
  if (balls[0].x>500)
  {
    //setup();
  //timerer=0;
  //newstart();
    //exit();
   stuck=true; 
  }
  
  //line(balls[0].x,balls[0].y,balls[1].x,balls[1].y);
  if (stuck==true)
  {
    //pauses for 2 seconds
    int timeint=millis();
    while (millis()-timeint<3000)
    {
      //stroke(255,0,0);
          //line(fwbottom.x,fwbottom.y,rwbottom.x,rwbottom.y);
    }
    //delay(2000);
 //setup();
  //newstart();
   //exit();
  }
  if (stuck==false)
  {
  timerer=timerer+1;
  }
  else
  {
   timerer=0; 
  }
  walls.render();
  for (int i=0;i<=ballcount;i++)
  {
     for (int k=0;k<walls.points-1;k++)
     {
       boolean linecol=balls[i].checkline(walls.x[k],walls.y[k],walls.x[k+1],walls.y[k+1]); 
       if (i==0 && linecol==true)
       {
         wheel_on_ground=true; 
       }
       if (linecol==false)
       {
          boolean checkpt=balls[i].checkpt(walls.x[k],walls.y[k]);
          if (i==0 && checkpt==true)
          {
             wheel_on_ground=true; 
          }
       }
     }
     //boolean linecol=balls[i].checkline(walls.x[walls.points-1],walls.y[walls.points-1],walls.x[0],walls.y[0]);
     //if (i==0 && linecol==true)
     //{
       //wheel_on_ground=true; 
     //}
     boolean checkpt=balls[i].checkpt(walls.x[walls.points-1],walls.y[walls.points-1]);
     if (i==0 && checkpt==true)
     {
       wheel_on_ground=true; 
     }
     if (timerer/2==(int)(timerer/2))
     {
     balls[i].update(); 
     }
     balls[i].render();
   
   }


 
  //checking connection from drive wheel to rear wheel
 
   for (int i=0;i<ballcount;i++)
 
   {

      for (int j=i+1;j<=ballcount;j++)
      {
         if ((i!=j) && (sqrt(pow(balls[i].x-balls[j].x,2)+pow(balls[i].y-balls[j].y,2))!=50) && ((abs(balls[i].vx)>0) || (abs(balls[i].vy)>0) || (abs(balls[j].vx)>0) || (abs(balls[j].vy)>0)))
         {
     
    
     
            //project velocities to the line between wheels to keep connectivity
            vertex drive_vel=new vertex(balls[i].vx,balls[i].vy);
            vertex rear_vel=new vertex(balls[j].vx,balls[j].vy);
            vertex back2front=new vertex(balls[i].x-balls[j].x,balls[i].y-balls[j].y);
            vertex drive_proj=drive_vel.project(back2front);
            vertex rear_proj=rear_vel.project(back2front);
            //compute avg of vels projecxted on connecting line
            vertex avg_proj=new vertex((drive_proj.x+rear_proj.x)/2,(drive_proj.y+rear_proj.y)/2);
            //get the velocities minus the projected velocities
            vertex driveminproj=drive_proj.get_difference(drive_vel);
            vertex rearminproj=rear_proj.get_difference(rear_vel);
            //add average to hopefully keep the balls equidistant
            drive_vel=driveminproj.add_vector(avg_proj);
            rear_vel=rearminproj.add_vector(avg_proj);
            balls[i].vx=drive_vel.x;
            balls[i].vy=drive_vel.y;
           
            balls[j].vx=rear_vel.x;
            balls[j].vy=rear_vel.y;
            //also move the rear wheel
            vertex fw=new vertex(balls[i].x,balls[i].y);
            vertex rw=new vertex(balls[j].x,balls[j].y);
            vertex wheels=rw.get_difference(fw);
            vertex newdist=wheels.mult_scalar(50/wheels.mag);
            rw=newdist.get_difference(fw);
            balls[j].x=rw.x;
            balls[j].y=rw.y;
            
     
            /*
            balls[i].vx=(balls[i].vx+rear_proj.x)/2;
            balls[i].vy=(balls[i].vy+rear_proj.y)/2;
     
            balls[j].vx=(balls[j].vx+drive_proj.x)/2;
            balls[j].vy=(balls[j].vy+drive_proj.y)/2;
            */
     
    
            boolean colwall=balls[i].checkwall();
            if (i==0 && colwall==true)
            {
               wheel_on_ground=true; 
            }
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
     
     
//define segment and direction for wheel center line
  vertex fwcenter=new vertex(balls[0].x,balls[0].y);
  vertex rwcenter=new vertex(balls[1].x,balls[1].y);
  vertex connect=rwcenter.get_difference(fwcenter);
  vertex downaxle=connect.get_normal(true);
  downaxle=downaxle.mult_scalar(bottomdisp);
  vertex fwbottom=fwcenter.add_vector(downaxle);
  vertex rwbottom=rwcenter.add_vector(downaxle);
  segment vehiclebottom=new segment(fwbottom,rwbottom);
  //check with all slopes
 stuck=false;
  for (int k=0;k<walls.points-1;k++)
  {
     
     vertex wp1=new vertex(walls.x[k],walls.y[k]);
     vertex wp2=new vertex(walls.x[k+1],walls.y[k+1]);
     segment groundline=new segment(wp1,wp2);
     if (vehiclebottom.intersects_with(groundline)==true)
     {
       stuck=true; 
     }
  }     
//render connection line
  if (stuck==true)
  {
    
     stroke(255,1,1);
     strokeWeight(3);
     line(fwbottom.x,fwbottom.y,rwbottom.x,rwbottom.y);
     //redraw();
  }
  else
  {
    stroke(255,255,255);
    line(fwbottom.x,fwbottom.y,rwbottom.x,rwbottom.y);
  }
}

class ball 
{
  boolean nukeblow;
  float x, y;
  float rad;

  float vx, vy;
  float mass;
  float vmag;
  ball(float ix, float iy, float ivx, float ivy, float irad,float imass)
  {
    x=ix;
    y=iy;
    vx=ivx;
    vy=ivy;
    rad=irad;
    mass=imass;
    vmag=sqrt(pow(vx,2)+pow(vy,2));
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
      if (sqrt(pow(abx-x,2)+pow(aby-y,2))<=rad)
      { //replace this with project function
         vmag=sqrt(pow(vx,2)+pow(vy,2));
         float xabx=abx-x;
         float yaby=aby-y;
       
         float vtx=bx*(vx*bx+vy*by)/pow(magb,2);
         float vty=by*(vx*bx+vy*by)/pow(magb,2);
       
       
         float vnx=(vx-vtx);
         float vny=(vy-vty);
       
         if (vnx*xabx+vny*yaby>0)
         {
           linecol=true;
           vx=vtx;//-vnx;
           vy=vty;//-vny;
           vmag=sqrt(pow(vx,2)+pow(vy,2));
           //need 2 move differently
           x=x-vnx/framerater;
           y=y-vny/framerater;
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
    if (distance<rad)
    {
       float vprojx=(vx*ax+vy*ay)/pow(distance,2)*ax;
       float vprojy=(vx*ax+vy*ay)/pow(distance,2)*ay;
       float vnx=vx-vprojx;
       float vny=vy-vprojy;
       if (vprojx*ax+vprojy*ay>0)
       {
         vx=vnx;//-vprojx;
         vy=vny;//-vprojy;
         vmag=sqrt(pow(vx,2)+pow(vy,2));
         checkpt=true;
       }
    }
    return checkpt;  
  }
  boolean checkwall()
  {
     boolean walcol=false;
     if (y>320-rad)
 
     { 
       if (vy>=0)
 
       {
         vy=0;//-vy;
         y=320-rad;
         walcol=true;
       }
     }

     if (y<rad)
 
     { 
       if (vy<0)
 
       {
         vy=0;//-vy;
         y=rad;
         walcol=true;
       }
     }
  
     if (x>600-rad)
 
     { 
       if (vx>=0)
 
       {
         vx=-vx;
         x=600-rad;
         walcol=true;
       }
     }


     if (x<rad)
 
     { 
       if (vx<0)
 
       {
         vx=-vx;
         x=rad;
         walcol=true;
       }
     } 
     vmag=sqrt(pow(vx,2)+pow(vy,2));
     return walcol;
  }
  
  void update() 
  {
     vy=vy+gravity/framerater-vy*abs(vy)/10/mass;
     vx=vx-vx*abs(vx)/10/mass;
 
     if (y>320-rad)
 
     { 
       if (vy>=0)
 
       {
         vy=0;//-vy;
         y=320-rad;
       }
     }


     if (y<rad)
 
     { 
       if (vy<0)
 
       {
           vy=0;//-vy;
           y=rad;
       }
     }
  
     if (x>600-rad)
 
     { 
       if (vx>=0)
 
       {
         vx=-vx;
         x=600-rad;
       }
     }


     if (x<rad)
 
     { 
       if (vx<0)
 
       {
         vx=-vx;
         x=rad;
       }
     }
  
     y=y+vy/framerater;
     x=x+vx/framerater;
     vmag=sqrt(pow(vx,2)+pow(vy,2));
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
   //line(x[points-1],y[points-1],x[0],y[0]);
    
  }
}
//point
class vertex
{
   float x,y,mag;
   vertex(float in_x,float in_y)
   {
      x=in_x;
      y=in_y;
      mag=sqrt(pow(x,2)+pow(y,2));
   } 
   float get_distance(vertex other_vertex)
   {
     return sqrt(pow(x-other_vertex.x,2)+pow(y-other_vertex.y,2));
   }
   //returns vector that is the difference between the two points
   vertex get_difference(vertex tip)
   {
      vertex diff=new vertex(tip.x-x,tip.y-y);
      return diff; 
   }
   vertex add_vector(vertex other_vector)
   {
      return new vertex(x+other_vector.x,y+other_vector.y);
   }
   void set_mag()
   {
     mag=sqrt(pow(x,2)+pow(y,2));
   }
   /*
   //returns point of notmal
   vertex project_segment(segment my_seg)
   {
     
   }*/
   vertex project (vertex other_vector)
   {
     vertex projection;
     if (mag==0 || other_vector.mag==0)
     {
    
       return new vertex(0,0); 
     }
     else
     {
       projection=other_vector.mult_scalar(dotproduct(other_vector)/(other_vector.mag*other_vector.mag));
       projection.set_mag();
       return projection;
     }
     
   }
   vertex get_normalized()
   {
      if (mag==0)
     {
        return new vertex(0,0);
     } 
     else
     {
        return new vertex(x/mag,y/mag); 
     }
   }
   vertex mult_scalar(float scalar)
   {
      vertex multiplied=new vertex(x*scalar,y*scalar);
      multiplied.set_mag();
      return  multiplied;
   }
   float dotproduct(vertex other_vector)
   {
      return (x*other_vector.x+y*other_vector.y); 
   }
   //y over x
   float get_slope()
   {
     if (x==0 && y!=0)
     {
       return 9999999;
     }
     else if (x==0 && y==0)
     {
       return 0; 
     }
     else
     {
       return y/x; 
     }
   }
   //gets a vector normal pointing up or down
   vertex get_normal(boolean up)
   {
     vertex the_normal=new vertex(-y,x);
     
        
     /*if (this.get_slope()==0)
     {
       if (up==true)
       {
         the_normal.x=0;
         the_normal.y=1;
       }
      else
       {
         the_normal.x=0;
        the_normal.y=-1; 
       }
     }
     else if (this.get_slope()==9999999)
     {
       
      the_normal.x=1;
     the_normal.y=0; 
     }
     else
     {
       vertex the_normal1=new vertex(0,0); 
       //the_normal1.x=1;
        //the_normal1.y=-1/this.get_slope(); 
        the_normal1.x=-y;
        the_normal1.y=x;
        if (the_normal1.y<0 && up==true)
        {
          the_normal=the_normal1.mult_scalar(-1); 
        } else
        if (the_normal1.y>0 && up==false)
        {
         the_normal=the_normal1.mult_scalar(-1); 
        }
      
     }*/
     if (the_normal.y<0 && up==true)
        {
          the_normal=the_normal.mult_scalar(-1); 
        } else
        if (the_normal.y>0 && up==false)
        {
         the_normal=the_normal.mult_scalar(-1); 
        }
        the_normal=the_normal.get_normalized();
    return the_normal;
   }
 }
 
  //line segment
 class segment
 {
    vertex p1;
    vertex p2;
    float length;
    segment(vertex in_p1,vertex in_p2)
    {
       p1=in_p1;
       p2=in_p2;
       length=p1.get_distance(p2);
    }
    //returns unit vector perp on segment in the direction of another point
    /*
    vertex normal_vector(vertex plane_side)
    {
       vertex dir=p1.get_difference(p2);
              
    } */
    boolean intersects_with(segment other_segment)
    {
      //solve systme of two equations to get line intersection
      //y=ax+b
      //for this segment
      float x11,x12,y11,y12,a1,b1,x21,x22,y21,y22,a2,b2,int_x,int_y;
      y12=p2.y;
      y11=p1.y;
      x11=p1.x;
      x12=p2.x;
      if (y11==y12 && x11==x12)
      {
        return false;
      }
      //cheat a bit to use the same eqn for hor and vert lines
      else if (y11==y12)
      {
        y12+=y12*0.0001;
      }
      else if (x11==x12)
      {
       x12+=x12*0.0001; 
      }
      //slope components
      a1=(y12-y11)/(x12-x11);
      b1=y11-x11*(y12-y11)/(x12-x11);
      //for the other segment
      y22=other_segment.p2.y;
      y21=other_segment.p1.y;
      x21=other_segment.p1.x;
      x22=other_segment.p2.x;
      if (y21==y22 && x21==x22)
      {
        return false;
      }
      //cheat a bit to use the same eqn for hor and vert lines
      else if (y21==y22)
      {
        y22-=y22*0.0001;
      }
      else if (x21==x22)
      {
        x22-=x22*0.0001; 
      }
      //slope components
      a2=(y22-y21)/(x22-x21);
      b2=y21-x21*(y22-y21)/(x22-x21);
      int_x=(b2-b1)/(a1-a2);
      int_y=a1*int_x+b1;
      boolean on_seg1=false;
      boolean on_seg2=false;
      if (abs(int_x-x11)<=abs(x12-x11) && abs(int_x-x12)<=abs(x12-x11)  && abs(int_y-y11)<=abs(y12-y11) && abs(int_y-y12)<=abs(y12-y11)) on_seg1=true;
      if (abs(int_x-x21)<=abs(x22-x21) && abs(int_x-x22)<=abs(x22-x21)  && abs(int_y-y21)<=abs(y22-y21) && abs(int_y-y22)<=abs(y22-y21)) on_seg2=true;
      if (on_seg1==true && on_seg2==true)
      {
        return true; 
      }
      else
      {
        return false; 
      }
    }
  }

