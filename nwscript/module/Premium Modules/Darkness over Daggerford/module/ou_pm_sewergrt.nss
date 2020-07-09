//////////////////////////////////////////////////////
//ou_pm_sewergrt
//to be placed on the on used event of the sewer grate to give feedback or allow use.
//////////////////////////////////////////////////////
void main()
{
    if ((GetTag(OBJECT_SELF) == "C1AR0500_CAR0503_EXIT" && GetLocalInt(GetModule(),"pm_bugo_letter"))
        ||(GetTag(OBJECT_SELF) == "pm_C1AR0100_C1AR0115" && GetLocalInt(GetModule(),"pm_endgame_start")))
        ExecuteScript("c3t_ff_transport",OBJECT_SELF);
    else
        ExecuteScript("hf_pl_examine",OBJECT_SELF);
}
