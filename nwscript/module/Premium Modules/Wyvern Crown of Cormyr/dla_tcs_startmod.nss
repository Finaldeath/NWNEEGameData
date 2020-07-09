// Ongoing
// B W-Husey/Syrsnein
// Now called from a trigger in the woodcutter area.
// Last modified May 3rd 2006
// Sets up Deities and henchman of the entering PC, background journal entries, xp and then continues dialogue

#include "cu_functions"
#include "x0_i0_henchman"
#include "dla_i0_csintro"

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsDefPC(oPC) || !GetLocalInt(OBJECT_SELF, "bActive")) return;

    SetLocalInt(OBJECT_SELF, "bActive", FALSE);

    if (!GetLocalInt(oPC,"nModStarted"))  //Change if you want multiplayer
    {
        // Add journal entries
        AllParty("nMainPlot",oPC,1);
        DeleteLocalInt(oPC, "dla_joust_state");
        AddJournalQuestEntry("MainPlot",10,oPC,TRUE);
        AddJournalQuestEntry("Background",1,oPC,TRUE);
        AddJournalQuestEntry("Henchmen",1,oPC,TRUE);
        AddJournalQuestEntry("Notes",1,oPC,TRUE);

        // Set up Jonas
        object oJonas = JonasRace(GetRacialType(oPC),GetLocation(GetWaypointByTag(CS_StartJonas)));
        SetDeity(oJonas, GetDeity(oPC));
        SetCustomToken(2301, GetDeity(oJonas));
//        LevelUpHenchman(oJonas);
        // Set up Godfroy
        object oGodfroy = GetObjectByTag(CS_Godfroy);
        SetDeity(oGodfroy, "Tyr");
//        LevelUpHenchman(oGodfroy);


        // Start cutscene here
        TurnToFaceObject(oJonas, oPC);
        float fFacing = GetFacing(oPC);
        StartCutscene(oPC, fFacing, 10.0, 55.0);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);

        SetLocalInt(oPC,"nModStarted",1);

        object oPC = GetEnteringObject();
        if (!GetIsDefPC(oPC)) return;

        if (GetLocalInt(OBJECT_SELF, "dla_cv_csintro")) return;
        SetLocalInt(OBJECT_SELF, "dla_cv_csintro", TRUE);

        DelayCommand(1.5, AssignCommand(oPC, SpeakString("That should be enough. Let's get back for the evening.")));
        DelayCommand(2.5, AssignCommand(oJonas, ActionMoveToObject(oPC, FALSE)));
        DelayCommand(2.6, AssignCommand(oGodfroy, ActionMoveToObject(oPC, FALSE)));
        DelayCommand(4.5, AssignCommand(oJonas, ActionStartConversation(oPC, "dla_cv_csintro", FALSE, FALSE)));
    }
}
