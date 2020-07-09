void main()
{
    object oPC=GetPCSpeaker();
    CreateItemOnObject("db_component",oPC,1);
    SetLocalInt(GetModule(),"vejoni_plot",10);
    //vejoni implicated, lucas freed
}
