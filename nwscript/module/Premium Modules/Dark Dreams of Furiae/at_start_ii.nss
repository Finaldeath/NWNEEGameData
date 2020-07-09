///
/// START THE INCITING INCIDENT
///
/// player have finished the setup, and now need to be teleported
/// to the Sea Market with the burning building.
///
/// Quillian also needs to move towards them to start the dialog.
///

#include "ddf_util"


void main()
{
    debug("Cutscene: Start Inciting Incident");

    // if day 1, if you are the party leader
    //    go to the starting spawn point.
    // else
    //    go to where the party leader is.

    object oPC = GetPCSpeaker();

    object oFactionLeader = GetFactionLeader(oPC);

    // setup new party members with required background stuff
    int bgFlag = GetLocalInt(GetModule(), "ddf_background_flag");
    if(bgFlag == BG_COP) SetPartyAsGuard();
    if(bgFlag == BG_REVOLUTIONARY) SetPartyAsRevolutionary();
    if(bgFlag == BG_INDIE) SetPartyAsIndependent();

    if(GetCurrentDay() == 1 && oPC == oFactionLeader)
    {
        // We _DO NOT_ want to telepor the whole party here, because each party member
        // needs to have the dialog iwth the portal in order ot set their alignment to match
        // up with the choosen background.
        MovePlayerToObject(oPC, GetObjectByTag("ddf_spawnpoint_inciting_incident"), TRUE);
        //MovePartyToObject(GetFirstPC(), GetObjectByTag("ddf_spawnpoint_inciting_incident"), TRUE);
    }
    else
    {
        if(GetIsObjectValid(oFactionLeader))
        {
            MovePlayerToObject(oPC, oFactionLeader);
        }
        else
        {
            debug("-- hurm, not sure where to move you...");
            MovePlayerToObject(oPC, GetObjectByTag("YourApartmentStart"));
        }

    }

    /*
    object oLoc = GetObjectByTag("ddf_spawnpoint_inciting_incident");
    location lLoc = GetLocation(oLoc);

    object oSearchPC = GetFirstPC();
    while (oSearchPC != OBJECT_INVALID)
    {
        // Fade all the PCs screen to black
        SetCutsceneMode(oSearchPC, TRUE, FALSE);
        FadeToBlack(oSearchPC);

        // Now teleport all the PCs
        DelayCommand(2.0, AssignCommand(oSearchPC, ActionJumpToLocation(lLoc)));

        oSearchPC = GetNextPC();
    }
    */
}
