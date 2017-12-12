//Copyright (C) 2012  Mihai Pruna

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
//ten points x and y
int[] xs = new int[10];
int[] ys = new int[10];
//arraylist for points
ArrayList points;
//arraylist for lines
ArrayList lines;
//arraylist for triangles
ArrayList triangles;
//intersect check variable
boolean intersect=false;

//this function does the calculation (processing format)
void setup() {
  //set up drawing area
  size(400, 400, P2D);
 int lastx=0;
 int lasty=0;
//generate 10 random points
 for(int i=0; i < 10; i++) {
  xs[i]=(int)random(400);
  ys[i]=(int)random(400);
  
 if (i!=0)
 {
   boolean degenerate=true;
   while (degenerate==true)
  {
    degenerate=false;
    xs[i]=(int)random(400);
  ys[i]=(int)random(400);
   for (int j=0;j<i;j++)
   {
     if (abs(xs[i]-xs[j])<20 || abs(ys[i]-ys[j])<20)
     {
      degenerate=true; 
     }
     
   }
   
   
  } 
  
 }
  
}
//order points
 for(int i1=0; i1 < 10; i1++) 
 {
  for (int i2=0;i2<10;i2++)
  {
  
    if (i2>i1 && xs[i2]<xs[i1])
    {
     
      int swap=xs[i2];
      xs[i2]=xs[i1];
      xs[i1]=swap;
      
      swap=ys[i2];
      ys[i2]=ys[i1];
      ys[i1]=swap;
      
          
      
    }
    
  
  }
 }
points=new ArrayList();
//initilize object and add points to point arraylist
for (int i=0;i<10;i++)
{
   dpt poi=new dpt(xs[i],ys[i]);
   points.add(poi); 
}


//generate triangles
triangles=new ArrayList();
boolean added=true;
//goes until it cannot add any more triangles
while (added==true)
{
  added=false;
for (int i=0;i<points.size()-2;i++)
{
  for (int j=i+1;j<points.size()-1;j++)
 
 {
   for (int k=j+1;k<points.size();k++)
   {
   
     //initialize candidate triangle
     dtriangle tes=new dtriangle();
     tes.po1=(dpt) points.get(i);
     tes.po2=(dpt) points.get(j);
     tes.po3=(dpt) points.get(k); 
      ArrayList teslines=new ArrayList();
      teslines.add(new dline(tes.po1,tes.po2));
      teslines.add(new dline(tes.po2,tes.po3));
      teslines.add(new dline(tes.po3,tes.po1));
      
      
     //check if triangle has already been added using the average of the 3 points method, also to check if the triangle's lines intersect the other's lines
     boolean ft=false;
     for (int l=0;l<triangles.size();l++)
     {
     
       dtriangle othertriangle=(dtriangle)triangles.get(l);
       if (othertriangle.averagex()==tes.averagex() && othertriangle.averagey()==tes.averagey())
       {
         ft=true;
         break;
       }
      else
       {
         boolean it=false;
        ArrayList otherlines=new ArrayList();
        otherlines.add(new dline(othertriangle.po1,othertriangle.po2));
        otherlines.add(new dline(othertriangle.po2,othertriangle.po3));
        otherlines.add(new dline(othertriangle.po3,othertriangle.po1));
        for (int tlc=0;tlc<teslines.size();tlc++)
          {
            dline tline=(dline) teslines.get(tlc);
            for (int olc=0;olc<otherlines.size();olc++)
            {
              dline oline=(dline) otherlines.get(olc);    
              it=oline.segmentintersect(tline);
              if (it==true)
              {
                break;
              }
            }
          if (it==true)
          {
            break;
          }
          }
        if (it==true)
        {
         ft=true;
         break; 
        }
       } 
     }
     //now we check if there are points inside that triangle
    if (ft==false)
    {
       //now we check if there are points inside that triangle
       boolean fp=false;
       for (int n=0;n<points.size();n++)
       {
         
         if (n!=i && n!=j && n!=k)
         {
            fp=tes.pointincircle((dpt) points.get(n));
            if (fp==true)
            {
             break; 
            }
        
         } 
       }
      if (fp==false)
      {
        
        
        
       added=true;
      triangles.add(tes);
     break; 
      }
      
    }
    
   }
   if (added==true)
    {
       break; 
    }
 
 
 }
  if (added==true)
  {
       break; 
  }
}
}



println(triangles.size());



 noLoop();
 }
 
 void draw() {
 background(255,255,255);
 
   
   for (int i=0;i<triangles.size();i++)
   {
     dtriangle t1=(dtriangle) triangles.get(i);
   fill(random(200),random(200),random(200));
 dpt p1=(dpt)(t1.po1);
 dpt p2=(dpt)(t1.po2);
 dpt p3=(dpt)(t1.po3);
 triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
 }
    for (int i=0;i<points.size();i++)
   {
     
   fill(0,0,0);
 dpt p1=(dpt)(points.get(i));
 
ellipse(p1.x,p1.y,10,10);

 }
 
    
 }
