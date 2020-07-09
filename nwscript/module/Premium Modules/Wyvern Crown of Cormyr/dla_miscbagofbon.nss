// B W-Husey
// August 2005
// This script executes the effects of the Bag of Bones when thrown by an NPC.
// The NPC doesn't actually throw the bones (there's no UseItem()), but the action
// is simulated instead in his perceive event.

void ActionCreate(string oCreature,location lLoc, effect eSummon)
{
    object oNew = CreateObject(OBJECT_TYPE_CREATURE,oCreature,lLoc,FALSE);
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon,oNew));
}

void main()
{
            effect e1 = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            effect e2 = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
            effect e3 = EffectVisualEffect(VFX_DUR_CALTROPS);
            object oTarget = GetFirstPC();
            ActionCreate("boneskel2",GetLocation(oTarget),e1);
            ActionCreate("boneskel2",GetLocation(oTarget),e1);
            ActionCreate("boneskel2",GetLocation(oTarget),e1);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,e3,GetLocation(oTarget),3.0);

}
