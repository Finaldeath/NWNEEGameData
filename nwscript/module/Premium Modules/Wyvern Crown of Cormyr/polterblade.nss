// B W-Husey
// Jan 2006
// Tag-Based Item Script (activate only)
//
#include "x2_inc_itemprop"
#include "x2_inc_switches"
#include "cu_functions"

int GetTagBasedItemEventNumber()
{ int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   return (nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT"));
}

void SetTagBasedScriptExitBehavior( int nEndContinue)
{ DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT");
   SetExecutedScriptReturnValue( nEndContinue);
}


void main()
{ switch( GetTagBasedItemEventNumber())
   {
   case X2_ITEM_EVENT_ACTIVATE:  //Use of special power, +5 strength/dex or failure
         {
            // Get the PC, first.
            object oItem = GetItemActivated();
            object oPC = GetItemActivator();
            int nCheck = GetLocalInt(oPC,"nPoltUse");
            effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
            effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_RED);
            effect eUp1 = EffectAbilityIncrease(ABILITY_STRENGTH,5);
            effect eUp2 = EffectAbilityIncrease(ABILITY_DEXTERITY,5);
            effect eLink = EffectLinkEffects(eVis2,eUp1);

                int nRand = Random(3);
                if (nRand>0 || nCheck<2)   //can't drain it the first 2 uses
                {
                    FloatingTextStringOnCreature("The spirit awakes...",oPC);
                    SetLocalInt(oPC,"nPoltUse",nCheck+1);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,180.0);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eUp2,oPC,180.0);
//                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oPC,179.0);
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
                    FloatingTextStringOnCreature("The spirit of the poltergeist has drained away!",oPC);
                    AddJournalQuestEntry("Poltergeist",26,oPC);
                    DestroyObject(GetObjectByTag("Polterblade"),0.5);
                }
        }
         case X2_ITEM_EVENT_ACQUIRE:
         { // This is where you would process item acquired - starts conversation with spirit
          object oPC = GetModuleItemAcquiredBy();
          object oItem = GetModuleItemAcquired();
            if (GetLocalInt(oPC,"nInvTlk")<1 && GetIsPC(oPC)) //once only for it to talk
            {
                object oTalker = GetObjectByTag("invistalk");
                AllParty("nInvTlk",oPC,1);
                AssignCommand(oPC,ClearAllActions(TRUE));
                DelayCommand(0.1,AssignCommand(oTalker,ActionStartConversation(oPC,"polterblade")));
            }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


