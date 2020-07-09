// B W-Husey, October 2005
// dla_mod_rest : Module rest event script
// Modified to include horse specific code (i.e. dismounting & excluding horses)

/*
PC cannot rest twice in the same hour
Each time PC rests, must dismount and check for wandering monsters
PC & Henchies do a listen check for WM
*/

#include "dla_i0_horse"
#include "cu_wandering"
#include "cu_functions"
#include "x0_i0_petrify"

int GetIsMulti()
{
 object oPC = GetFirstPC();
 int i;
 while (GetIsObjectValid(oPC))
            {
            i++ ;
            oPC =GetNextPC();
            if (i > 1) return TRUE;
            }
 return FALSE;
}


void main()
{
    object oMod = GetModule();
    object oPC = GetLastPCRested();
//    FloatingTextStringOnCreature("Attempting to rest", oPC);
    string sPC = GetName(oPC);
    int iRestPeriod = 1;                    //Player cannot rest more than once an hour
    string aTag = GetTag(GetArea(oPC));
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
            //*************debug line
//            SendMessageToPC(oPC,"I registered a rest start");

        effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
        effect eBlind = EffectBlindness();
        effect eSleep = EffectSleep();
        string sRestText = GetName(oPC) + " must wait at least 1 hour between rests.";

        //First get the time last rested and the current time.
        int iLastHourRest = GetLocalInt(oMod, ("LastHourRest" + sPC));
        int iLastDayRest = GetLocalInt(oMod, ("LastDayRest" + sPC));
        int iLastYearRest = GetLocalInt(oMod, ("LastYearRest" + sPC));
        int iLastMonthRest = GetLocalInt(oMod, ("LastMonthRest" + sPC));
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear();
        int iMonth = GetCalendarMonth();
        int iHowLong = 0;
        // Remove cases where the numbers match, when really a period of time has passed
        if (iLastYearRest != iYear)            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)          iDay = iDay + 28;
        if (iDay != iLastDayRest)              iHour = iHour + 24 * (iDay - iLastDayRest);
        // Now make sure the PC isn't resting twice in a row
        iHowLong = iHour - iLastHourRest;
        if (iHowLong < iRestPeriod && !(aTag == "INN") && GetLocalInt(oPC, "RestNone")==0)
        {
            AssignCommand(oPC, ClearAllActions());
            FloatingTextStringOnCreature(sRestText, oPC);
        }
        // OK, rest, apply the effects - we may need to remove these though if the PC hears a wandering monster
        else if (GetLocalInt(GetArea(oPC),"Unsafe")>0)// so lets see if the area is unsafe
        {

          object oHench1 = ReturnHenchman(oPC,1);  //get only actual henchies, not horses.
          object oHench2 = ReturnHenchman(oPC,2);
          object oHench3 = ReturnHenchman(oPC,3); //extra, probably not required.

            //Dismount henchmen and PC to rest
            if (DLA_GetIsMounted(oPC))      DLA_Dismount(oPC,TRUE);
            if (DLA_GetIsMounted(oHench1))  DLA_Dismount(oHench1,TRUE);
            if (DLA_GetIsMounted(oHench2))  DLA_Dismount(oHench2,TRUE);
            if (DLA_GetIsMounted(oHench3))  DLA_Dismount(oHench3,TRUE);

          //Apply the sleep effects
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 10.0);
            //*************debug line
//            SendMessageToPC(oPC,"I got to the Wandering monster check");

