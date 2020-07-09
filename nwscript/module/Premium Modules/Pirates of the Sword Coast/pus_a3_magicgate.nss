//::///////////////////////////////////////////////
//:: pus_a3_magicgate
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A PC has tried to enter the seplture area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"

void main()
{
    object oSelf = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oTarget = GetWaypointByTag("A3_DEADPNT1");
    object oCursor = OBJECT_INVALID;

    location lTarg = GetLocation(oTarget);
    int iOpen = GetLocalInt(oSelf, "OPEN_GATE");

    if (iOpen == TRUE)
    {
        //Restrict Possessed Familiars
        if (GetIsPossessedFamiliar(oUser) == TRUE)
        {
            string sMessage = "You dare not stray far from your master.";
            FloatingTextStringOnCreature(sMessage, oUser);
        }
        else
        {
            //force all players not in the sepultre, into the sepultre
            oCursor = GetFirstPC();
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                if (GetArea(oCursor) != GetArea(oTarget))
                {
                    RemovePolymorph(oCursor);
                    AssignCommand(oCursor, JumpToLocation(lTarg));
                }

                oCursor = GetNextPC();
            }
        }
    }
}
