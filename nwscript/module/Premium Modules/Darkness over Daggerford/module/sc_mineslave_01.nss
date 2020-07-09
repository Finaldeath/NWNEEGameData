// choose a random convo for this slave and always use it

int StartingConditional()
{
    // pick a convo if we haven't already done so
    int nConvo = GetLocalInt(OBJECT_SELF, "nConvoType");
    if (nConvo == 0)
    {
        int nConvo = d6();
        SetLocalInt(OBJECT_SELF, "HF_ARG", nConvo);
    }

    // is this convo type 1?
    return(nConvo == 1);
}
