#include "ddf_journal"
#include "ddf_util"

void main()
{
    // Set our flag
    SetLocalInt(GetModule(), "dlg_quill_002_done", TRUE);
    SetLocalInt(GetModule(), "ddf_quill_on_street", TRUE);

    object oQuil = GetObjectByTag("DDF_NPC_Quillian");

    // Unhench Quill
    RemoveHenchperson(oQuil);

    // Teleport Quill
    object oWaypoint = GetWaypointByTag("QuillianHangout");
    location locWP = GetLocation( oWaypoint );
    DelayCommand(1.0, AssignCommand(oQuil, ActionJumpToLocation(locWP)));

    UpdateJournal(GetPCSpeaker());
}
