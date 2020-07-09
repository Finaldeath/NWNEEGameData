
void main()
{
    object oRender = GetObjectByTag("db_render");
    ChangeToStandardFaction(oRender, STANDARD_FACTION_DEFENDER);
    SetLocalInt(GetModule(),"render",2);
}
