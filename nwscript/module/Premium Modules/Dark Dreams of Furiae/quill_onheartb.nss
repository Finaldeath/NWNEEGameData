#include "ddf_util"

void main()
{
    /*
    string sWasHenching = "was_henching";

    int bWasHench = GetLocalInt(OBJECT_SELF, sWasHenching);
    object oPC = GetMaster();
    int bPCValid = GetIsObjectValid(oPC);

    if(bWasHench == TRUE && bPCValid == FALSE)
    {
        debug("-- Quillian is no longer henching.");

        // no longer henching.
        // do all the things.
        SetLocalInt(OBJECT_SELF,sWasHenching, FALSE);
        // move back to original position.

        SpeakString("Well, this has been fun.");

        ClearAllActions(TRUE);

        object oTarget = GetObjectByTag("QuillianHangout");
        if(GetLocalInt(GetModule(), "ddf_quill_on_street") == FALSE)
        {
            // move him back to your apartment.
            oTarget = GetObjectByTag("DDF_QUILL_START");
        }

        //ActionJumpToObject(oTarget, TRUE);
        ActionForceMoveToObject(oTarget, TRUE, 1.0f, 5.0f);

        return;
    }

    if(bPCValid == TRUE && bWasHench == FALSE)
    {
        debug("-- Quillian is henching!");
        SetLocalInt(OBJECT_SELF, sWasHenching, TRUE);
    }
    */
    ExecuteScript("nw_ch_ac1", OBJECT_SELF);
}
