// B W-Husey
// August 2005
// Checks the reflex save of the entering object else it slips.
// A tumble save or Dodge feat will reduce the floored time.
// PCs may get xp if they save the first time they enter the trigger, subsequent times they receive saving
// throw bonuses as they get used to the footing.
// Use the same tag on multiple triggers if you do not want additional xp bonuses.

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();

    //oozes don't slip. Trogs don't slip
    if (GetRacialType(oPC)== RACIAL_TYPE_OOZE) return;
    if (GetAppearanceType(oPC) == APPEARANCE_TYPE_TROGLODYTE
        || GetAppearanceType(oPC) == APPEARANCE_TYPE_TROGLODYTE_WARRIOR
        || GetAppearanceType(oPC) == APPEARANCE_TYPE_TROGLODYTE_CLERIC)
        return;

    int nAnim = ANIMATION_LOOPING_DEAD_FRONT;
    int nAnim2 = ANIMATION_LOOPING_DEAD_BACK;
    int nSlip = GetLocalInt(OBJECT_SELF,"SLIP_CHECK")-GetLocalInt(OBJECT_SELF,"nDone");
    if (nSlip < 2) nSlip == 2;
    //SLIP_CHECK is a variable on the trigger, the bonus is for how any times the PC has attempted this save.
    string sVariable = "Slip"+GetTag(OBJECT_SELF);

    if (ReflexSave(oPC,nSlip,SAVING_THROW_TYPE_TRAP)<1)
    { //Character failed saving throw
        AssignCommand( oPC, PlaySound("cb_ht_scale1"));
        AssignCommand( oPC,ClearAllActions()) ;
        if (GetSkillCheckSucceeded(oPC,SKILL_TUMBLE,14) || GetHasFeat(FEAT_DODGE,oPC) || GetHasFeat(FEAT_UNCANNY_DODGE_1,oPC))
        {//Tumble check succeeded/has dodge - reduce slip effects.
        AssignCommand(oPC,PlayAnimation(nAnim,1.0,2.0));
        DelayCommand(2.1,SetCommandable(TRUE,oPC));
        DelayCommand(0.1,SetCommandable(FALSE,oPC));
        FloatingTextStringOnCreature("Slipped - footing partially lost", oPC);
        if (GetHasFeat(FEAT_DODGE,oPC)) SendMessageToPC(oPC, "Dodge Feat reduces slip effects");
        else if (GetHasFeat(FEAT_UNCANNY_DODGE_1,oPC)) SendMessageToPC(oPC, "Uncanny Dodge feat reduces slip effects");
        }
        else
        {//Tumble check failed - full slip effects.
        AssignCommand(oPC,PlayAnimation(nAnim2,1.0,4.0));
        DelayCommand(4.1,SetCommandable(TRUE,oPC));
        DelayCommand(0.1,SetCommandable(FALSE,oPC));
        FloatingTextStringOnCreature("Slipped - footing lost", oPC);
        }
    }
    else
    {
        if (GetLocalInt(oPC,sVariable)<1 && GetLocalInt(OBJECT_SELF,"nDone")==0 && GetIsDefPC(oPC))
        { //PC saved. If this was their first attempt to do so and they succeed, gains xp.
             PartyGotEntry(sVariable,oPC,25,"XP gain - saved vs slipping");
        }
    }

    if (GetIsPC(oPC)==TRUE) //First time the NPC steps on this, set it to 1, so the xp cannot be gained again. Each subsequent time it grows - giving a saving throw bonus.
    {   //only when the PC 'learns', do other creatures 'learn' too (reduces number of variables by having only one, so creatures can't learn on behalf of the PC)
        if (nSlip>2)  SetLocalInt(OBJECT_SELF,"nDone",GetLocalInt(OBJECT_SELF,"nDone")+1);
    }
}


