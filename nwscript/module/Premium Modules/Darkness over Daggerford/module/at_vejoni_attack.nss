//vejoni attack routine
//Damian Brown (Luspr)
//30th Oct 2005
#include "nw_i0_2q4luskan"
#include "NW_I0_GENERIC"
void main()
{
    SetLocalInt(GetModule(), "vejoni_plot", 25);

    //blow the statues sky high and bring on the dancing gargoyles!
    effect eMind = EffectVisualEffect(VFX_IMP_HOLY_AID);
    object oStatue1=GetObjectByTag("trap_statue1");
    object oStatue2=GetObjectByTag("trap_statue2");
    object oStatue3=GetObjectByTag("trap_statue3");
    object oStatue4=GetObjectByTag("trap_statue4");
    object oGargoyle1 = CreateObject(OBJECT_TYPE_CREATURE, "db_strangeg", GetLocation(oStatue1));
    object oGargoyle2 = CreateObject(OBJECT_TYPE_CREATURE, "db_strangeg", GetLocation(oStatue2));
    object oGargoyle3 = CreateObject(OBJECT_TYPE_CREATURE, "db_strangeg", GetLocation(oStatue3));
    object oGargoyle4 = CreateObject(OBJECT_TYPE_CREATURE, "db_strangeg", GetLocation(oStatue4));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oGargoyle1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oGargoyle2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oGargoyle3);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oGargoyle4);
    SetPlotFlag(oStatue1, FALSE);
    SetPlotFlag(oStatue2, FALSE);
    SetPlotFlag(oStatue3, FALSE);
    SetPlotFlag(oStatue4, FALSE);
    DestroyObject(oStatue1, 0.5);
    DestroyObject(oStatue2, 0.5);
    DestroyObject(oStatue3, 0.5);
    DestroyObject(oStatue4, 0.5);
    //vejoni reveals his true form and it's not pleasant (for the PC at least)
    object oVejoni=GetObjectByTag("db_vejoni");
    string sVejoni=("db_vejoni_true");
    location lVejoni=GetLocation(oVejoni);
    effect eTrans1=EffectVisualEffect(VFX_FNF_PWKILL);
    effect eTrans2=EffectVisualEffect(VFX_IMP_POLYMORPH);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTrans1,lVejoni);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTrans2,lVejoni);
    DelayCommand(0.3,CreateObjectVoid(OBJECT_TYPE_CREATURE,sVejoni,lVejoni,FALSE));
    DestroyObject(oVejoni,0.4);
    PlaySound("c_rakshasa_bat1");
    object oVejoniTrue=GetNearestObjectByTag(sVejoni);
    object oPC=GetPCSpeaker();
    AssignCommand(oVejoniTrue,DetermineCombatRound(oPC));
}
