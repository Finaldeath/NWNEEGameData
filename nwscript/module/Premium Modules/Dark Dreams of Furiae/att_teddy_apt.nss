#include "ddf_util"

void main()
{
    // Get the party leader
    object oLeader = GetFactionLeader(GetFirstPC());

    // If the party leader entered the volume
    if (GetEnteringObject() == oLeader)
    {
        // Teddy can't see you if he's dead and hasn't already left the apartment or is guarding the door
        if (GetLocalInt(GetModule(), "ddf_teddy_dead") == TRUE)
        {
            return;
        }
        if (GetLocalInt(GetModule(), "ddf_teddy_apt_leave") == TRUE)
        {
            return;
        }
        // If he already saw you, don't make him run up and talk to you again
        if (GetLocalInt(GetModule(), "ddf_teddy_apt_saw_pc") == TRUE)
        {
            return;
        }

        // Set the flag that teddy saw the pc
        SetLocalInt(GetModule(), "ddf_teddy_apt_saw_pc", TRUE);

        // Grab Teddy
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

        // Start dialog
        AssignCommand(oTeddy, ActionStartConversation(oLeader, "tedd_002"));
    }
}
