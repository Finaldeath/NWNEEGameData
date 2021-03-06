//::///////////////////////////////////////////////
//:: Default On Attacked
//::
//:: c_gr_Default_AT.nss
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: If I am attacked, I attack my attacker.
//:://////////////////////////////////////////////
//:: Created By: Brent, On: April 24, 2001
//:: Modified By Aidan on Oct 2001
//:://////////////////////////////////////////////

void main()
{
    object oTarget = GetAttackTarget();
    object oAttacker = GetLastAttacker(OBJECT_SELF);
    SpeakString("NW_I_WAS_ATTACKED",TALKVOLUME_SILENT_SHOUT);
    if (GetIsObjectValid(oAttacker) &&
        !GetIsObjectValid(oTarget) &&
        GetIsEnemy(oAttacker) )
    {
      ClearAllActions();
      AdjustReputation(oAttacker,OBJECT_SELF,100);
      ActionAttack(oAttacker);
    }

}
