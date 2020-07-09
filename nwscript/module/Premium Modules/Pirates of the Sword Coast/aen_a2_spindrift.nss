//::///////////////////////////////////////////////
//:: aen_a2_spindrift
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the player enters spindrift make sure
    he knows about the Rose and initiaze the
    town guard.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "inc_willigan"

void KickedOutCutscene(object oPC);

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();

    if(GetIsPCNotDM(oPC))
    {
        //update the current waypoint
        UpdateSafePoint();

        int iPlotA = GetLocalInt(oModule, "A2_MIDROSE");
        int iPlotB = GetLocalInt(oModule, "A2_CREW");
        int iPlotC = GetLocalInt(oModule, "A2_SPNDRF");

        if (iPlotA < 10)
        {
            SetLocalInt(oModule, "A2_MIDROSE", 10);
            AddJournalQuestEntry("a2_midrose", 10, oPC);

        }
        if (iPlotB < 10)
        {
            SetLocalInt(oModule, "A2_CREW", 10);
            AddJournalQuestEntry("a2_crew", 10, oPC);
        }
        if (iPlotC < 10)
        {
            SetLocalInt(oModule, "A2_SPNDRF", 10);
            AddJournalQuestEntry("a2_spndrf", 10, oPC);
        }


        // JE: If the PC entering the area is being kicked out of
        // Willigan's manor, fire the cutscene. Note that this is not a
        // full-fledged cutscene, it plays only for the PC being kicked out.
        if(GetLocalInt(oPC, l_n_A2_WILLIGAN_PC_KICKED_OUT))
        {
            DeleteLocalInt(oPC, l_n_A2_WILLIGAN_PC_KICKED_OUT);

            SetCutsceneMode(oPC, TRUE); // turned off in KickedOutCutscene()
            BlackScreen(oPC); // fades in during KickedOutCutscene()

            DelayCommand(1.0, KickedOutCutscene(oPC));
        }
        else
        {
            // this is also called in KickedOutCutscene, with a proper delay
            // to take the cutscene into account, which is why this call is
            // in an "else" statement
            A2WillyRestoreHenchmen(oPC);

            // Added by K2 - Do a single player autos save if the cutscene
            // for being kicked out is not being played.
            ExecuteScript("exe_autosave", GetModule());
        }
    }
}

void KickedOutCutscene(object oPC)
{
    // The PC was jumped into the area at the proper waypoint, so we know where
    // he's starting. We make sure the door is open, the pc falls forward
    // to simulate being thrown out of the building, Fanny says something,
    // the door closes, and the PC gets up as the cutscene ends. Short and sweet.

    // Note: Cutscene mode is set before the call to this function.

    object oDoor = GetObjectByTag(a2d_Spindrift_Willigan);
    ActionOpenDoor(oDoor);

    SetCameraMode(oPC, CAMERA_MODE_TOP_DOWN);
    AssignCommand(oPC, SetCameraFacing(20.0, 5.0, 80.0));

    DelayCommand(1.0, FadeFromBlack(oPC, FADE_SPEED_FAST));

    DelayCommand(1.0, AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 3.5)));
    DelayCommand(1.5, AssignCommand(oDoor, SpeakString(s_A2_FANNY_THROW_PC_OUT)));
    DelayCommand(2.5, ActionCloseDoor(oDoor));

    DelayCommand(4.5, SetCutsceneMode(oPC, FALSE));
    DelayCommand(4.5, A2WillyRestoreHenchmen(oPC));
}
