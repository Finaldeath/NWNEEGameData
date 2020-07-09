//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnDeath script for Roo the Rat
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:: Additions By: Anya Clancy
//:: Edited On: January 2, 2006
//:://////////////////////////////////////////////

void main()
{
object oPC = GetFirstPC();
SetLocalInt(oPC, "ac_rookill", 1);
CreateItemOnObject("ac_rooskin", oPC);
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0));
FloatingTextStringOnCreature("You pick up Roo's skin.", oPC);

ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
