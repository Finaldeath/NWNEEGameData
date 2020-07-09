//::///////////////////////////////////////////////
//:: phb_a1_cavefire
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The hearbeat event used to change the size of
    the fires in the pits.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////
void main()
{
    object oSelf = OBJECT_SELF;
    object oWPFire = GetNearestObjectByTag("a1_cavefire");
    object oFire = GetNearestObjectByTag("a1_currfire");

    location lFire = GetLocation(oWPFire);
    int iCounter = GetLocalInt(oSelf, "iFIREHEIGHT");

    if (GetArea(oFire) == GetArea(oSelf))
    {
        // if the fuel value is greater then 15 make a large fire
        if (iCounter > 15)
        {
            DestroyObject(oFire, 0.2f);
            CreateObject(OBJECT_TYPE_PLACEABLE, "a1_firelrg", lFire, TRUE, "a1_currfire");

            iCounter--;
        }
        // if it's greater then five make a medium fire
        else if (iCounter > 5)
        {
            DestroyObject(oFire, 0.2f);
            CreateObject(OBJECT_TYPE_PLACEABLE, "a1_firemed", lFire, TRUE, "a1_currfire");
            iCounter--;
        }
        // if it's greater then 0 make a small fire
        else if (iCounter > 0)
        {
            DestroyObject(oFire, 0.2f);
            CreateObject(OBJECT_TYPE_PLACEABLE, "a1_firesmall", lFire, TRUE, "a1_currfire");
            iCounter--;
        }
        // the fire is too small, kill it and turn off the pit.
        else
        {
            DestroyObject(oFire);
        }

        SetLocalInt(oSelf, "iFIREHEIGHT", iCounter);
    }
}
