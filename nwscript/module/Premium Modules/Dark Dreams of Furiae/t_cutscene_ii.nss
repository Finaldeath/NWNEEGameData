#include "ddf_util"

void RunQuillToParty();


void main()
{
    // Cutscene done flag
    int iCutsceneDone = GetLocalInt(GetModule(), "ddf_cutscene_ii_done");

    if (iCutsceneDone == FALSE)
    {
        // Get the party leader
        object oLeader = GetFactionLeader(GetFirstPC());

        // Only the party leader can trigger this
        if (GetEnteringObject() == oLeader)
        {
            debug("Cutscene: Continue Inciting Incident");

            object oSearchPC = GetFirstPC();
            while (oSearchPC != OBJECT_INVALID)
            {
                // This stuff should already be disabled, but consistent for jumps
                BlackScreen(oSearchPC);
                SetCutsceneMode(oSearchPC, TRUE, FALSE);

                // Play explosion sound

                object oSound = GetObjectByTag("INITIAL_EXPLOSION");
                if(GetIsObjectValid(oSound) == FALSE) debug("-- unable to find INITIAL_EXPLOSION");

                SoundObjectPlay(oSound);
                DelayCommand(30.0f, SoundObjectStop(oSound));

                // Fade up
                DelayCommand(5.0, FadeFromBlack(oSearchPC));
                DelayCommand(5.0, SetCutsceneMode(oSearchPC, FALSE, TRUE));

                oSearchPC = GetNextPC();
            }

            // Get quill
            object oQuill = GetObjectByTag("DDF_NPC_Quillian");

            // Make quillian run to party leader
            //DelayCommand(5.0, AssignCommand(oQuill, ActionMoveToObject(oLeader, TRUE)));

            // Make quillian talk to the party leader
            //DelayCommand(9.0, AssignCommand(oQuill, ActionStartConversation(oLeader, "quill_001")));
            DelayCommand(9.0, RunQuillToParty());

            SetLocalInt(GetModule(), "ddf_cutscene_ii_done", TRUE);
        }
    }
}

void RunQuillToParty()
{
    //object oLeader = GetFactionLeader(GetFirstPC());
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");
    object oPlayerInSight = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                           PLAYER_CHAR_IS_PC,
                                                           OBJECT_SELF);

    if(IsInConversation(oQuill) == TRUE) return;

    // Make quillian run to party leader
    AssignCommand(oQuill, ActionMoveToObject(oPlayerInSight, TRUE));

    // Make quillian talk to the party leader
    AssignCommand(oQuill, ActionStartConversation(oPlayerInSight, "quill_001"));
}
