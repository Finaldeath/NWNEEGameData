//::///////////////////////////////////////////////
//:: FileName con_ac_peredus3
//:: Underground passage now accessible and Peredus disappears.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:11:57 AM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_peredus", 3);

object oC = GetObjectByTag("ac_peredus");
location l1 = GetLocation(oC);
effect eD = EffectDisappear(2);
DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eD,oC));
effect eE = EffectVisualEffect(VFX_IMP_DISPEL);
DelayCommand(2.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eE,l1));
GiveXPToCreature(GetPCSpeaker(),600);
}
