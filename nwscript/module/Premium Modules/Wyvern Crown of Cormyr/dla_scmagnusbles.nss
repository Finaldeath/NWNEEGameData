// February 2006
// B W-Husey
//:: FileName dla_scmagnusbles
// Same as the standard Var sc script but checks also for a new grave
int StartingConditional()
{

    // Inspect local variables
    string sName = "Var3"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before

   if(!(GetLocalInt(GetPCSpeaker(), "nNoGrave") == 2))
    nOnce=TRUE;

    if(nOnce==FALSE)
        {
        return TRUE;
        }
    return FALSE;     //do not allow this conversation branch if done before

}
