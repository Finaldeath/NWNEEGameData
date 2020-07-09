
void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == TRUE && GetLocalInt(OBJECT_SELF, "do_once") !=1)
    {
        AssignCommand(oPC,SpeakString("This room is in a disgusting state with garbage and waste littered about the cold stone floor."));
        SetLocalInt(OBJECT_SELF, "do_once", 1);
    }
}
