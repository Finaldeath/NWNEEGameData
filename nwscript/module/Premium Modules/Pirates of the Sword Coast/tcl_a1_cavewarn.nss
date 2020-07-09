//::///////////////////////////////////////////////
//:: Act 1: Jelly Cave Warning
//:: TCL_A1_CaveWarn.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Launches a warning conversation prior to
     letting the player enter the Jelly Cave.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 23, 2005
//:://////////////////////////////////////////////

void main()
{
    //Standard blockade against possessed familiars.
    object oClicker = GetClickingObject();
    if (GetIsPossessedFamiliar(oClicker) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oClicker);
    }

    //Don't let hostiles through
    else if (GetIsPC(oClicker) == TRUE)
    {
        //Warn the player.
        ActionStartConversation(oClicker);

        //Handle transition
        object oTarget = GetTransitionTarget(OBJECT_SELF);
        //SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
        AssignCommand(oClicker,JumpToObject(oTarget));

    }

    //And let other creatures transition normally
    else
    {
    }
}
