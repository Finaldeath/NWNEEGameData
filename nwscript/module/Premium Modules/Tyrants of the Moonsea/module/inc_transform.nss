
/*   By Bill Harper, 2018/05/04
        Various functions for transforming an object using new scripting commands
        Note that object's original facing is relevant to all calculations,
        So if this is important in your scene be sure to SetFacing() first!  */

 //  The functions needed some changes made for the weapon pivot offsets. They don't move the same way


//Sets the scale of the object to the given float size (1.0 = Default)
//oMover = Object to Change Size
//fSize = New size of object
void ShrinkOrGrow(object oMover, float fSize);

//Sets the height of the object to the given float (0.0 = Default)
//oMover = Object to move
//fHeight = z position adjustment of object
void Levitate(object oMover, float fHeight);

//Sets the x position of the object to the given float (0.0 = Default)
//oMover = Object to move
//fDistance = x position adjustment of object
void MoveSideways(object oMover, float fDistance);

//Sets the x position of the object to the given float (0.0 = Default)
//oMover = Object to move
//fDistance = y position adjustment of object
void MoveForward(object oMover, float fDistance);

//Sets the z rotation of the object to the given float (0.0 = Default)  --yes it uses ROTATE_X
//oMover = Object to rotate
//fDegree = degrees rotation of object
void Rotate(object oMover, float fDegree);

//Sets the y rotation of the object to the given float (0.0 = Default)  --yes it uses ROTATE_Z
//oMover = Object to rotate
//fDegree = degrees rotation of object
void SpinY(object oMover, float fDegree);

//Sets the x rotation of the object to the given float (0.0 = Default)  --yes it uses ROTATE_Y
//oMover = Object to rotate
//fDegree = degrees rotation of object
void SpinX(object oMover, float fDegree);

//Check if the altered oObject was a placeable, and if or not it has a local int
// nUseable set ("TM_KEEP_USEABLE"). If this value is TRUE, the placeable will
// remain usable afterwards. Otherwise the placeable will be set to unusable.
void CheckForPlaceables(object oObject, int nUseable);



void ShrinkOrGrow(object oMover, float fSize)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_SCALE,fSize);
     return;
}

void Levitate(object oMover, float fHeight)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z,(fHeight));
     return;
}

void MoveSideways(object oMover, float fDistance)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_TRANSLATE_X,fDistance);
     return;
}

void MoveForward(object oMover, float fDistance)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_TRANSLATE_Y,fDistance);
     return;
}

void Rotate(object oMover, float fDegree)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_ROTATE_X,fDegree);
     return;
}

void SpinY(object oMover, float fDegree)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_ROTATE_Z,fDegree);
     return;
}

void SpinX(object oMover, float fDegree)
{
     SetObjectVisualTransform(oMover,OBJECT_VISUAL_TRANSFORM_ROTATE_Y,fDegree);
     return;
}

void CheckForPlaceables(object oObject, int nUseable)
{
    // Only checks useable flag on placeables
    if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE && !nUseable && GetUseableFlag(oObject))
    {
        object oArea = GetArea(oObject);
        AssignCommand(oArea,SetUseableFlag(oObject,FALSE));
    }
}

