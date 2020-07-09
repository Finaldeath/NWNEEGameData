 #include "nw_i0_plot"
void myAppraiseOpenStore(object oStore, object oPC, int nBonusMarkUp = 0, int nBonusMarkDown = 0)
{
    int STATE_FAILED = 1;
    int STATE_TIE = 2;
    int STATE_WON = 3;
    string sTag = ObjectToString(OBJECT_SELF);

    int nPlayerSkillRank = GetSkillRank(SKILL_APPRAISE, oPC);

    int nNPCSkillRank = GetSkillRank(SKILL_APPRAISE, OBJECT_SELF) - GetNPCEasyMark(OBJECT_SELF);


    if (nNPCSkillRank < 1 )
        nNPCSkillRank = 1;

    int nAdjust = 0;


    /*
      New System:

        An opposed skill check (a d10 roll instead). Your appraise skill versus the shopkeepers appraise skill.

        Possible Results:

        Percentage Rebate/Penalty: The 'difference'

        Feedback: [Appraise Skill]: Merchant's reaction is unfavorable.
                  [Appraise Skill]: Merchant's reaction is neutral.
                  [Appraise Skill]: Merchant's reaction is favorable.

        Additional: Remember last reaction for this particular skill.
        When the player gets a new skill rank in this skill they'll get a
        reroll against this merchant.

    */

    int nState = 0;
    int nPreviousRank = GetLocalInt(oPC, "X0_APPRAISERANK"+ sTag);

    // * if the player's rank has improved, let them have another appraise check
    // * against this merchant



    if ( (nPlayerSkillRank > nPreviousRank) || !GetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag) )
    {
       SetLocalInt(oPC, "X0_APPRAISERANK"+ sTag, nPlayerSkillRank);
       SetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag, 1);

        nPlayerSkillRank = nPlayerSkillRank + d10();
        nNPCSkillRank = nNPCSkillRank + d10();
        nAdjust = nNPCSkillRank - nPlayerSkillRank; // * determines the level of price modification
        if (nNPCSkillRank > nPlayerSkillRank)
        {
            nState = STATE_FAILED;
        }
        else
        if (nNPCSkillRank < nPlayerSkillRank)
        {
            nState = STATE_WON;
        }
        else
        if (nNPCSkillRank == nPlayerSkillRank)
        {
            nState = STATE_TIE;
        }

    }
    else
    {
        // * recover last reaction
        nAdjust  = GetLocalInt(oPC, "X0_APPRAISEADJUST" + sTag);

        if (nAdjust > 0)
        {
            nState = STATE_FAILED;
        }
        else
        if (nAdjust < 0)
        {
            nState = STATE_WON;
        }
        else
        if (nAdjust == 0)
        {
            nState = STATE_TIE;
        }

    }

    if (nState == STATE_FAILED  )
    {
        FloatingTextStrRefOnCreature(8963, oPC, FALSE);
    }
    else
    if (nState == STATE_WON)
    {
        FloatingTextStrRefOnCreature(8965, oPC, FALSE);
    }
    else
    if (nState == STATE_TIE)
    {
        FloatingTextStrRefOnCreature(8964, oPC, FALSE);
    }

    SetLocalInt(oPC, "X0_APPRAISEADJUST"+ sTag, nAdjust);
  //  SpawnScriptDebugger();

    FloatingTextStringOnCreature(IntToString(nAdjust),oPC);
    // * Hard cap of 30% max up or down
    if (nAdjust > 30)
        nAdjust = 30;
    if (nAdjust < -30)
        nAdjust = -30;
    nBonusMarkUp = nBonusMarkUp + nAdjust;
    nBonusMarkDown = nBonusMarkDown - nAdjust;
    OpenStore(oStore, oPC, nBonusMarkUp, nBonusMarkDown);
}

