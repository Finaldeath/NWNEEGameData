// January 2006
// B W-Husey
// Used to detect if the correct keystone has been added or removed.
#include "x0_i0_petrify"
#include "cu_functions"
void main()
{
     //Identify who disturbed the inventory, and which pedestal this is.
     object oPC = GetLastDisturbed();
     string sIAm = GetStringRight(GetTag(OBJECT_SELF),1);
     int nIAm = StringToInt(sIAm);
     object oItem = GetInventoryDisturbItem();
     string sKey = GetTag(oItem);
     string sKeyNum = GetStringRight(sKey,1);
    //Declare all the beam effects
    object oShoot1 = OBJECT_SELF;
    object oTarget1 = oPC;
    object oTarget2 = GetObjectByTag("CrystalPedestal");
    effect eBeam;
    effect eDam;
    effect eReset = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    switch(nIAm) //Beam look/damage is dependant on pedestal
    {
        case 1:
        eBeam = EffectBeam(VFX_BEAM_HOLY, oShoot1, BODY_NODE_CHEST);
        eDam = EffectDamage(2*d12(),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_PLUS_THREE);
        break;
        case 2:
        eBeam = EffectBeam(VFX_BEAM_BLACK, oShoot1, BODY_NODE_CHEST);
        eDam = EffectDamage(2*d12(),DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_PLUS_THREE);
        break;
        case 3:
        eBeam = EffectBeam(VFX_BEAM_ODD, oShoot1, BODY_NODE_CHEST);
        eDam = EffectDamage(2*d12(),DAMAGE_TYPE_SONIC,DAMAGE_POWER_PLUS_THREE);
        break;
    }


    //If we removed an object, remove the beam effects if it was the key.
    // This removes all beam effects, resets counter, and applies a visual cue to all pedestals
    // so player understands they reset the puzzle.
    if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_REMOVED)
    {
        if (GetStringLeft(sKey,8) =="Keystone" && StringToInt(sKeyNum)== nIAm)
        RemoveEffectOfType(oTarget2,EFFECT_TYPE_BEAM);
        AllParty("nKeysOn",oPC,0); //key removed, decrement counter
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eReset,GetObjectByTag("CWPPed1"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eReset,GetObjectByTag("CWPPed2"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eReset,GetObjectByTag("CWPPed3"));
        if (GetLocalInt(oPC,"nKeysOn")<3) SetLocked(oTarget2,TRUE);
    }
    else if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_ADDED)
    {
        if (GetStringLeft(sKey,8) =="Keystone" && StringToInt(sKeyNum)== nIAm) //added the key
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oTarget2);
            AllParty("nKeysOn",oPC,GetLocalInt(oPC,"nKeysOn")+1);//note that a correct key is in a pedestal
            if (GetLocalInt(oPC,"nKeysOn")==3)
            {
                SetLocked(oTarget2,FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eReset,oTarget2);
            }
        }
        else
        {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget1,0.5);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget1);
        }
    }
}

