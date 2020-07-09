void main()
{
    object oPC=GetPCSpeaker();
    CreateItemOnObject("db_component",oPC,1);
    SetLocalInt(GetModule(),"vejoni_plot",15);
    //vejoni implicated, lucas told to turn himself in
}
