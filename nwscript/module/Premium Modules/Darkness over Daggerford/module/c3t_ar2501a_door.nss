//::///////////////////////////////////////////////
//::
//:: c3t_ar2501a_door
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Area Transition script for door.
//::
//:: Seals the entrance to Illefarn behind the player.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_xp"

void main()
{
    object oEnterer = GetEnteringObject();

    if (GetLocalInt(OBJECT_SELF, "nBeenSealed") == 0)
    {
        AssignCommand(oEnterer, ClearAllActions());

        effect eFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, OBJECT_SELF);

        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_PURPLE);
        DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, OBJECT_SELF));

        ActionCloseDoor(OBJECT_SELF);

        DelayCommand(0.2, FloatingTextStringOnCreature("The door just closed!", oEnterer));

        SetLocalInt(OBJECT_SELF, "nBeenSealed", 1);

        return;
    }
    else
    {
        object oTarget = GetTransitionTarget(OBJECT_SELF);
        location lLoc = GetLocation(oTarget);
        AssignCommand(oEnterer, JumpToLocation(lLoc));

        // check for journal update
        string sJournal = "j21"; // relevant quest
        int nStatus = 10;        // status

        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
        if (GetLocalInt(oEnterer, sJournalVar) < nStatus)
        {
            // player needs an update
            AddJournalQuestEntry(sJournal, nStatus, oEnterer, FALSE);

            // player needx XP for quest completion
            int nXP = GetJournalQuestExperience(sJournal);
            if (nXP > 0)
            {
               // GiveXPToCreature(oEnterer, nXP);
               GiveQuestXPToCreature(oEnterer, sJournal, 100.0);
            }
        }
    }
}
