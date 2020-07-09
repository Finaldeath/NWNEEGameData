void main()
{
   object oTarget=GetItemActivatedTarget();
   effect eEffect;
   if (!GetIsPC(oTarget)&&GetIsObjectValid(oTarget)&&GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
   { //  valid target
       if (GetIsDead(oTarget))
       { // ressurrect the NPC
           eEffect=EffectResurrection();
           ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oTarget);
           AssignCommand(oTarget,ClearAllActions(TRUE));
           AssignCommand(oTarget,ActionCastSpellAtObject(SPELL_GREATER_RESTORATION,oTarget,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
       } // ressurrect the NPC
       else
       { // kill them
           eEffect=EffectDamage(GetMaxHitPoints(oTarget));
           ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oTarget);
       } // kill them
   } //  valid target
}
