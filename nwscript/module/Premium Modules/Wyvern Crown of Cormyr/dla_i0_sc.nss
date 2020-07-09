//------------------------------------------------------------------------------
// dla_i0_sc :: Spellcraft Challenge include
//-----------------------------------------------------------------------------
/*

    Rules:

         - Player has to identify DLA_SC_MAXSPELLS defined in dla_sc_setup.2da.
         - DC is spell level + 10.
         - Failurre ends the game.
         - The pc can start the game DLA_SC_FAILS_UNTIL_ABORT times.
         - Success moves on to the next round.
         - Winning the game will give the player DLA_SC_FINAL_PRICE_ITEM_RESREF

    Notes:
        - Attach the conversation to any NPC
        - Flag the conversation as 'no interrupt' on the NPC!

*/
//------------------------------------------------------------------------------
// 2006/05/05 :: Georg Zoeller :: (c) 2006 DLA
//------------------------------------------------------------------------------

#include "cu_magicspecific"

//------------------------------------------------------------------------------
// Number of spells in the challenge. If you change this, you need to add lines
// to the 2da as well for it to work.
//------------------------------------------------------------------------------
const int DLA_SC_MAXSPELLS = 10;

//------------------------------------------------------------------------------
// Cash given back to the player per successful identify
// (i.e. 10 starts to become lucrative after level 5 (1+2+3+4+5)*10 = 100 = entry fee )
// Modified 16th May to add random item on victory
//------------------------------------------------------------------------------
const int DLA_SC_CASH_PER_LEVEL = 10;
const int DLA_SC_ENTRY_FEE = 100;
const int DLA_SC_FAILS_UNTIL_ABORT = 3;
const string DLA_SC_FINAL_PRICE_ITEM_RESREF = "dla_it_prize";


struct sc_info_struct
{
    int nSpell;
    string sSpellName;
    int nDC;
    string sNo;
};

//------------------------------------------------------------------------------
// Setup the Start of the game
//------------------------------------------------------------------------------
void DLASC_Start(object oPC)
{
    int nStartcount = GetLocalInt(oPC, "DLA_SC_STARTED_COUNT" );
    nStartcount++;
    SetLocalInt(oPC, "DLA_SC_STATUS",1);   // current spell in the challenge
    SetLocalInt(oPC, "DLA_SC_STARTED_COUNT",nStartcount );
    TakeGoldFromCreature(DLA_SC_ENTRY_FEE,oPC, TRUE);
}


int DLASC_GetFailed(object oPC)
{
    int nStartCount = GetLocalInt(oPC, "DLA_SC_STARTED_COUNT" );
    if(nStartCount >= DLA_SC_FAILS_UNTIL_ABORT)
    {
        return TRUE;
    }
    return FALSE;
}

//------------------------------------------------------------------------------
// TRUE if the challenge was started
//------------------------------------------------------------------------------
int DLASC_GetStarted(object oPC)
{
    return  (GetLocalInt(oPC, "DLA_SC_STARTED_COUNT" ) >0);
}

//------------------------------------------------------------------------------
// The current spell # in the conversation
//------------------------------------------------------------------------------
int DLASC_GetSpellNo(object oPC)
{
   return  (GetLocalInt(oPC, "DLA_SC_STATUS" ));
}

//------------------------------------------------------------------------------
// Increase current spell no in the current conversation
//------------------------------------------------------------------------------
void DLASC_IncSpellNo(object oPC)
{
    int nCur = GetLocalInt(oPC, "DLA_SC_STATUS" );
    SetLocalInt(oPC, "DLA_SC_STATUS", ++ nCur);

}

//------------------------------------------------------------------------------
// Retrieve info about the spell in line nContestSpell in dla_sc_setup.2da
// and spells.2da
//------------------------------------------------------------------------------
struct sc_info_struct DLASC_GetSpellInfo(int nContestSpell)
{
    struct sc_info_struct stRet;
    stRet.nSpell = StringToInt(Get2DAString("dla_sc_setup","SpellId", nContestSpell));
    stRet.sSpellName = GetStringByStrRef(StringToInt(Get2DAString("Spells","Name",stRet.nSpell)));
    stRet.nDC    = (StringToInt(Get2DAString("Spells","Wiz_Sorc",stRet.nSpell) )+ 10);
    stRet.sNo = Get2DAString("dla_sc_setup","No",nContestSpell);
    return stRet;

}

//------------------------------------------------------------------------------
// Setup the conversation tokens for the current round of the conversation
//------------------------------------------------------------------------------
void DLASC_SetupTokens(object oPC)
{
    int nSCSpell = DLASC_GetSpellNo(oPC);
    struct sc_info_struct stSpell;
    stSpell =  DLASC_GetSpellInfo(nSCSpell);

    SetCustomToken(7200, stSpell.sNo);                      // first, second, etc...
    SetCustomToken(7201, stSpell.sSpellName);               // SpellName
    SetCustomToken(7202, IntToString(stSpell.nDC));         // DC required to beat

}


//------------------------------------------------------------------------------
// Move on to the next round
//------------------------------------------------------------------------------
void DLASC_Next(object oPC)
{
    DLASC_IncSpellNo(oPC);
}



