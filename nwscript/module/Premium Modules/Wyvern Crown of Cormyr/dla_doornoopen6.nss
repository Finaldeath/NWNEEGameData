// B G P Hughes (B W-Huesy)
// August 2005
// For doors that are not meant to be opened. Dragon's den calls the nearest Purple Dragon
void main()
{
    object oSpeaker = GetNearestObjectByTag("Purple");
    AssignCommand(GetClickingObject(),ActionStartConversation(oSpeaker,"doornoopen6"));
}
