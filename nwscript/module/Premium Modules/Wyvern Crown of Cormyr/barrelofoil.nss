// B W-Husey
// September 2004
// Tag-Based Item Script
// Makes a barrel of oil placeable when dropped. If in a burn area makes a version that burns things
// when it explodes

#include "x2_inc_switches"

int GetTagBasedItemEventNumber()
{ int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   return (nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT"));
}

void SetTagBasedScriptExitBehavior( int nEndContinue)
{ DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT");
   SetExecutedScriptReturnValue( nEndContinue);
}

void ActionCreate(string oCreature,location lLoc, effect eSummon)
{
    object oNew = CreateObject(OBJECT_TYPE_CREATURE,oCreature,lLoc,FALSE);
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon,oNew));
}

void main()
{ switch( GetTagBasedItemEventNumber())
   {      case X2_ITEM_EVENT_UNACQUIRE:
         {
            object oPC = GetModuleItemLostBy();
            object oItem = GetModuleItemLost();
            object oBarrel;
            if (GetLocalInt(oPC,"nBurnArea")>0) oBarrel = CreateObject(OBJECT_TYPE_PLACEABLE,"oilbarrel2",GetLocation(GetModuleItemLostBy()),FALSE);
            else oBarrel = CreateObject(OBJECT_TYPE_PLACEABLE,"oilbarrel",GetLocation(oPC),FALSE);
            if (GetLocalInt(oPC,"nBurnArea")>1) SetLocalInt(oBarrel,"nShip",1);   //barrel placed on the ship.
            DestroyObject(oItem,0.5);
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

