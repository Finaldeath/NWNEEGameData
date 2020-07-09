// April 2006
// B W-Husey
// On entering the trigger, Lacinda casts a light spell on herself (regardless of whether she has one).

void main()
{
    object oLac = GetEnteringObject();
    //Check if it's Lacinda, and if so do cast the spell
    if (GetTag(oLac)=="Lacinda" && GetLocalInt(OBJECT_SELF,"nFired")<1)
    {
        AssignCommand(oLac,ClearAllActions());
        AssignCommand(oLac,ActionCastSpellAtObject(SPELL_LIGHT,OBJECT_SELF,METAMAGIC_ANY,TRUE,5));
        SetLocalInt(OBJECT_SELF,"nFired",1);
        DestroyObject(OBJECT_SELF,2.2);
    }
}
