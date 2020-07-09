//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_redguard2
// DATE: November 26, 2005
// AUTH: Luke Scull
// NOTE: Blacks out screen then sets up Onehand
//       conversation.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_cutscene"


const string NPC_TAG_ASTAR = "Astar";
const string NPC_TAG_EREMUTH = "Eremuth";
const string NPC_TAG_LYRESSA = "Lyressa";

const string LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR   = "p_hil_autod_astar";
const string LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH = "p_hil_autod_eremu";
const string LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA = "p_hil_autod_lyres";


void main()
{
    int i = 0;

    object oPC = GetPCSpeaker();
    object oHench = OBJECT_INVALID;

    oHench = GetNearestObjectByTag(NPC_TAG_ASTAR, oPC);
    if (GetIsObjectValid(oHench) && HenchmanIsMine(oHench, oPC))
    {
        SetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR, 1);
        HenchmanFire(oHench, oPC);
    }

    oHench = GetNearestObjectByTag(NPC_TAG_EREMUTH, oPC);
    if (GetIsObjectValid(oHench) && HenchmanIsMine(oHench, oPC))
    {
        SetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH, 1);
        HenchmanFire(oHench, oPC);
    }

    oHench = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);
    if (GetIsObjectValid(oHench) && HenchmanIsMine(oHench, oPC))
    {
        SetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA, 1);
        HenchmanFire(oHench, oPC);
    }

    CutscenePlay(oPC, "cut_tm_hillsfar");
}
