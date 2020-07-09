// October 2005
// B W-Husey
// Placed on a ballista on used event, this makes the ballista fire at the first live enemy it finds, either a bolt or
// a flame arrow spell. The distance this fires is set by the GetFirstObjectInShape fSize parameter.
// Someone actually needs to use the ballista to fire it, and it only fires forwards.
// Change vVector if you want to change the direction of fire. This one fires south.

#include "x0_i0_projtrap"

void main()
{
    object oPC = GetLastUsedBy();
    int nOnce = 0;
    vector vOrigin = GetPosition(OBJECT_SELF);
    vector vOffset = Vector(0.0,-40.0);
    vector vTarget=vOrigin+vOffset;
    location lOrigin;
    lOrigin = Location(GetArea(oPC),vTarget,GetFacing(oPC));
    effect eEffect= EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 40.0, lOrigin ,TRUE,OBJECT_TYPE_CREATURE,vOrigin);

    if (GetLocalInt(OBJECT_SELF,"nReady")==1)
    FloatingTextStringOnCreature("Reloading",oPC,TRUE);
    else
    {
    //Cycle through the targets within the shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget) && nOnce == 0)
    {
       if(GetIsEnemy(oTarget,oPC)&&GetIsDead(oTarget)!=TRUE)
       {
       int nRand = Random (3);
       PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
       if (nRand == 1) ActionCastSpellAtObject(SPELL_FLAME_ARROW, oTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT);
       else ActionCastSpellAtObject(794, oTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT);
//       TriggerProjectileTrap(SPELL_ACID_FOG, oTarget, 7, OBJECT_SELF, OBJECT_SELF,PROJECTILE_PATH_TYPE_DEFAULT);
        SetLocalInt(OBJECT_SELF, "nReady", 1);      //stops ballista being fired again for 5 seconds, not a prob for NPCs, but a PC might fire dozens of times.
        DelayCommand(5.0, SetLocalInt(OBJECT_SELF, "nReady", 0));
        nOnce = 1;
       }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 50.0, lOrigin ,TRUE,OBJECT_TYPE_CREATURE,vOrigin);
    }
    }
}



