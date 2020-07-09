#include "ddf_journal"
#include "x0_i0_secret"


void main()
{
    // Update our flag and journal
    SetLocalInt(GetModule(), "ddf_guarded_warehouse_secret_door", TRUE);
    UpdateJournal(GetPCSpeaker());

    // Enable the secret door
    //SetUseableFlag(GetObjectByTag("UlanSecretDoor"), TRUE);

    // Show hidden door...
    object oDetectTrigger = GetObjectByTag("UlanSecDoor");

    if(GetIsSecretItemRevealed(oDetectTrigger))
    {
        // already found it!
        return;
    }

    RevealSecretItem("ulan_sec_door", oDetectTrigger);

}
