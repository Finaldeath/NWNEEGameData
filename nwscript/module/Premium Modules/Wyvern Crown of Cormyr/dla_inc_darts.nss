/* dla_inc_darts
   dart game AI and cutscene handler functions

    dla_inc_darts.nss
    created by: Robert Faber
    date: 04/27/06

    prototypes:
*/

//Calculates the average points a dart target will yield, based on
//AI skill level
float GetAveragePointsFromDartTarget(object oPC, int nAttack, int nTarget);

//Calculates the best "points per throw" the AI can hit
int GetBestDartThrow(object oPC);

//Calculates the required throws the AI has to make in order to win
int GetRequiredDartThrow(int nThrowsRemaining);

//Takes the assembled dart functions in dla_darts_inc and tells the AI what to shoot for
void SetDartTarget(int nRound, int nThrowsRemaining);

//Removes cutscene immobility from PC for alternating cutscenes
//also helps keep the PC from mucking it up
void RemoveImmobility(object oPC);

//The round is stored on the dartboard.  This is to allow multiple
//games, if desired.  Not used here except storage.
int GetDartRoundNumber();

//Clears all dart variables from the player and opponent so it can be replayed
void SetDartGameOver();

//Increments the round based on who went first
void IncrementDartRound(object oPlayer);

//Delayed call in the dart_onattacked script to check for a complete whiff
//Used in scoring.
void CheckDartHit(object oPC);

// **FUNCTIONS**

