//player has solved orcs in the fields quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"fieldsquest")==1 &&
    GetLocalInt(GetModule(), "amiapita2") !=1)
    return TRUE;
    return FALSE;
}