//          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oPC, 6.0); //can't use. It makes the PC cancel resting
            int nMonster = WandMonCheck(oPC);
            if (nMonster == TRUE) //oh oh, we got a wandering monster or 2! Let PC and henchmen do a listen check
            {
//                  AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,2.0,10.0));
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oHench1, 10.0);
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oHench2, 10.0);
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oHench3, 10.0);
                AssignCommand(oHench1,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,2.0,10.0));
                AssignCommand(oHench2,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,2.0,10.0));
                AssignCommand(oHench3,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,2.0,10.0));


                string sNone = "None"; //null string - we're never going to test for this one, but a value is required by the function.
                if (GetSkillCheckSucceeded(oPC,SKILL_LISTEN,18))
                { //Listen Skill check succesfully passed - only the first PC gets this opportunity
                    PartyGotEntry(sNone,oPC,50,"XP gain - skill use");
                    FloatingTextStringOnCreature("A noise has awoken you",oPC);
                    DelayCommand(1.0,RemoveEffect(oPC,eBlind));
                    DelayCommand(2.2,RemoveEffect(oHench1,eSleep));
                    DelayCommand(2.5,RemoveEffect(oHench2,eSleep));
                    DelayCommand(2.8,RemoveEffect(oHench3,eSleep));
                }
                else if (oHench1 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench1)<10.0 && GetSkillCheckSucceeded(oHench1,SKILL_LISTEN,18))
                { //Listen Skill check for 1st henchman
//                    AssignCommand(oHench1,SpeakString("I heard something. Be ready..."));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oPC,eBlind));  // not as quick as a bit drowsy
                    DelayCommand(1.0,RemoveEffect(oHench1,eSleep));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench2,eSleep));  // not as quick as a bit drowsy
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench3,eSleep));  // not as quick as a bit drowsy
                    DelayCommand(1.1,AssignCommand(oHench1,ClearAllActions()));
                    DelayCommand(1.2,AssignCommand(oHench1,PlayVoiceChat(VOICE_CHAT_ENEMIES)));
                    DelayCommand(0.8,FloatingTextStringOnCreature("I heard something!",oHench1));
                }
                else if (oHench2 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench2)<10.0 && GetSkillCheckSucceeded(oHench2,SKILL_LISTEN,18))
                { //Listen Skill check for 2nd henchman
//                    AssignCommand(oHench2,SpeakString("I heard something. Be ready..."));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oPC,eBlind));  // not as quick as a bit drowsy
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench1,eSleep));  // not as quick as a bit drowsy
                    DelayCommand(1.0,RemoveEffect(oHench2,eSleep));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench3,eSleep));  // not as quick as a bit drowsy
                    DelayCommand(1.1,AssignCommand(oHench2,ClearAllActions()));
                    DelayCommand(1.2,AssignCommand(oHench2,PlayVoiceChat(VOICE_CHAT_ENEMIES)));
                    DelayCommand(0.8,FloatingTextStringOnCreature("I heard something!",oHench2));
                }
                else if (oHench3 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench3)<10.0 && GetSkillCheckSucceeded(oHench3,SKILL_LISTEN,18))
                { //Listen Skill check for 3rd henchman
//                    AssignCommand(oHench2,SpeakString("I heard something. Be ready..."));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oPC,eBlind));  // not as quick as a bit drowsy
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench1,eSleep));
                    DelayCommand(IntToFloat(d3()+2),RemoveEffect(oHench2,eSleep));  // not as quick as a bit drowsy
                    DelayCommand(1.0,RemoveEffect(oHench3,eSleep));   // not as quick as a bit drowsy
                    DelayCommand(1.1,AssignCommand(oHench3,ClearAllActions()));
                    DelayCommand(1.2,AssignCommand(oHench3,PlayVoiceChat(VOICE_CHAT_ENEMIES)));
                    DelayCommand(0.8,FloatingTextStringOnCreature("I heard something!",oHench3));
                }
                else
                { //oh dear, we all overslept! Stop us from reacting while the enemy gets in some free hits
                  DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 6.0));
//            DelayCommand(7.0,AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0)));
//              DelayCommand(7.0,AssignCommand(oHench1,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0)));
//              DelayCommand(7.0,AssignCommand(oHench2,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0)));
//              DelayCommand(7.0,AssignCommand(oHench3,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0)));
                  DelayCommand(10.0,SetCommandable(TRUE,oPC));
                  DelayCommand(10.0,SetCommandable(TRUE,oHench1));
                  DelayCommand(10.0,SetCommandable(TRUE,oHench2));
                  DelayCommand(10.0,SetCommandable(TRUE,oHench3));
                  SetCommandable(FALSE,oPC);
                  SetCommandable(FALSE,oHench1);
                  SetCommandable(FALSE,oHench2);
                  SetCommandable(FALSE,oHench3);
                }
            }//End of Monster arrives if

            //*************debug lines
  //          else SendMessageToPC(oPC,"No monster generated");
//            SendMessageToPC(oPC,"Monster check completed");
        } //End of unsafe if
    }  //end of started if

    //Set the time last rested when resting is done, so that the player can't rest twice in the same hour
//    if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED || GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED)
//    {
/*
        if(GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED)
        {
            //*************debug line
            SendMessageToPC(oPC,"My rest got cancelled by something");

        AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,5.0));
        }
*/
        if(GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
        {
            int nTime = GetTimeHour();
            SetTime(nTime+8,0,0,0);         // Line added to forward clock.

            SetLocalInt(oMod, ("LastHourRest" + sPC), GetTimeHour());
            SetLocalInt(oMod, ("LastDayRest" + sPC), GetCalendarDay());
            SetLocalInt(oMod, ("LastMonthRest" + sPC), GetCalendarMonth());
            SetLocalInt(oMod, ("LastYearRest" + sPC), GetCalendarYear());
    }// end of finished/cancelled if
}


