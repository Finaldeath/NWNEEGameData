//Allow illusion to be dispelled if Dispel Magic cast in vicinity
void main()
{
    int nSpell = GetLastSpell();

    if(nSpell == SPELL_DISPEL_MAGIC || nSpell == SPELL_GREATER_DISPELLING)
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(4500));
    }
}
