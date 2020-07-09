// end the intro by teleporting the player into daggerford

#include "hf_in_npc"
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    // a hired henchman should now use the daggerford inn as a respawn point
    // .. (an unhired henchman will bind to the point where they are hired)
    object oHench = GetLocalObject(oArea, "oHenchman");
    string sName = "WP_HENCHMAN_START_" + GetTag(oHench);
    object oWP = GetWaypointByTag(sName);
    location lLoc = GetLocation(oWP);
    HenchmanSetHome(oHench, lLoc);

    // if the spawned henchman was not hired, then move 'em into town
    // .. purfbin = black stone inn
    // .. raegen  = happy cow
    if (GetMaster(oHench) != oPC)
    {
        string sTag = GetResRef(oHench);
        CreateObject(OBJECT_TYPE_CREATURE, sTag, lLoc);
        DestroyObject(oHench);
    }

    // clean the area since the player can never come back here
    object oGrass = GetObjectByTag("ks_imprison_pl");
    DestroyObject(oGrass);

    // set the maximum number of henchman in this module
    // .. one for purfbin, one for raegen, and one for veiti
    SetMaxHenchmen(3);

    // move the PC's party to daggerford
    DelayCommand(2.0, TeleportToWaypoint(oPC, "wp_daggerford", TRUE));

    // save the game
    DoSinglePlayerAutoSave();
}
