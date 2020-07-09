// has the player dropped the eggs somewhere in the chief's hut?

int StartingConditional()
{
    object oMod = GetModule();
    return(GetLocalInt(oMod, "nDragonEggsDelivered"));
}
