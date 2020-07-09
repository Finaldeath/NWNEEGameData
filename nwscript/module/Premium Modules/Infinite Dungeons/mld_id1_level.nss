#include "inc_id1_score"

void main()
{
    DebugMessage("");

    object oPC = GetPCLevellingUp();
    string sIdentifier = GetName(oPC);

    DebugMessage("Leveling up henchmen for player " + sIdentifier);

    string sTag;
    string sName;
    int nLevel;

    // henchmen
    int nCount = 1;
    object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);
    while (oHenchman != OBJECT_INVALID)
    {
        sTag = GetTag(oHenchman);
        sName = GetName(oHenchman);

        // level up
        nLevel = LevelUpHenchman(oHenchman);

        DebugMessage("  Henchman with name " + sName + " and tag " + sTag + " leveled to " + IntToString(nLevel));

        nCount++;
        oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nCount);
    }

    // March 30, 2006 GM: Stats tracking for the score system.
    AwardLevelUpPoints(oPC);
}
