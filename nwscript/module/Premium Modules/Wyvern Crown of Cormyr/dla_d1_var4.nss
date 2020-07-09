//::///////////////////////////////////////////////
//:: dla_d1_var4
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

The horse_var scripts are used to store on the PC an integer for the
conversation which at the end, determines which horse is bought. The first time
they are called it sets the tens place for the integer. The second time it is
called, it sets the ones place. These scripts are written from scratch, but the
idea was taken from the DMFI. -DS

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 7, 2005
//:://////////////////////////////////////////////
//:: Last Updated By:
//:: Last Updated On:

#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    int iHorseVar = GetLocalInt(oPC, "iHorseVar");

    //if this variable is unset... we're on the first run through. Set to
    //chosen variable.
    if(iHorseVar == 0)
    {
        SetLocalInt(oPC, "iHorseVar", 4);
    }
    //not the first time through, set current number to tens position, then
    //add the chosen variable and buy
    else
    {
        SetLocalInt(oPC, "iHorseVar", (iHorseVar * 10) + 4);
    }
}
