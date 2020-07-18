
enum ShapeType 
{ 
  CIRCLE, CUBE, TRI
}

public class Shape
{

  Vector2 pos;
  Vector2 size;
  float distFromCentre;
  String shapeName;
  float depth;
  ShapeType shape;


  Shape(Vector2 newPos, Vector2 newSize, float newDepth, Vector2 centrePos)
  {
    pos = newPos;
    size = newSize;
    depth = newDepth;
    calcDistFromCentre(centrePos);
    //shape = drawRandomShape();
  }


  ShapeType randomShape()
  {
    int rand = (int)random(2);

    switch(rand)
    {
    case 0:
      return ShapeType.CIRCLE;
    case 1:
      return ShapeType.CUBE;
    default:
      return ShapeType.CIRCLE;
    }
  }

  void calcDistFromCentre(Vector2 centrePos)
  {
    float diffX = pos.x - centrePos.x;
    float diffY = pos.y - centrePos.y;

    float dist = sqrt((diffX * diffX) + (diffY * diffY));
    distFromCentre = dist;
  }
}
