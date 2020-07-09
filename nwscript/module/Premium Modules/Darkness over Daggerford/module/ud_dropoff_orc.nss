//drop off cave orc perception event
//speak random one liner
//move to attack and shout for reinforcements
//Author: Luspr & Kevin Smith (Codepoetz)
//Date: 15-Aug-2005
#include "nw_i0_generic"
void DePlotFaction(object oMaster);
void AttackInvader(object oMaster, object oPC);
void CombatTalk();
void main()
{
    //note - listen patterns must be enabled in the on spawn handler
    //for this to function properly
    object oPC = GetLastPerceived();
    if (GetIsPC(oPC))
    {
        ClearAllActions();//trying to ensure perceive event fires
        DePlotFaction(OBJECT_SELF);
        AdjustReputation(oPC,OBJECT_SELF,-100);
        AttackInvader(OBJECT_SELF,oPC);
        DetermineCombatRound(oPC);
        SpeakString("NW_ATTACK_MY_TARGET",TALKVOLUME_SILENT_TALK);
        if(!GetLocalInt(OBJECT_SELF,"combat_talk")==1)
        {
            CombatTalk();
            SetLocalInt(OBJECT_SELF,"combat_talk",1);
        }
    }
}
void DePlotFaction(object oMaster)
{
    object oOrcAttacker = GetFirstFactionMember(oMaster,FALSE);
    while(GetIsObjectValid(oOrcAttacker))
    {
        SetPlotFlag(oOrcAttacker,FALSE);
        SetImmortal(oOrcAttacker,FALSE);
        oOrcAttacker=GetNextFactionMember(oMaster,FALSE);
    }
}
void AttackInvader(object oMaster, object oPC)
{
    object oOrcAttacker = GetFirstFactionMember(oMaster,FALSE);
    while(GetIsObjectValid(oOrcAttacker))
    {
        if(GetArea(oOrcAttacker)==GetArea(oPC))
        {
            if(GetObjectSeen(oPC,oOrcAttacker))
            {
                AssignCommand(oOrcAttacker,ClearAllActions());
                AssignCommand(oOrcAttacker,DetermineCombatRound(oPC));
            } else {
                AssignCommand(oOrcAttacker,ClearAllActions());
                AssignCommand(oOrcAttacker,ActionAttack(oPC));
                }
        }
        oOrcAttacker=GetNextFactionMember(oMaster,FALSE);
    }
}
void CombatTalk()
{
int iCombatTalk = d6();
string q = GetLocalString(GetModule(), "QUOTE");
switch (iCombatTalk)
    {
    case 1: SpeakString(q+"Get 'em, boys!"+q); break;
    case 2: SpeakString(q+"We are under attack!"+q); break;
    case 3: SpeakString(q+"Archers! Support here!"+q); break;
    case 4: SpeakString(q+"Kiss my axe..."+q); break; //yup that's an homage to Pat Mills' Slaine there :-) (Luspr)
    case 5: SpeakString(q+"You shoulda stayed away!"+q); break;
    case 6: SpeakString(q+"You die now!"+q); break;
    }
}
