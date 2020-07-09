//End game outro cinematic when player leaves temple, having allowed the
//Zhentarim to execute Maganus, and rejecting the offer from Fzoul

void main()
{
    ExportSingleCharacter(GetFirstPC());
    EndGame("tyrants_outro1");
}
