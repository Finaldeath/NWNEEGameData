// November 2003
// B W-Husey
// Generic cure disease script - heals speaking PC. Costs 100 gold.
#include "cu_functions"
void main()
{
 //Set the variables
 object oPC = GetPCSpeaker();
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_REMOVE_DISEASE,oPC,METAMAGIC_NONE,TRUE));
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_REMOVE_DISEASE,ReturnHenchman(GetPCSpeaker(),1),METAMAGIC_NONE,TRUE));
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_REMOVE_DISEASE,ReturnHenchman(GetPCSpeaker(),2),METAMAGIC_NONE,TRUE));
 TakeGoldFromCreature(100,oPC, FALSE);
}

