// can this portal in edalseye's tower be used to go up?

int StartingConditional()
{
    string sDestVar = GetLocalString(OBJECT_SELF, "DESTINATION_UP");
    return (sDestVar != "");
}
