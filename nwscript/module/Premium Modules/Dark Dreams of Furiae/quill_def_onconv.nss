#include "ddf_util"

void main()
{
    string sOnConv = "nw_ch_ac4";

    object oSpeaker = GetLastSpeaker();

    if(GetIsPC(oSpeaker) == FALSE)
    {
        // do the default things.
        debug("-- quill responding to another NPC...");
        ExecuteScript(sOnConv, OBJECT_SELF);
        return;
    }

    int nMatch = GetListenPatternNumber();

    if (nMatch != -1)
    {
        // it is a NWN recognised line, do the default behaviour...
        debug("-- quill responding to pattern: " + IntToString(nMatch));
        ExecuteScript(sOnConv, OBJECT_SELF);
        return;
    }

    debug("-- quill_def_onconv with PC.");

    // If quill is henching...
    object oMaster = GetMaster(OBJECT_SELF);
    if(GetIsObjectValid(oMaster))
    {
        debug("quill_003 (henching)");
        BeginConversation("quill_003");
    }
    // Day 1 - Inciting Incident Cutscene
    else if(GetLocalInt(GetModule(), "dlg_quill_001_done") == FALSE)
    {      '
        debug("quill_def_onconv - starting quill_001");
        BeginConversation("quill_001");
    }
    // Day 1 - Your Apartment
    else if(GetLocalInt(GetModule(), "dlg_quill_002_done") == FALSE)
    {
        BeginConversation("quill_002");
        SetLocalInt(GetModule(), "dlg_quill_002_done", TRUE);
    }
    // Quill in jail
    else if (GetLocalInt(GetModule(), "ddf_quill_in_jail") == TRUE)
    {
        debug("quill_005");
        BeginConversation("quill_005");
    }
    // Quill out on street
    else if (GetLocalInt(GetModule(), "ddf_quill_on_street") == TRUE)
    {
        debug("quill_004");
        BeginConversation("quill_004");
    }
    // Default Quill talk
    else
    {
        debug("quill_003");
        BeginConversation("quill_003");
    }
}

