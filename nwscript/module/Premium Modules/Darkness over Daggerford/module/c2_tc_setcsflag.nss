
void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    string sName = GetName(OBJECT_SELF);
    //run through the default area transition stuff
    SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
    AssignCommand(oClicker,JumpToObject(oTarget));

    if (GetLocalInt(OBJECT_SELF, "do_once")!=1  &&
        GetLocalInt(GetModule(),"the_blackstone_inn")==2) //PC has last journal entry
        {
            SetLocalInt(OBJECT_SELF, "do_once", 1);
            SetLocalString(oClicker, "cs_gate_used",sName);
        }
}
