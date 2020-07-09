#include "ddf_util"
void main()
{
    // Set the flag that quill is in jail
    SetLocalInt(GetModule(), "ddf_quill_in_jail", TRUE);

    // Remove Quill as a henchman
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");
    RemoveHenchperson(oQuill);

    // Teleport Quill
    object oWaypoint = GetObjectByTag("QuillianJailed");
    if(GetIsObjectValid(oWaypoint))
    {
        AssignCommand(oQuill, ActionJumpToObject(oWaypoint));
    }
    else
    {
        debug("!! Unable to find `QuillianJailed` object...");
    }

}
