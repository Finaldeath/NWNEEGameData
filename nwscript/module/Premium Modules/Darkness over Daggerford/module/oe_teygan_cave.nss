void main()
{
    object oTeygan=GetObjectByTag("Teygan");
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC)&&!GetLocalInt(OBJECT_SELF,"DO_ONCE")==1)
    {
       //paralyze the pc, move teygan to pc
       //and start his conversation
       AssignCommand(oPC, ClearAllActions(TRUE));
       effect eEffect = EffectCutsceneParalyze();
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);
       AssignCommand(oTeygan, ClearAllActions());
       AssignCommand(oTeygan,ActionForceMoveToObject(oPC));
       DelayCommand(2.0,AssignCommand(oTeygan, ActionStartConversation(oPC)));
       SetLocalInt(OBJECT_SELF,"DO_ONCE",1);
    }
}
