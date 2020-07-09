//player has solved orcs in the fields quest
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"fieldsquest")==1)
    return TRUE;
    return FALSE;
}
