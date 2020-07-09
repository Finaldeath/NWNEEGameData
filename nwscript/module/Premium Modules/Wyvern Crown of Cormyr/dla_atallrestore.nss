// August 2003
// B W-Husey
// Generic restoration script - restores speaking PC. Costs 150 gold.

#include "cu_functions"
void main()
{
 //Set the variables
 object oPC = GetPCSpeaker();
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_RESTORATION,oPC,METAMAGIC_NONE,TRUE));
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_RESTORATION,ReturnHenchman(GetPCSpeaker(),1),METAMAGIC_NONE,TRUE));
 AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_RESTORATION,ReturnHenchman(GetPCSpeaker(),2),METAMAGIC_NONE,TRUE));
 TakeGoldFromCreature(150,oPC, FALSE);
}

