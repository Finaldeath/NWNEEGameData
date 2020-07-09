//a2_detectstaff
//This script runs the onequip event for the detection staff given to the pc by astriel
//for the blackstone inn quest.
//
//At the moment this will fire regardless of area - we need to know if this will be needed
//further in the plot and limit it to which ever areas.
//
//author: Phil Mitchell (Baron of Gateford)
#include "x2_inc_itemprop"
#include "x2_inc_switches"
void SetMagicGlow( object oItem )
{
  object oPC = OBJECT_SELF;
  if ( oItem == GetItemInSlot( INVENTORY_SLOT_RIGHTHAND, oPC ) ||
       oItem == GetItemInSlot( INVENTORY_SLOT_LEFTHAND, oPC ) )
  {
    object oListener = GetNearestObjectByTag("WP_C1AR0304_C1AR0304B_EXIT");

    if ( GetIsObjectValid( oListener ) && GetDistanceBetween( oListener, oPC ) < 5.0 )
    {
      if ( !GetLocalInt( oItem, "glowing" ) )
      {
        //Don't replay conversation if trapdoor has appeared
        if(GetNearestObjectByTag("pm_bsi_TrapDoor", oPC) == OBJECT_INVALID)
        {
            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL), 0.0 );
            SetLocalInt(oItem, "glowing", 1 );
            AssignCommand(oPC, ClearAllActions(TRUE));
            PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
            //DelayCommand(0.5, ActionStartConversation(oPC,"pm_detectstaff",TRUE, FALSE));
            DelayCommand(0.5,
                AssignCommand(GetObjectByTag("rod_talk"),
                    ActionStartConversation(oPC, "", FALSE, FALSE)));
         }
      }
    }
    else if ( GetLocalInt( oItem, "glowing" ) )
    {
      IPRemoveMatchingItemProperties( oItem, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
      DeleteLocalInt( oItem, "glowing" );
    }
    DelayCommand( 1.0, SetMagicGlow( oItem ) );
  }
}
void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_EQUIP)
      {
      object oItem = GetPCItemLastEquipped();
      object oPC = GetPCItemLastEquippedBy();
      object oArea = GetArea(oPC);
      string sArea = GetTag(oArea);
      //FloatingTextStringOnCreature("Passwall activated.", oPC, FALSE);
      //  if (oArea == GetArea(GetObjectByTag("Level7")) || oArea == GetArea(GetObjectByTag("Level8")))
      //  {
          AssignCommand( oPC, SetMagicGlow( oItem ) );
      //  }
      }
}
