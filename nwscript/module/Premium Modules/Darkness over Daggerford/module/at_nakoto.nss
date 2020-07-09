// Part of the nakoto conversation attack (C1AR0503)
// this script will spawn the xanathar assasins in the sewers

#include "NW_I0_GENERIC"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(OBJECT_SELF);

    // destroy bugo's letter
    object oLetter = GetItemPossessedBy(oPC, "pm_bugo_letter");
    DestroyObject(oLetter);
    SetLocalInt(oPC, "pm_nakoto_1", 1);
    SetPlotFlag(OBJECT_SELF, FALSE);

    // update the journal
    AddJournalQuestEntry("j101", 2, oPC);

    // spawn some assassins
    string sWPTag = "pm_assassin_1";
    string sTemplate = "pm_xanathar";
    if (GetLocalInt(oArea, "EncSpawned") == 0)
    {
        int iHench = 1;
        int nCount = 1;
        object oWP = GetNearestObjectByTag(sWPTag, oPC);
        while(oWP != OBJECT_INVALID)
        {
            string snewtag = "pm_ass_" + IntToString(nCount);
            object oAss = CreateObject(OBJECT_TYPE_CREATURE, sTemplate, GetLocation(oWP), FALSE, snewtag);
            AssignCommand(oAss, DetermineCombatRound());
            nCount++;
            sWPTag = ("pm_assassin_" + IntToString(nCount));
            oWP = GetObjectByTag(sWPTag);
            if (nCount > 2)
            {
                if (GetHenchman(oPC, iHench) == OBJECT_INVALID)
                {
                    break;
                }
                iHench++;
            }
        }
        ClearAllActions();
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
        DelayCommand(0.5, DetermineCombatRound(oPC));

        SetLocalInt(oArea,"EncSpawned",1);
    }
}
