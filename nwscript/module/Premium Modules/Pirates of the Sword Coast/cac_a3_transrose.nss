//::///////////////////////////////////////////////
//:: cac_a3_transrose
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the player from the island of the dead
    to the seige init cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oModule = GetModule();
    object oCursor = OBJECT_INVALID;
    object oTarget = GetObjectByTag("A3_SGI_PCJUMP");
    object oNPCCrew = OBJECT_INVALID;
    int iCounter = 1;
    string sNPCTag;

    // cycle through the players and move them.
    oCursor = GetFirstPC();

    SetLocalInt(oModule, "A3_DEAD", 60);
    AddJournalQuestEntry("a3_dead", 60, GetPCSpeaker(), TRUE, TRUE);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        FadeToBlack(oCursor);
        DelayCommand(1.5, RemovePolymorph(oCursor));
        // JE: JumpToObject is not reliable
        //DelayCommand(2.0f, AssignCommand(oCursor, JumpToObject(oTarget)));
        DelayCommand(2.0, JumpPCsToLocation(GetLocation(oTarget), 0, oCursor));
        DelayCommand(2.0f, ForceRest(oCursor));
        DelayCommand(2.0f, StopFade(oCursor));

        oCursor = GetNextPC();
    }

    // The crew cheers.
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));

    while (sNPCTag != "")
    {
        oNPCCrew = GetObjectByTag(sNPCTag);
        AssignCommand(oNPCCrew, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));

        iCounter++;
        sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
    }
}
