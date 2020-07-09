//::///////////////////////////////////////////////
//:: FileName con_tm_eremuth2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 30/04/2006 11:18:14
//:://////////////////////////////////////////////

const string VALID_AREAS = "Hillsfar#HillsfarInnerCity#ShindRdEOY#ShindRdEHF#ShindRdENV#ShindRoadE#ShindRoadEastCave";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sCurrentAreaTag = GetTag(GetArea(oPC));
    int nQuestVar = GetLocalInt(oPC, "eremuthsuspicious");

    return ((nQuestVar == 1) && (FindSubString(sCurrentAreaTag, VALID_AREAS) >= 0));
}
