//::///////////////////////////////////////////////
//:: Name Module PC Death Script
//:: FileName mdt_id_pcdeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This script handles the PC death event.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Aug 25, 2005
//:://////////////////////////////////////////////

// ---------------------------- TEMP CONSTANT---------------------------------
// These are to be removed once the module constants file is available for integration
// Constant names supplied by Peter.
const string ID1_FLAG_DEATH_PLAYER = "nFlagDeathPlayer";
const int ID1_DEATH_PLAYER_PERMANENT = 10; // player death is permanent,with only resurrection as a possibility
const int ID1_DEATH_PLAYER_RESPAWN_INSTANT = 20; // the player will be able to respawn right where he died
const int ID1_DEATH_PLAYER_RESPAWN_AREA = 30; // the player will be able to respawn and will appear in the area where he died
const int ID1_DEATH_PLAYER_RESPAWN_LEVEL = 40; // the player respawns back at the staircase he entered the level from
const int ID1_DEATH_PLAYER_RESPAWN_DUNGEON = 50; // the player respawns back just outside the dungeon entrance (outside, because of possible level loading issues)

const string ID1_FLAG_DEATH_PLAYER_HENCHMEN = "nFlagDeathPlayerHenchmen";
const int ID1_DEATH_PLAYER_HENCHMEN_VANISH = 10; // the henchmen vanish upon the player's death
const int ID1_DEATH_PLAYER_HENCHMEN_PERSIST = 20; // the henchmen stick around in that area, fighting and waiting for the player
const int ID1_DEATH_PLAYER_HENCHMEN_DIE = 30; // the henchmen die when the player dies
const int ID1_DEATH_PLAYER_HENCHMEN_FREED = 40; // the henchmen are set as not being henchmen anymore and can be picked up by other players

// New constants
const string ID1_DEATH_PLAYER_PERMANENT_MESSAGE =       "You have died. A PC ally must raise you from the dead to continue.";
const string ID1_DEATH_PLAYER_RESPAWN_INSTANT_MESSAGE = "You have died. You may chose to wait for help or respawn where you died.";
const string ID1_DEATH_PLAYER_RESPAWN_AREA_MESSAGE =    "You have died. You may chose to wait for help or respawn where you entered this area.";
const string ID1_DEATH_PLAYER_RESPAWN_LEVEL_MESSAGE =   "You have died. You may chose to wait for help or respawn at the entrance to the level.";
const string ID1_DEATH_PLAYER_RESPAWN_DUNGEON_MESSAGE = "You have died. You may chose to wait for help or respawn at the entrance to the dungeon.";
// ---------------------------- END TEMP -------------------------------------

void main()
{
    // Since this script can be called by the module on the PC death event or by
    // a PC recursively oPC must be properly defined.
    object oPC = GetLastPlayerDied();
    object oHench;
    int nCount = 1;
    int nDiff = GetLocalInt(GetModule(),ID1_FLAG_DEATH_PLAYER);
    int nHench = GetLocalInt(GetModule(),ID1_FLAG_DEATH_PLAYER_HENCHMEN);
    // Values defaulted for ID1_DEATH_PLAYER_RESPAWN_INSTANT
    string sMessage = ID1_DEATH_PLAYER_RESPAWN_INSTANT_MESSAGE;
    int nRespawn = TRUE;

    // Handle henchman rules.
    oHench = GetHenchman(oPC,nCount);
    while(GetIsObjectValid(oHench))
    {
        if (nHench == ID1_DEATH_PLAYER_HENCHMEN_VANISH)
        {
            AssignCommand(oHench,SetIsDestroyable(TRUE));
            DestroyObject(oHench);
        }
        else if (nHench == ID1_DEATH_PLAYER_HENCHMEN_DIE)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oHench);
        }
        oHench = GetHenchman(oPC,nCount+=1);
    }

    // Set death message and respawn button.
    switch (nDiff)
    {
        case ID1_DEATH_PLAYER_PERMANENT:
        {
            sMessage = ID1_DEATH_PLAYER_PERMANENT_MESSAGE;
            nRespawn = FALSE;
            break;
        }
        case ID1_DEATH_PLAYER_RESPAWN_AREA:
        {
            sMessage = ID1_DEATH_PLAYER_RESPAWN_AREA_MESSAGE;
            break;
        }
        case ID1_DEATH_PLAYER_RESPAWN_LEVEL:
        {
            sMessage = ID1_DEATH_PLAYER_RESPAWN_LEVEL_MESSAGE;
            break;
        }
        case ID1_DEATH_PLAYER_RESPAWN_DUNGEON:
        {
            sMessage = ID1_DEATH_PLAYER_RESPAWN_DUNGEON_MESSAGE;
            break;
        }
    };

    PopUpDeathGUIPanel(oPC, nRespawn, TRUE, 0, sMessage);
}

