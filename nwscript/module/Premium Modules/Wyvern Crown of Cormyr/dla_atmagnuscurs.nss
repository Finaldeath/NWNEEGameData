//February 2006
// B W-Husey
// Destroy cursed items on the PC
#include "nw_i0_plot"

void main()
{
ActionPauseConversation();
object oPC = GetPCSpeaker();
AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_REMOVE_CURSE,oPC,METAMAGIC_ANY,TRUE));
 TakeGoldFromCreature(100,oPC, FALSE);
int nDone; //XP tracker for whether a curse was removed
object oItem;
if (HasItem(oPC, "Frostbrand"))
    {
    oItem = GetItemPossessedBy(oPC,"Frostbrand");
    SetPlotFlag(oItem,FALSE);
    DestroyObject(oItem);
    nDone = 1;
    }
if (HasItem(GetPCSpeaker(), "CursedDagger"))
    {
    oItem = GetItemPossessedBy(oPC,"CursedDagger");
    SetPlotFlag(oItem,FALSE);
    DestroyObject(oItem);
    nDone = 1;
    }
if (HasItem(GetPCSpeaker(), "MorphionsCovet"))
    {
    oItem = GetItemPossessedBy(oPC,"MorphionsCovet");
    SetPlotFlag(oItem,FALSE);
    DestroyObject(oItem);
    nDone = 1;
    }
if (HasItem(GetPCSpeaker(), "GlovesofMis"))
    {
    oItem = GetItemPossessedBy(oPC,"GlovesofMis");
    SetPlotFlag(oItem,FALSE);
    DestroyObject(oItem);
    nDone = 1;
    }
//Give reward, J entry
         if (nDone == 1)
         {
          GiveXPToCreature (oPC, 100);
          FloatingTextStringOnCreature("XP Gained - curse removed",oPC);
            AddJournalQuestEntry("Cursed",3,oPC,TRUE);

         }
         else
         {
          FloatingTextStringOnCreature("No cursed items to remove",oPC);
         }
    DelayCommand(3.5,ActionResumeConversation());
}


