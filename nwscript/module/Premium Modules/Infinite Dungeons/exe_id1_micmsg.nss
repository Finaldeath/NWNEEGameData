#include "inc_id1_debug"

void main()
{
    string sMessage = GetLocalString(OBJECT_SELF, "sMessage");

    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        DebugMessage("Telling PC to say " + sMessage);
        AssignCommand(oPC, ActionSpeakString(sMessage));

        // cycle to next player
        oPC = GetNextPC();
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
