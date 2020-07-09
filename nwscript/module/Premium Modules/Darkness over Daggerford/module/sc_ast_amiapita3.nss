//player has solved goblin kitchens quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"kitchenquest")==1 &&
    GetLocalInt(GetModule(), "amiapita3") !=1)
    return TRUE;
    return FALSE;
}
