int iterations;
Vector2 centrePos;
float centrePointDiameter; 

boolean isSceneDrawn ;

Shape[] allShapes;
int numShapes;

int shapeLength;

boolean isClicked;
Vector2 prevMousePos;

color fillCol;
color strokeCol;

float centrePosJump;  // when key pressed, how far should the centre point move?

void setup()
{
  size(1900, 800);
  background(255);
  initValues();
}

void draw()
{
  if (!isSceneDrawn)
    isSceneDrawn = drawScene();
}


void mousePressed()
{
  isClicked = true;
  prevMousePos.x = mouseX;
  prevMousePos.y = mouseY;
}



void mouseDragged() 
{

  for (int i =0; i < numShapes; i++)
  {
    allShapes[i].pos.x += mouseX - prevMousePos.x;
    allShapes[i].pos.y += mouseY - prevMousePos.y;
    allShapes[i].calcDistFromCentre(centrePos);
  }
  prevMousePos.x = mouseX;
  prevMousePos.y = mouseY;
  isSceneDrawn = false;
  allShapes = sortShapes(allShapes);
}



void mouseReleased() 
{

  isClicked = false;
}

void keyPressed()
{
  if(key == 'a' || key == 'A')
  {
    centrePos.x -= centrePosJump;
  }
  if(key == 'd' || key == 'D')
  {
    centrePos.x += centrePosJump;
  }
  if(key == 'w' || key == 'W')
  {
    centrePos.y -= centrePosJump;
  }
  if(key == 's' || key == 'S')
  {
    centrePos.y += centrePosJump;
  }
  
  isSceneDrawn = false;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  shapeLength -= e * 10;
  isSceneDrawn = false;
}

void initValues()
{
  // how many iterations should each shape be drawn with, determines side smoothness
  iterations = 200;
  // determines the perspective disappearing point
  centrePos = new Vector2(width/2, height/2);
  // sets the width of the centre point UI dot
  centrePointDiameter = 10.0f;
  // sets if the scene is drawn
  isSceneDrawn = false;
  // stores the previous mouse position for moving shapes around the screen
  prevMousePos = new Vector2(0.0f, 0.0f);

  // how far to the horizon line should the shape be drawn before it stops
  shapeLength = 100;

  // the colours for the fill and stroke
  fillCol = color(255);
  strokeCol = color(255, 0, 0, 255);

  // set the number of shapes on screen
  numShapes = 7;

centrePosJump = 50;

  // init shape array and each shape within it
  allShapes = new Shape[numShapes];
  for (int i = 0; i < numShapes; i++)
  {
    allShapes[i] = new Shape(new Vector2(random(width / 4, width/1.5), random(height)), new Vector2(random(200), random(200)), 0, centrePos);
  }
}


void drawCentreDot()
{
  // mark specified centre
  fill(0);
  ellipse(centrePos.x, centrePos.y, centrePointDiameter, centrePointDiameter);
}



boolean drawScene() 
{
  background(255);

  // draw disappearing point
  drawCentreDot();

  // draw each shape
  for (int i = 0; i < numShapes; i++)
  {
    drawShape(allShapes[i]);
  }

  return true;
}

void drawShape(Shape shape)
{
  // while not at centre
  // draw ellipse then subtract or add one in both the y and x coord
  fill(strokeCol);
  stroke(strokeCol);


  float diffX = shape.pos.x - centrePos.x;
  float diffY = shape.pos.y - centrePos.y;

  float stepX = diffX/ iterations;
  float stepY = diffY/ iterations;

  for (int i = 0; i < iterations; i++)
  {
    ellipse(
      shape.pos.x - (i*stepX), 
      shape.pos.y - (i *stepY), 
      shape.size.x - (i * (shape.size.x/iterations)), 
      shape.size.y - (i * (shape.size.y/iterations))
      );


    if (i > shapeLength)
      break;
  }

  fill(fillCol);
  ellipse(
    shape.pos.x, 
    shape.pos.y, 
    shape.size.x, 
    shape.size.y
    );
  // ellipse(shape.pos.x, shape.pos.y, 40,40);
}

Shape[] sortShapes(Shape[] oldShapes)
{
  Shape[] newShapes = oldShapes;

  for (int i = 0; i < newShapes.length; i++)
  {
    for (int j = 0; j < newShapes.length; j++)
    {
      if (i != newShapes.length -1)
      {

        if (newShapes[i].distFromCentre < newShapes[i+1].distFromCentre)
        {
          Shape tempShape = newShapes[i];
          newShapes[i]= newShapes[i+1];
          newShapes[i+1] = tempShape;
        }
      }
    }
  }

  return newShapes;
}
