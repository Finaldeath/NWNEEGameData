// Written By: B W-Husey
// 21/05/03
// Handles non Tag-based scripts i.e. those that only read part of a tag (virtue stones for example)
#include "x2_inc_itemprop"

void main()
{

 ExecuteScript("x2_mod_def_act",OBJECT_SELF);
 // General Initialization:  Find what item was used
  object oUsed = GetItemActivated();

     if (GetStringLeft(GetTag(oUsed),6) ==  "StoneV")
     {
    string sMod = GetStringRight(GetTag(oUsed),GetStringLength(GetTag(oUsed))-6);
    int nMod;
    if (sMod == "Fire") nMod = IP_CONST_DAMAGETYPE_FIRE;
    if (sMod == "Acid") nMod = IP_CONST_DAMAGETYPE_ACID;
    if (sMod == "Sonic") nMod = IP_CONST_DAMAGETYPE_SONIC;
    if (sMod == "Cold") nMod = IP_CONST_DAMAGETYPE_COLD;
    if (sMod == "Electrical") nMod = IP_CONST_DAMAGETYPE_ELECTRICAL;
    object oPC = GetItemActivator();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if (GetIsObjectValid(oWeapon))
    {
        if (GetSkillRank(SKILL_CRAFT_WEAPON,oPC)>10)
        {
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(nMod,2),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            GiveXPToCreature(oPC,150);
            FloatingTextStringOnCreature("XP Gain - weapon craft skill bonus",oPC,TRUE);
        }
        else if (GetSkillRank(SKILL_CRAFT_WEAPON,oPC)>0)
        {
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(nMod,1),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            GiveXPToCreature(oPC,50);
            FloatingTextStringOnCreature("XP Gain - weapon craft skill bonus",oPC,TRUE);
        }
        else
        {
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(nMod,1),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        }
    }
    else FloatingTextStringOnCreature("Weapon invalid/not equipped",oPC);
}

}