float GetAveragePointsFromDartTarget(object oPC, int nAttack, int nTarget)
{
    int nAC;
    switch(nTarget)
    {
        case 0:nAC=0;break;
        case 1:nAC=10;break;
        case 2:nAC=14;break;
        case 3:nAC=18;break;
        case 4:nAC=22;break;
        case 5:nAC=26;break;
        default:nAC=0;break;
    }
    float fAC = IntToFloat(nAC);
    float fAttack = IntToFloat(nAttack);
    float fPoints = IntToFloat(nTarget)+1.0f;
    float fHitChance = (21.0f+fAttack-fAC)/20.0f;
    if(fHitChance<0.05f){fHitChance=0.05f;}
    if(fHitChance>0.95f){fHitChance=0.95f;}
    float fReturn = fHitChance*fPoints;
    return fReturn;
}
int GetBestDartThrow(object oPC)
{
    int i, nChanceToHit;
    int nReturn=0;
    int nAttack = GetBaseAttackBonus(oPC)+GetAbilityModifier(ABILITY_DEXTERITY,oPC)+
        GetHasFeat(FEAT_WEAPON_FOCUS_DART,oPC)+GetHasFeat(FEAT_GOOD_AIM,oPC);
    float fChanceToHit;
    float fAttack = IntToFloat(nAttack);
    float fAvg, fHigh;
    for(i=0;i<=5;i++)
    {
        fAvg = GetAveragePointsFromDartTarget(oPC,nAttack,i);
        //SendMessageToPC(GetFirstPC(),IntToString(i)+"avg="+FloatToString(fAvg));
        if(fAvg>=fHigh)
        {
            fHigh=fAvg;
            nReturn=i;
        }
    }
    //SendMessageToPC(GetFirstPC(),"best="+IntToString(nReturn+1));
    return nReturn;
}
int GetRequiredDartThrow(int nThrowsRemaining)
{
    object oSelf = OBJECT_SELF;
    object oPC = GetFirstPC();
    int nReturn;
    int nFirst = GetLocalInt(oPC,"nDartPCWentFirst");
    int nScore1 = GetLocalInt(oPC,"nDartScore");
    int nScore2 = GetLocalInt(oSelf,"nDartScore");
    int nPCProjected = nScore1+nScore1/2;
    int nDiff = nScore1-nScore2;
    int nBest =GetBestDartThrow(oSelf);
    if(!nFirst)
    {
        nDiff =nPCProjected-nScore2;
    }
    if(nDiff<0)
    {
        nReturn = 0;
    }
    else
    {
        nReturn = nDiff/nThrowsRemaining;
        if(nFirst && nThrowsRemaining)
        {
            nReturn++;
        }
        if(nReturn>5)
        {
            nReturn=5;
        }
    }
    return nReturn;
}
void SetDartTarget(int nRound, int nThrowsRemaining)
{
    int nBest;
    if(nRound<3)
    {
        nBest = GetBestDartThrow(OBJECT_SELF);
    }
    else
    {
        nBest = GetRequiredDartThrow(nThrowsRemaining);
    }
    SetLocalInt(OBJECT_SELF,"nDartTargetValue",nBest);
    object oPC = GetFirstPC();
    string sFeedback = GetName(OBJECT_SELF)+" aiming for ";
    switch(nBest)
    {
        case 0:sFeedback+="the board";break;
        case 1:sFeedback+="4th circle or better";break;
        case 2:sFeedback+="3rd circle or better";break;
        case 3:sFeedback+="2nd circle or better";break;
        case 4:sFeedback+="1st circle or better";break;
        case 5:sFeedback+="bull's-eye";break;
    }
    FloatingTextStringOnCreature(sFeedback,oPC,FALSE);
}
void RemoveImmobility(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect)==EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
            RemoveEffect(oPC,eEffect);
        }
        eEffect=GetNextEffect(oPC);
    }
}
int GetDartRoundNumber()
{
    object oBoard = GetObjectByTag("dla_dartboard");
    int nRound = GetLocalInt(oBoard,"nMyDartRoundNumber");
    return nRound;
}
void SetDartGameOver()
{
    object oPC = GetFirstPC();
    object oOpponent = GetLocalObject(oPC,"oMyDartOpponent");
    object oBoard = GetObjectByTag("dla_dartboard");
    int nFirst = GetLocalInt(oPC,"nDartPCWentFirst");
    int nWager = GetLocalInt(oOpponent,"nDartWager");
    int nGold = GetLocalInt(oOpponent,"nDartGold");
    int nPCScore = GetLocalInt(oPC,"nDartScore");
    int nNPCScore = GetLocalInt(oOpponent,"nDartScore");
    int nDifference = nPCScore - nNPCScore;
    SetLocalObject(oPC,"oMyPreviousDartOpponent",oOpponent);
    if(nFirst)
    {
        if(nDifference>=0)
        {
            GiveGoldToCreature(oPC, nWager);
            SetLocalInt(oOpponent, "nDartGold", nGold - nWager);
            SetLocalInt(oPC,"nDartJustWon",TRUE);
            SetLocalInt(oPC,"nDartWonLastGame",TRUE);
        }
        else
        {
            TakeGoldFromCreature(nWager,oPC,TRUE);
            SetLocalInt(oOpponent, "nDartGold", nGold + nWager);
            SetLocalInt(oPC,"nDartJustLost",TRUE);
            SetLocalInt(oPC,"nDartLostLastGame",TRUE);
        }
    }
    else
    {
        if(nDifference>0)
        {
            GiveGoldToCreature(oPC, nWager);
            SetLocalInt(oOpponent, "nDartGold", nGold - nWager);
            SetLocalInt(oPC,"nDartJustWon",TRUE);
            SetLocalInt(oPC,"nDartWonLastGame",TRUE);
        }
        else
        {
            TakeGoldFromCreature(nWager,oPC,TRUE);
            SetLocalInt(oOpponent, "nDartGold", nGold + nWager);
            SetLocalInt(oPC,"nDartJustLost",TRUE);
            SetLocalInt(oPC,"nDartLostLastGame",TRUE);
        }
    }
    //variable cleanup
    SetLocalInt(oOpponent,"nHasPlayedOnce",TRUE);
    DeleteLocalInt(oPC,"nPlayingDarts");
    DeleteLocalInt(oPC,"nMyDartThrow");
    DeleteLocalInt(oPC,"nMyDartTurn");
    DeleteLocalInt(oPC,"nDartScore");
    DeleteLocalInt(oOpponent,"nDartScore");
    DeleteLocalInt(oPC,"nDartPCWentFirst");
    DeleteLocalInt(oPC,"nMyDartThrow");
    DeleteLocalObject(oPC,"oMyDartOpponent");
    SetName(oBoard,"Final Score");
    SetCutsceneMode(oPC,FALSE);
    AssignCommand(oOpponent, ActionStartConversation(oPC));
    ExecuteScript("dla_dart_end",oPC);
}
void IncrementDartRound(object oPlayer)
{
    object oPC = GetFirstPC();
    object oOpponent = GetLocalObject(oPC,"oMyDartOpponent");
    object oBoard = GetObjectByTag("dla_dartboard");
    string sName;
    int nFirst = GetLocalInt(oPC, "nDartPCWentFirst");
    int nRound = GetLocalInt(oBoard,"nMyDartRoundNumber");
    int bIncrement = FALSE;
    RemoveImmobility(oPC);
    if(oPlayer == oPC && !nFirst)
    {
        bIncrement = TRUE;
    }
    if(oPlayer != oPC && nFirst)
    {
        bIncrement = TRUE;
    }
    if(bIncrement)
    {
        nRound++;
        SetLocalInt(oBoard,"nMyDartRoundNumber",nRound);
        sName = "Round: "+IntToString(nRound);
        SetName(oBoard,sName);
        if(nRound > 3)
        {
            AssignCommand(oPC, ClearAllActions(TRUE));
            SetDartGameOver();
            return;
        }
        if(oPlayer==oPC)
        {
            ExecuteScript("dla_dart_aiturn",oOpponent);
        }
    }
    if(oPlayer == oPC && !bIncrement)
    {
        ExecuteScript("dla_dart_aiturn",oOpponent);
    }
}
void CheckDartHit(object oPC)
{
    int nPlayer = GetIsPC(oPC);
    object oScore = GetObjectByTag("dart_score"+IntToString(nPlayer));
    int nScore = GetLocalInt(oPC,"nDartScore");
    int nFirst = GetLocalInt(oPC,"nDartPCWentFirst");
    string sScore =  GetName(oPC)+": "+IntToString(nScore);
    string sRound;
    if(!GetLocalInt(oPC,"nDartHit"))
    {
        SetName(oScore,sScore);
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,1.0));
        AssignCommand(oPC,PlayVoiceChat(VOICE_CHAT_CUSS,oPC));
    }
}