//class to store points
class dpt
{
  int x;
  int y; 

  dpt(int xi,int yi)
  {
   x=xi;
   y=yi; 
  }
  float getdistance(dpt otherp)
  {
    
   return  (float)(sqrt(pow(x-otherp.x,2)+pow(y-otherp.y,2)));  
  }
}

//class to store lines
class dline
{
   dpt p1;
   dpt p2;
   int numtriangles;
   int numintersects;
   boolean toremove;
   dline(dpt po1,dpt po2)
   {
     p1=po1;
     p2=po2;
     numtriangles=0;
     numintersects=0;
     toremove=false;
   } 
  float getlength()
  {
    
   return (float)sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2)); 
  }
  //check if two line segments intersect
boolean segmentintersect(dline otherline)
{
  dpt l1p1=p1;
  dpt l1p2=p2;
  dpt l2p1=otherline.p1;
  dpt l2p2=otherline.p2;
  int x1=l1p1.x;
  int x2=l1p2.x;
  int y1=l1p1.y;
  int y2=l1p2.y;
  int x3=l2p1.x;
  int x4=l2p2.x;
  int y3=l2p1.y;
  int y4=l2p2.y;
  if (l1p1.getdistance(l2p1)>2 && l1p2.getdistance(l2p2)>2 && l1p1.getdistance(l2p2)>2 && l1p2.getdistance(l2p1)>2)
  {

 float ua=0; 
  try
  {
    float d1=(float)((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3));
    float d2=(float)((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
  ua=(float)(d1/d2);
  }
  catch(Exception e)
  {
  
   return false; 
  }
  float ub=0; 
  try
  {

    float d1=(float)((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3));
    float d2=(float)((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
    ub=(float)(d1/d2);

  }
  catch(Exception e)
  {
   return false; 
  }
 
  if (ua>0.01 && ua<0.99  && ub>0.01 && ub<0.99)
  {
 
   //  numintersects++;
   return true; 
  
  }
  
  else
  {
    return false;
  }
  }
  
  else
  {
   return false; 
  }
  
}
}
//class to store triangles
class dtriangle
{
 dpt po1;
 dpt po2;
 dpt po3;
 int xcenter;
 int ycenter;
 dtriangle ()
 {
  po1=new dpt(0,0);
  po2=new dpt(0,0);
  po3=new dpt(0,0);
  xcenter=0;
  ycenter=0;
 }
 int averagex()
 {
    return (int)((po1.x+po2.x+po3.x)/3); 
 }
 int averagey()
 {
    return (int)((po1.y+po2.y+po3.y)/3); 
 }
  

//get radius from center and point
int getradius()
{
  int x1=po1.x;
  int y1=po1.y;
  int radius=(int)sqrt(pow(x1-xcenter,2)+pow(y1-ycenter,2));

return radius; 
}

//get circle center from triangle with 3 points
int getxcenter()
{
  int x1=po1.x;
  int y1=po1.y;
  int x2=po2.x;
  int y2=po2.y;
  int x3=po3.x;
  int y3=po3.y;
  try
  {
   xcenter=(int)((pow(x1,2)+pow(y1,2))*(y2-y3) + (pow(x2,2)+pow(y2,2))*(y3-y1) + (pow(x3,2)+pow(y3,2))*(y1-y2))/(2*(x1*y2 - x2*y1 - x1*y3 + x3*y1 + x2*y3 - x3*y2));
  }
  catch(Exception e)
  {
   xcenter=averagex(); 
  }
  return xcenter; 
}
//get the y center
int getycenter()
{
  
  int x1=po1.x;
  int y1=po1.y;
  int x2=po2.x;
  int y2=po2.y;
  int x3=po3.x;
  int y3=po3.y;
  try
  {
    ycenter=(int)((pow(x1,2)+pow(y1,2))*(x3-x2) + (pow(x2,2)+pow(y2,2))*(x1-x3) + (pow(x3,2)+pow(y3,2))*(x2-x1))/(2*(x1*y2 - x2*y1 - x1*y3 + x3*y1 + x2*y3 - x3*y2));
  }
  catch(Exception e)
  {
   ycenter=averagey(); 
  }
  return ycenter; 
}


 
 //verifies if a point is in a circle
 boolean pointincircle(dpt pt)
 {
  int xpt=pt.x;
  int ypt=pt.y;
  xcenter=getxcenter();
  ycenter=getycenter();

  if (getradius()>sqrt(pow(xpt-xcenter,2)+pow(ypt-ycenter,2)))
  {
   return true; 
  }
  else
  { 
    return false;
  }
 }
 
}


 

 
 
 
