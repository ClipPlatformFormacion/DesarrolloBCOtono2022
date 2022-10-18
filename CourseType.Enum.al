enum 50100 "CLIP Course Type"
{
    Extensible = true;
    Caption = 'Course Type', Comment = 'ESP="Tipo curso"';

    value(0; " ")
    {
        Caption = ' ', Comment = 'ESP=" "';
    }
    value(1; "Instructor-Lead")
    {
        Caption = 'Intructor-Lead', Comment = 'ESP="Guiado"';
    }
    value(2; "Video Tutorial")
    {
        Caption = 'Video Tutorial', Comment = 'ESP="Vídeo tutorial"';
    }
}