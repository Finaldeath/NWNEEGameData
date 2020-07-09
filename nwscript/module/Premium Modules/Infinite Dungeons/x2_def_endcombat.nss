//::///////////////////////////////////////////////
//:: Name x2_def_endcombat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Combat Round End script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "inc_id1_utility"
#include "inc_id1_flags"

void main()
{
    // if the current creature is in combat
    if (GetIsInCombat() == TRUE)
    {
        int nNum;
        int nLine;
        string sString;
        string sCreature;
        int nCreature;
        int bIntelligent;
        object oDungeon;
        int nRandom = d100();

        // chance of a oneliner
        int nOnelinerPercentage = GetModuleFlagValue(ID1_FLAG_COMBAT_ONELINER_FREQUENCY);
        if (nRandom <= nOnelinerPercentage)
        {
            // if the current creature is hostile towards PCs
            if (GetIsReactionTypeHostile(GetFirstPC()) == TRUE)
            {
                sCreature = GetLocalString(OBJECT_SELF, "sVariable");
                if (sCreature != "")
                {
                    oDungeon = GetCurrentDungeon();
                    nCreature = GetLocalInt(oDungeon, "n" + sCreature);
                    bIntelligent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nCreature) + "Intelligent");
                    if (bIntelligent == TRUE)
                    {
                        nNum = GetLocalInt(GetModule(), "nLinesHostileNum");
                        nLine = Random(nNum) + 1;
                        if (nLine > 0)
                        {
                            sString = GetLocalString(GetModule(), "sLinesHostile" + IntToString(nLine));
                            SpeakString(sString, TALKVOLUME_SHOUT);
                        }
                    }
                }
            } else
            {
                sCreature = GetLocalString(OBJECT_SELF, "sVariable");
                if (sCreature != "")
                {
                    oDungeon = GetCurrentDungeon();
                    nCreature = GetLocalInt(oDungeon, "n" + sCreature);
                    bIntelligent = GetLocalInt(oDungeon, "bListCreature" + IntToString(nCreature) + "Intelligent");
                    if (bIntelligent == TRUE)
                    {
                        nNum = GetLocalInt(GetModule(), "nLinesAlliesNum");
                        nLine = Random(nNum) + 1;
                        if (nLine > 0)
                        {
                            sString = GetLocalString(GetModule(), "sLinesAllies" + IntToString(nLine));
                            SpeakString(sString, TALKVOLUME_SHOUT);
                        }
                    }
                }
            }
        }
    }

    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_combat", OBJECT_SELF);
    }
    else
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}
