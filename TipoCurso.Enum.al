enum 50100 "Course Type"
{
    Extensible = true;
    CaptionML = ENU = 'Course Type', ESP = 'Tipo curso';

    value(0; " ")
    {
        CaptionML = ENU = ' ', ESP = ' ';
    }
    value(1; "Instructor-Lead")
    {
        CaptionML = ENU = 'Intructor-Lead', ESP = 'Guiado';
    }
    value(2; "Video Tutorial")
    {
        CaptionML = ENU = 'Video Tutorial', ESP = 'Vídeo tutorial';
    }
}