//::///////////////////////////////////////////////
//::
//:: a3_oo_bw_door
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Open script for doors/placeables.
//::
//:: Handles code for doors/placeables in Illefarn.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/3/2005
//::
//:://////////////////////////////////////////////

void main()
{
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "ar2504_torture_door")
    {
        int nNth = 0;
        object oSound = GetObjectByTag("c1ar2504_pris_sound", nNth);

        while (GetIsObjectValid(oSound))
        {
            SoundObjectStop(oSound);
            DestroyObject(oSound);

            nNth += 1;
            oSound = GetObjectByTag("c1ar2504_pris_sound", nNth);
        }
    }
}
