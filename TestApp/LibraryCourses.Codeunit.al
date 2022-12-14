codeunit 50141 "CLIP Library - Courses"
{
    procedure CreateCourse() Course: Record "CLIP Course";
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
    begin
        CoursesNoSeriesSetup();
        LibraryERM.FindGeneralPostingSetupInvtFull(GeneralPostingSetup);
        LibraryERM.FindVATPostingSetupInvt(VATPostingSetup);

        Clear(Course);
        Course.Insert(true);
        Course.Validate(Name, Course."No.");  // Validate Name as No. because value is not important.
        Course.Validate(Price, LibraryRandom.RandDecInDecimalRange(100, 1000, 2));
        Course.Validate("Gen. Prod. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
        Course.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
        Course.Modify(true);
    end;

    internal procedure CreateCourseEdition(CourseNo: Code[20]) CourseEdition: Record "CLIP Course Edition"
    begin
        CourseEdition := CreateCourseEdition(CourseNo, 0);
    end;

    internal procedure CreateCourseEdition(CourseNo: Code[20]; MaxStudents: Integer) CourseEdition: Record "CLIP Course Edition"
    var
        LibraryRandom: Codeunit "Library - Random";
    begin
        CourseEdition.Init();
        CourseEdition.Validate("Course No.", CourseNo);
        CourseEdition.Validate(Edition, LibraryRandom.RandText(MaxStrLen(CourseEdition.Edition)));
        CourseEdition.Validate("Start Date", LibraryRandom.RandDateFrom(Today(), 90));
        if MaxStudents = 0 then
            CourseEdition.Validate("Max. Students", LibraryRandom.RandIntInRange(1, 10))
        else
            CourseEdition.Validate("Max. Students", MaxStudents);
        CourseEdition.Insert(true);
    end;

    local procedure CoursesNoSeriesSetup()
    var
        CoursesSetup: Record "CLIP Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        if not CoursesSetup.Get() then
            CoursesSetup.Insert();
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}