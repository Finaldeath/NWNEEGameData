//::///////////////////////////////////////////////
//:: pus_a2_prisnsewr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player uses the grate in the prison to
    the sewers.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void CloseGrate(object oGrate);

void main()
{
    object oGrate = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oTarget = GetWaypointByTag("a2_sewers_prison");
    location lTarget = GetLocation(oTarget);

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        if (GetIsOpen(oGrate) == FALSE)
        {
            AssignCommand(oGrate, PlayAnimation(ANIMATION_PLACEABLE_OPEN));
        }

        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, JumpToLocation(lTarget));
        SetLocalInt(oTarget, "SEWER_ENABLED", TRUE);
        SetMapPinEnabled(oTarget, TRUE);

        DelayCommand(3.0f, CloseGrate(oGrate));
    }
}

// close the grate if it's open
void CloseGrate(object oGrate)
{
    if (GetIsOpen(oGrate) == TRUE)
    {
        AssignCommand(oGrate, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }
}
