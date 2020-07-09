//a2_pm_impchest
#include "x2_inc_switches"

void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
      {
       object oPC = GetModuleItemLostBy();
       object oItem  = GetModuleItemLost();

       if (GetIsPC(oPC))
           {
           object oChest = CreateObject(OBJECT_TYPE_PLACEABLE,"pm_voice",GetLocation(oItem));
           //AssignCommand(oChest,ActionSpeakString("Don't leave me!"));
           int iDice = d3(1);
           switch (iDice)
           {
           case 1:
             DelayCommand(1.0,AssignCommand(oChest,ActionSpeakString("Please don't leave me!")));
             break;
           case 2:
             DelayCommand(1.0,AssignCommand(oChest,ActionSpeakString("Oh no! I've been left behind.")));
             break;
           case 3:
             DelayCommand(1.0,AssignCommand(oChest,ActionSpeakString("Dont Go! Please. Don't go.")));
             break;
           }
           }
      }

  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
      {
       object oItem = GetModuleItemAcquired();
       object oPC = GetItemPossessor(oItem);
       object oLostBy = GetModuleItemAcquiredFrom();

       if (GetIsPC(oPC))
           {
           object oChest = GetNearestObjectByTag("pm_voice",oPC);

           int iDice = d3(1);
           switch (iDice)
             {
             case 1:
               AssignCommand(oChest,ActionSpeakString("I knew you wouldn't leave me."));
               break;
             case 2:
               AssignCommand(oChest,ActionSpeakString("Thank you. You came back."));
               break;
             case 3:
               AssignCommand(oChest,ActionSpeakString("Can we see Delfen now?"));
              break;
             }
           //DelayCommand(1.0,AssignCommand(oChest,ActionSpeakString("I knew you wouldn't leave me.")));
           DestroyObject(oChest,3.0);
           }
      }
}

