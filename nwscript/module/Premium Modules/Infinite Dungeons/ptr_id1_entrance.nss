#include "inc_id1_debug"

void main()
{
    DebugMessage("");
    DebugMessage("Dungeon Entrance click.");

    int bGenerating = GetLocalInt(GetModule(), "bGenerating");
    DebugMessage("  Getting bGenerating in Dungeon Entrance to be " + IntToString(bGenerating));
    if (bGenerating == FALSE)
    {
        object oPC = GetClickingObject();
        DebugMessage("  Tag of clicking object is " + GetTag(oPC) + " with name " + GetName(oPC));
        if (GetIsPC(oPC) == TRUE)
        {
            DebugMessage("  Object is a PC.");
            if (IsInConversation(OBJECT_SELF) == FALSE)
            {
                DebugMessage("  Not in a conversation.");
                BeginConversation("id1_journal", oPC);
            } else
            {
                DebugMessage("  Already in a conversation.");
            }
        } else
        {
            DebugMessage("  Object is not a PC.");
        }
    }
}

