#include "ddf_journal"
#include "ddf_util"

void main()
{
    // Set the flag that quill is in jail
    SetLocalInt(GetModule(), "dlg_quill_002_done", TRUE);
    SetLocalInt(GetModule(), "ddf_quill_in_jail", TRUE);

    // Remove Quill as a henchman
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");
    //RemoveHenchman(GetPCSpeaker(), oQuill);
    RemoveHenchperson(oQuill);

    // Teleport Quill
    object oWaypoint = GetWaypointByTag("QuillianJailed");
    location locWP = GetLocation( oWaypoint );
    DelayCommand(1.0, AssignCommand(oQuill, ActionJumpToLocation(locWP)));

    UpdateJournal(GetPCSpeaker());
}

