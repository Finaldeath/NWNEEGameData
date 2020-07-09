// return true if we are speaking with another PC, but the PC didn't start the dialog
int StartingConditional()
{
    if (!GetIsObjectValid(GetPCSpeaker()))
    {
        object oTarget = GetLocalObject(OBJECT_SELF, "HF_DIALOG_TARGET");
        return(GetIsPC(oTarget));
    }
    return(FALSE);
}
