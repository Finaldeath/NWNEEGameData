//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    object oShip=GetObjectByTag("pirate_vessel");
    DestroyObject(oShip);
    SetLocalInt(GetModule(),"pirates_have_fled",1);
    //clean up routine
    //just in case the player snuck past the smugglers outside
    object oCrew1 = GetObjectByTag("db_firstmate");
    object oCrew2 = GetObjectByTag("db_barracudacleric");
    object oCrew3 = GetObjectByTag("db_barracudarog");
    if(GetIsObjectValid(oCrew1))
    {
        DestroyObject(oCrew1);
    }
    if(GetIsObjectValid(oCrew2))
    {
        DestroyObject(oCrew2);
    }
    if(GetIsObjectValid(oCrew3))
    {
        DestroyObject(oCrew3);
    }
}
