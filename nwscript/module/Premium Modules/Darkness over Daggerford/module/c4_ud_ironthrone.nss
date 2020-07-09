//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {
      //SpeakString("Perceive");
      object oPC = GetLastPerceived();
      int iVanished = GetLastPerceptionVanished();
      int iSeen = GetLastPerceptionSeen();
      int iHeard = GetLastPerceptionHeard();
      //if (GetIsPC(oPC) &&
      //    iVanished == TRUE &&
      if (GetIsPC(oPC) && ((!iSeen && iHeard) || GetLastPerceptionVanished()) &&
          GetLocalInt(GetArea(OBJECT_SELF),"pm_percep_fired") == 0)
          {
           SetLocalInt(GetArea(OBJECT_SELF),"pm_percep_fired",1);
           SpeakString("Be on your guard men. I hear someone sneaking!");
           int i = 1;
           object oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
           while(oArcher != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oArcher,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oArcher,DetermineCombatRound(oPC)));
                 i++;
                 oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
                 }
           i = 1;
           object oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
           while(oWarrior != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oWarrior,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oWarrior,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
                 }
           i = 1;
           object oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
           while(oWarrior2 != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oWarrior2,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oWarrior2,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
                 }
          }
    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
      //SpeakString("attacked");
      object oPC = GetLastAttacker();
      if (!GetLocalInt(GetArea(OBJECT_SELF),"pm_buffed_up"))
          {
           SetLocalInt(GetArea(OBJECT_SELF),"pm_buffed_up",1);
           //talent tTaunt=TalentBuffSelf();
           //ActionUseTalentOnObject(tTaunt, OBJECT_SELF);
           talent tDrink;
           int i = 1;
           object oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
           while(oArcher != OBJECT_INVALID)
                 {
                  tDrink = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 60, oArcher);
                  if (GetIsTalentValid(tDrink))
                      {
                      ActionUseTalentOnObject(tDrink, oArcher);
                      }
                 ChangeToStandardFaction(oArcher,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oArcher,DetermineCombatRound(oPC)));
                 i++;
                 oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
                 }
           i = 1;
           object oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
           while(oWarrior != OBJECT_INVALID)
                 {
                  tDrink = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 60, oWarrior);
                  if (GetIsTalentValid(tDrink))
                      {
                      ActionUseTalentOnObject(tDrink, oWarrior);
                      }
                 ChangeToStandardFaction(oWarrior,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oWarrior,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
                 }
           i = 1;
           object oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
           while(oWarrior2 != OBJECT_INVALID)
                 {
                  tDrink = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_ENHANCEMENT_POTION, 60, oWarrior2);
                  if (GetIsTalentValid(tDrink))
                      {
                      ActionUseTalentOnObject(tDrink, oWarrior2);
                      }
                 ChangeToStandardFaction(oWarrior2,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.4,AssignCommand(oWarrior2,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
                 }
          }
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}


