
const int HQXP_ONEPC = 1;
const int HQXP_ALLPC = 0;

//======================================================================
// HandoutQuestXP - This funcion hands out experience to a PC object and
// optionally that objects party or all PCs.
//----------------------------------------------------------------------
// oPC = The player object in question
// iEXP = The Ammount of XP to hand out
// #iParty = HQXP_ONEPC (The oPC object and its associates)
// #iParty = HQXP_ALLPC (All PC objects and their associates)
//======================================================================
void HandoutQuestXP(object oPC, int iEXP, int bParty = HQXP_ALLPC);
int ConvertPercent(int iEXP, float fPercentage);

//handler for the HandoutQuestXP function and scalling by level.
void DealXP(object oPC, int iEXP)
{
    //Scale xp ACCORDING TO LEVEL
    int iAdjust = iEXP * GetHitDice(oPC);
    GiveXPToCreature(oPC, iAdjust);
}

//======================================================================
// HandoutQuestXP - This funcion hands out experience to a PC object and
// optionally that objects party or all PCs.
//----------------------------------------------------------------------
void HandoutQuestXP(object oPC, int iEXP, int bParty)
{
    object oPlayChar;

    if (bParty == HQXP_ONEPC)
    {
        DealXP(oPC, iEXP);
    }
    else
    {
        oPlayChar = GetFirstPC();
        while (GetIsObjectValid(oPlayChar) == TRUE)
        {
            DealXP(oPlayChar, iEXP);
            oPlayChar = GetNextPC();
        }
    }
}

// Scales an integer value by a percentage
// fPrecentage 1.0f = 100% && 0.1f = 10%
int ConvertPercent(int iEXP, float fPercentage)
{
    float fEXP = (IntToFloat(iEXP) * (fPercentage));
    return (FloatToInt(fEXP));
}
