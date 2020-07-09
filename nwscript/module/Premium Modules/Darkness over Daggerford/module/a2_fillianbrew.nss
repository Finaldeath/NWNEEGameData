//a2_pm_fillianbrw
//This script runs the onused event to make the PC drop to his butt when he/she drink fillians brew
//
//author: Phil Mitchell (Baron of Gateford)
#include "x2_inc_itemprop"
#include "x2_inc_switches"

void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_ACTIVATE)
     {
      object oUsed = GetItemActivated();
      object oPC = GetItemActivator();
      object oTarget = GetItemActivatedTarget();
      effect eKnockdown = EffectKnockdown();
      effect eEyes = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
      effect eVom = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);
      //FloatingTextStringOnCreature("Fillian's Brew activated on opc", oPC, FALSE);
      //FloatingTextStringOnCreature("Fillian's Brew activated on target", oTarget, FALSE);
      int iDice = d4(1);

      switch (iDice)
      {
      case 1:
       AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM, 1.0));
       break;
      case 2:
       AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 2.0));
       break;
      case 3:
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eKnockdown, oTarget,5.0 );
       FloatingTextStringOnCreature("Bleuuarghh", oTarget, FALSE);
       //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVom, oTarget,1.0 );
       break;
      case 4:
       AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM, 1.0));
       ApplyEffectToObject(DURATION_TYPE_INSTANT,eEyes, oTarget,2.0 );
      break;
     }
   }
}
