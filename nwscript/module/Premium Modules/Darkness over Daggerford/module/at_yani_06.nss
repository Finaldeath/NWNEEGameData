// Yani installs the custom class item in the stronghold

#include "hf_in_plot"
#include "hf_in_xp"

// is this class a base class? (not a prestige class)
int IsBaseClass(int nClass)
{
    return (nClass == CLASS_TYPE_FIGHTER ||
        nClass == CLASS_TYPE_BARBARIAN ||
        nClass == CLASS_TYPE_WIZARD ||
        nClass == CLASS_TYPE_SORCERER ||
        nClass == CLASS_TYPE_DRUID ||
        nClass == CLASS_TYPE_RANGER ||
        nClass == CLASS_TYPE_PALADIN ||
        nClass == CLASS_TYPE_CLERIC ||
        nClass == CLASS_TYPE_MONK ||
        nClass == CLASS_TYPE_BARD ||
        nClass == CLASS_TYPE_ROGUE);
}

// return the player's highest class
int GetHighestClass(object oPC)
{
    int nMaxClass = CLASS_TYPE_INVALID;
    int nMaxLevel = 0;
    int i;
    for (i=1; i<=3; i++)
    {
        int nClass = GetClassByPosition(i, oPC);
        if (nClass != CLASS_TYPE_INVALID)
        {
            int nLevel = GetLevelByClass(nClass, oPC);
            if (nLevel > nMaxLevel && IsBaseClass(nClass))
            {
                nMaxLevel = nLevel;
                nMaxClass = nClass;
            }
        }
    }
    return(nMaxClass);
}

void main()
{
    object oPC = GetPCSpeaker();
    int nClass = GetHighestClass(oPC);
    string sTag = "";

    if      (nClass == CLASS_TYPE_FIGHTER || nClass == CLASS_TYPE_BARBARIAN) sTag = "ks_pl_strong_6";
    else if (nClass == CLASS_TYPE_WIZARD  || nClass == CLASS_TYPE_SORCERER)  sTag = "ks_pl_strong_5";
    else if (nClass == CLASS_TYPE_DRUID   || nClass == CLASS_TYPE_RANGER)    sTag = "ks_pl_strong_2";
    else if (nClass == CLASS_TYPE_CLERIC  || nClass == CLASS_TYPE_PALADIN)   sTag = "ks_pl_strong_1";
    else if (nClass == CLASS_TYPE_ROGUE)                                     sTag = "ks_pl_strong_7";
    else if (nClass == CLASS_TYPE_BARD)                                      sTag = "ks_pl_strong_4";
    else if (nClass == CLASS_TYPE_MONK)                                      sTag = "ks_pl_strong_3";

    if (sTag != "")
    {
        string sWP = "WP_AR1301_FURN_CUSTOM";
        if (nClass == CLASS_TYPE_BARD)
        {
            sWP = "WP_AR1301_FURN_CUSTOM_OPPOSITE";
        }
        object oWP = GetWaypointByTag(sWP);
        location lLoc = GetLocation(oWP);
        CreateObject(OBJECT_TYPE_PLACEABLE, sTag, lLoc);
    }

    PlotLevelSet("ks_yani", 4);
    AddJournalQuestEntry("j102", 2, oPC);
    GiveQuestXPToCreature(oPC, "j102");
}
