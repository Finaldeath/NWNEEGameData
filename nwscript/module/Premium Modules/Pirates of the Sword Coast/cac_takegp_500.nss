//::///////////////////////////////////////////////
//:: cac_takegp_500
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Take 500 Gold from the player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(500, oPC);
}