// if haven't finished conversation 1

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "kresh_story_index") > 0) return FALSE;

    return TRUE;
}
