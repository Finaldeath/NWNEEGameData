#include "inc_transform"

void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetEnteringObject();
    location locPC;
    object oObject;
    float fScale,fHeight,fSideways,fForward,fRotate,fSpinX,fSpinY;
    int nUseable,nVfx;
    effect eVfx;

    //Wait until a player enters the area to check,
    //Both to avoid overload and to use the PC as a location point
    if (GetIsObjectValid(oPC))
    {
        locPC = GetLocation(oPC);
        oObject =GetFirstObjectInArea(oArea);
        if (oObject == oPC)
        {
            oObject = GetNextObjectInArea(oArea);
        }

        while (GetIsObjectValid(oObject))
        {
            // Only read these values if object isn't initiated
            if (!GetLocalInt(oObject,"TM_TRANSFORM_SET") && GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE||OBJECT_TYPE_ITEM||OBJECT_TYPE_CREATURE)
            {
                SetLocalInt(oObject,"TM_TRANSFORM_SET",TRUE);

                // Check to see if a designer set any values on the object
                fScale = GetLocalFloat(oObject,"TM_SCALE");
                fHeight = GetLocalFloat(oObject,"TM_HEIGHT");
                fSideways = GetLocalFloat(oObject,"TM_SIDEWAYS");
                fForward = GetLocalFloat(oObject,"TM_FORWARD");
                fRotate = GetLocalFloat(oObject,"TM_ROTATE");
                fSpinX = GetLocalFloat(oObject,"TM_SPIN_X");
                fSpinY = GetLocalFloat(oObject,"TM_SPIN_Y");
                nVfx = GetLocalInt(oObject,"TM_VFX");
                nUseable = GetLocalInt(oObject,"TM_KEEP_USEABLE");

                if (fScale != 0.0)
                {
                    ShrinkOrGrow(oObject,fScale);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fHeight != 0.0)
                {
                    Levitate(oObject,fHeight);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fSideways != 0.0)
                {
                    MoveSideways(oObject,fSideways);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fForward != 0.0)
                {
                    MoveForward(oObject,fForward);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fRotate != 0.0)
                {
                    Rotate(oObject,fRotate);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fSpinX != 0.0)
                {
                    SpinX(oObject,fSpinX);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (fSpinY != 0.0)
                {
                    SpinY(oObject,fSpinY);
                    CheckForPlaceables(oObject,nUseable);
                }
                if (nVfx > 0)
                {
                    eVfx = EffectVisualEffect(nVfx);
                    eVfx = SupernaturalEffect(eVfx);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eVfx,oObject);
                    CheckForPlaceables(oObject,nUseable);
                }
            }
            oObject = GetNextObjectInArea(oArea);
        }
    }
}
