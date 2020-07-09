//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_henaddall
//:: DATE: February 27, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Hires all Henchman avaiable at this time
//:: Used in Lyressa's interjection when first entering
//:: the Swaying Bough inn
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

const string NPC_TAG_ASTAR = "Astar";
const string NPC_TAG_EREMUTH = "Eremuth";
const string NPC_TAG_LYRESSA = "Lyressa";

const string LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR   = "p_hil_autod_astar";
const string LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH = "p_hil_autod_eremu";
const string LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA = "p_hil_autod_lyres";


void HireSingleHenchman(string sHenchTag, object oPC)
{
    object oHench = GetNearestObjectByTag(sHenchTag, oPC);
    if (!GetIsObjectValid(oHench))
        oHench = GetObjectByTag(sHenchTag);
    SetPlotFlag(oHench, FALSE);
    SetImmortal(oHench, FALSE);
    HenchmanHire(oHench, oPC);
}


void main()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_ASTAR) > 0)
        HireSingleHenchman(NPC_TAG_ASTAR, oPC);

    if (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_EREMUTH) > 0)
        HireSingleHenchman(NPC_TAG_EREMUTH, oPC);

    if (GetLocalInt(oPC, LVAR_HILLSFAR_AUTO_DISMISSED_LYRESSA) > 0)
        HireSingleHenchman(NPC_TAG_LYRESSA, oPC);

    SetCutsceneMode(oPC, FALSE);
}
