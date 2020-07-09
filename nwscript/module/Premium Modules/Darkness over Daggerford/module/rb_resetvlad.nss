void main()
{
    SetLocalInt(GetPCSpeaker(), "ac_vlad_paint_quest", 0);
    SetLocalInt(GetPCSpeaker(), "ac_davey_quest", 0);
    SetLocalInt(GetPCSpeaker(), "hallerans_ool", 0);
    SetLocalInt(GetObjectByTag("pm_vladmyr"),"has_met_pc", 0);
    SetLocalInt(GetObjectByTag("pm_vladmyr"), "this_node_once", 0);
}
