// can this portal in edalseye's tower be used to go down?

int StartingConditional()
{
    string sDestVar = GetLocalString(OBJECT_SELF, "DESTINATION_DOWN");
    return (sDestVar != "");
}
