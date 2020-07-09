// May 2004
// B W-Husey
// Tracking modified by a variable on the tracks that makes it harder to read (nTrackPenalty).
// Bonuses to tracking: Spot bonus of 1 per 5 skill ranks + the following non-stacking bonuses
//                      +5 for rangers
//                      +5 for barbarians over level 3 (outside in natural)
//                      +1 for druids (outside in natural)
//                      +1 for barbarians < level 4 or other terrain
// By default, if you do not set a track penalty, any character can read the tracks 1 out of 6 times.
// but a ranger will always read them.

// Modify this script to reflect core rules as closely as poss.

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int nResult = FALSE;
    int nBonus = 0;
    // Give Bonuses=========================================
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0)
    {
        nBonus = 5;
    }
    else if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 3 &&
        GetIsAreaAboveGround(oArea) && GetIsAreaNatural(oArea)) //can't have both bonuses
    {
        nBonus = 5;
    }
    else if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 &&
        GetIsAreaAboveGround(oArea) && GetIsAreaNatural(oArea)) //can't have both bonuses
    {
        nBonus = 1;
    }
    else if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0)
    {
        nBonus = 1;
    }
    int nPlus = GetSkillRank(SKILL_SPOT)/5;
    nBonus = nBonus + nPlus; // sum bonuses
    //=============================End Bonuses==============
    int nRand = Random(6) - GetLocalInt(OBJECT_SELF,"nTrackPenalty");//variable on the tracks
    nRand = nRand + nBonus;
    if (nRand > 4 && GetLocalInt(OBJECT_SELF, "nTry")==0)
    {
        if (GetLocalInt(OBJECT_SELF,"nGotXP") < 1) // Controls xp handout
            {
            GiveXPToCreature(oPC, 50 + (25*GetLocalInt(OBJECT_SELF,"nTrackPenalty"))); //first character to read tracks gets XP
            FloatingTextStringOnCreature("XP  Gain - Tracks read",oPC, TRUE);
            SetLocalInt(OBJECT_SELF, "nGotXP", 1); //XP Given
            }
        SetLocalInt(OBJECT_SELF, "nTry", 2); //can now read every time
        return TRUE;
    }
    else if (GetLocalInt(OBJECT_SELF, "nTry")==2)
    return TRUE;

    SetLocalInt(OBJECT_SELF, "nTry", 1); // Failed to read, can never succeed
    return FALSE;
}
