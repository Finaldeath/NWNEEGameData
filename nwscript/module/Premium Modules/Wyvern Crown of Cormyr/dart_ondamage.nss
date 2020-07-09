#include "dla_inc_darts"
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetLastAttacker(oSelf);
    object oPlayer = GetFirstPC();
    string sDebug;

    //do the dart calc only if playing darts
    if(oPC==oPlayer && !GetCutsceneMode(oPC)){return;}

    string sFeedback;
    int nPoints,nMissed;
    int nTest = GetBestDartThrow(oPC);
    //SendMessageToPC(oPC,"best="+IntToString(nTest));
    int nAttack = GetBaseAttackBonus(oPC)+GetAbilityModifier(ABILITY_DEXTERITY,oPC)+
        GetHasFeat(FEAT_WEAPON_FOCUS_DART,oPC)+GetHasFeat(FEAT_GOOD_AIM,oPC);
    int n20 = d20();
    //track critical hits.  Since the board has high hardness, 2 points of
    //sonic damage from the dart = a critical hit
    int nPrevHP = GetLocalInt(oSelf,"nDartBoardHP");
    int nHP = GetCurrentHitPoints(oSelf);
    int nDam = nPrevHP-nHP;
    SetLocalInt(oSelf,"nDartBoardHP",nHP);

    /*critical hit debug
    SendMessageToPC(oPC,"prev hp: "+IntToString(nPrevHP));
    SendMessageToPC(oPC,"curr hp: "+IntToString(nHP));
    SendMessageToPC(oPC,"damage: "+IntToString(nDam));
    */

    //find out what we were aiming for
    int nTarget = GetLocalInt(oPC, "nDartTargetValue");
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

    nPoints = nTarget+1;
    nMissed = (nAttack+n20<nAC);
    //do the roll
    //double points on a critical hit
    if(nDam>1)
    {
        nPoints *= 2;
        DelayCommand(1.0, AssignCommand(oPC,PlayVoiceChat(VOICE_CHAT_CHEER,oPC)));
        DelayCommand(1.0, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3,1.0)));
    }
    if(nMissed && nDam <2)
    {
        sFeedback = "Miss! ";
        nPoints=0;
    }
    //feedback messages
    else if(nDam>1 && nTarget==5)
    {
        sFeedback = "Double Bull's-eye! ";
    }
    else if(nTarget==5 && nDam==1)
    {
        sFeedback = "Bull's-eye! ";
    }
    else if(nTarget<5 && nDam>1)
    {
        sFeedback = "Top Stripe! ";
    }
    else
    {
        sFeedback = "Hit!  ";
    }
    if(oPlayer == oPC)
    {
        //Show PC his or her own feedback
        sDebug = "Attack: "+IntToString(nAttack)+" + d20 ("+IntToString(n20)+") vs AC: "+IntToString(nAC);
        FloatingTextStringOnCreature(sDebug,oPlayer,FALSE);
    }
    //Announce NPCs target.  In the dart game, all players are supposed
    //to be "calling their shots", eliminating part of board in order
    //to score more points.  The NPC should therefore call shots, but we'll
    //keep their attack rolls secret.
    else
    {
        sDebug = GetName(oPC)+" aiming for ";
        switch(nTarget)
        {
            case 0:sDebug+="the board";break;
            case 1:sDebug+="4th circle or better";break;
            case 2:sDebug+="3rd circle or better";break;
            case 3:sDebug+="2nd circle or better";break;
            case 4:sDebug+="1st circle or better";break;
            case 5:sDebug+="bull's-eye";break;
        }
        FloatingTextStringOnCreature(sDebug,oPlayer,FALSE);
    }
    //finish feedback string
    sFeedback += IntToString(nPoints)+" point";
    if(nPoints!=1){sFeedback+="s";}
    sFeedback+="!";
    FloatingTextStringOnCreature(sFeedback,oPlayer,FALSE);

    int nPlayer = GetIsPC(oPC);
    object oScore = GetObjectByTag("dart_score"+IntToString(nPlayer));
    int nScore = GetLocalInt(oPC,"nDartScore");
    nScore+=nPoints;
    string sScore =  GetName(oPC)+": "+IntToString(nScore);
    SetName(oScore,sScore);
    SetLocalInt(oPC,"nDartScore",nScore);
    SetLocalInt(oPC,"nDartHit",TRUE);
    DelayCommand(2.0, DeleteLocalInt(oPC,"nDartHit"));
}