//------------------------------------------------------------------------------
// Check if the last spellcraft check was successful
//------------------------------------------------------------------------------
int DLASC_GetSpellcraftCheckSuccessful(object oPC)
{

   int nSCSpell = DLASC_GetSpellNo(oPC);
   int nReward =     nSCSpell * DLA_SC_CASH_PER_LEVEL;

    SetCustomToken (7206,IntToString(nReward));
    return (GetLocalInt(oPC,"DLA_SC_CHECK_RESULT") >0);
}
//bloody hell.  Added to fix GetIsSkillSuccessful bug
int GetSkillCheckSucceeded(object oObject, int nSkill, int nDC, int bFeedback=FALSE)
{
    int nRanks = GetSkillRank(nSkill, oObject);
    int nDie = d20();
    int bReturn;
    string sRoll = "1d20("+IntToString(nDie)+") + "+IntToString(nRanks)+" = ";
    if(nRanks+nDie>=nDC)
    {
        sRoll += "vs DC "+IntToString(nDC)+" = **Success**";
        bReturn = TRUE;
    }
    else
    {
        sRoll += "vs DC "+IntToString(nDC)+" = **Failure**";
        bReturn = FALSE;
    }
    if(bFeedback){FloatingTextStringOnCreature(sRoll,oObject);}
    return bReturn;
}

//------------------------------------------------------------------------------
// Perfrom Spellcraft check for current spell
//------------------------------------------------------------------------------
void DLASC_DoSpellcraftcheck(object oPC)
{
    int nSCSpell = DLASC_GetSpellNo(oPC);
    struct sc_info_struct stSpell;
    stSpell =  DLASC_GetSpellInfo(nSCSpell);

    int nResult =   GetSkillCheckSucceeded(oPC, SKILL_SPELLCRAFT, stSpell.nDC) ;
    SetLocalInt(oPC,"DLA_SC_CHECK_RESULT", nResult);

}

//------------------------------------------------------------------------------
// This is executed bythe NPC once the spell casting is complete
//------------------------------------------------------------------------------
void DLASC_CastCallback(object oSelf, object oPC)
{

    DelayCommand(0.3f, AssignCommand(oSelf,ActionResumeConversation()));
}

//------------------------------------------------------------------------------
// Cast the spell for the current round. Afterwards, trigger callback to resume
// the conversation
//------------------------------------------------------------------------------
void DLASC_Cast(object oPC)
{
    object oSelf = OBJECT_SELF;
    //object oTarget = GetObjectByTag("dla_sc_target");
    ActionPauseConversation();

    int nSCSpell = DLASC_GetSpellNo(oPC);
    struct sc_info_struct stSpell;
    stSpell =  DLASC_GetSpellInfo(nSCSpell);


    ActionCastFakeSpellAtObject(stSpell.nSpell,oPC);

    AssignCommand(oSelf, DelayCommand(0.2f,DLASC_CastCallback(oSelf,oPC)));

}

//------------------------------------------------------------------------------
// Return TRUE if this is the first time the player talked to this NPC
// Sets the first talked to flag as well
// NOTE: Also sets up some tokens, so be careful when removing this node!
//------------------------------------------------------------------------------
int DLASC_GetFirstTimeTalked(object oPC)
{
    int nResult = GetLocalInt(oPC,"DLA_SC_FIRST_TIME");
    SetLocalInt(oPC,"DLA_SC_FIRST_TIME",1);
    SetCustomToken(7204,IntToString(DLA_SC_MAXSPELLS));
    SetCustomToken(7207,IntToString(DLA_SC_ENTRY_FEE));
    return (nResult == 0);

}


//------------------------------------------------------------------------------
// Return TRUE uf the player has won the current challenge
//------------------------------------------------------------------------------
int DLASC_GetWonChallenge(object oPC)
{
    return  (DLASC_GetSpellNo(oPC) > DLA_SC_MAXSPELLS);
}

//------------------------------------------------------------------------------
// Flag the player as having completed the challenge
//------------------------------------------------------------------------------
void DLASC_SetWonChallenge(object oPC)
{
    SetLocalInt(oPC,"DLA_SC_WON_CHALLENGE",1);
//    CreateItemOnObject (DLA_SC_FINAL_PRICE_ITEM_RESREF, oPC);
    GetTreasureType("Jewelry",oPC,100,2,1);
}

//------------------------------------------------------------------------------
// Return TRUE to a returning player who won the challenge at least once
//------------------------------------------------------------------------------
int DLASC_GetChallengeOver(object oPC)
{
    return GetLocalInt(oPC,"DLA_SC_WON_CHALLENGE");
}

//------------------------------------------------------------------------------
// Hand the player the current round reward
//------------------------------------------------------------------------------
void DLASC_RoundReward(object oPC)
{
   int nSCSpell = DLASC_GetSpellNo(oPC);
   int nReward =     nSCSpell * DLA_SC_CASH_PER_LEVEL;

   GiveGoldToCreature(oPC, nReward);
}


//------------------------------------------------------------------------------
// True if the player has sufficient funds to enter the tournament
//------------------------------------------------------------------------------
int DLASC_GetSufficientFunds(object oPC)
{
    return GetGold(oPC) >= DLA_SC_ENTRY_FEE;
}


void DLASC_End(object oPC)
{
   SetLocalInt(oPC, "DLA_SC_STARTED",0);
   SetLocalInt(oPC, "DLA_SC_STATUS",1);
}
